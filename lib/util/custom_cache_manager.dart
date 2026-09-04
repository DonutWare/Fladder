import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';
  static const largeArtKey = 'customCacheKeyLargeArt';
  static const shortLivedKey = 'customCacheKeyShortLived';

  /// Posters, logos and avatars. Keys embed Jellyfin's image tag, so a changed
  /// image always gets a new key and long retention is safe.
  static final Config _posterConfig = Config(
    key,
    stalePeriod: const Duration(days: 60),
    maxNrOfCacheObjects: 5000,
    fileService: HttpFileService(),
  );

  /// Backdrops, thumbs and original-size images. Kept apart so a few large
  /// files cannot evict thousands of posters.
  static final Config _largeArtConfig = Config(
    largeArtKey,
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 250,
    fileService: HttpFileService(),
  );

  /// Images whose cache key carries no image tag: chapter images and Seerr
  /// provider logos. A changed image reuses the same key, so they are held in
  /// their own store to cap how much disk untagged art can occupy and to give
  /// entries that fall out of use a shorter window than tag-addressed art.
  static final Config _shortLivedConfig = Config(
    shortLivedKey,
    stalePeriod: const Duration(days: 14),
    maxNrOfCacheObjects: 1000,
    fileService: HttpFileService(),
  );

  static CacheManager instance = CacheManager(_posterConfig);
  static CacheManager largeArt = CacheManager(_largeArtConfig);
  static CacheManager shortLived = CacheManager(_shortLivedConfig);

  static List<MapEntry<CacheManager, Config>> get _stores => [
        MapEntry(instance, _posterConfig),
        MapEntry(largeArt, _largeArtConfig),
        MapEntry(shortLived, _shortLivedConfig),
      ];

  /// Empties every store, including the files on disk.
  ///
  /// [CacheManager.emptyCache] alone is not enough: flutter_cache_manager 3.4.1
  /// resolves `CacheObject.relativePath` against the working directory when
  /// deleting, so it only removes index rows and leaves every file behind.
  /// Returns false if anything could not be removed, so the caller can say so
  /// rather than reporting success. A file being written to right now cannot be
  /// deleted on Windows, and one locked store must not stop the others.
  static Future<bool> clearAll() async {
    var complete = true;
    for (final entry in _stores) {
      // Per store, and with a timeout: an index whose open failed or never
      // completed must not abort clearing the others, which is the part that
      // actually frees disk.
      try {
        await entry.key.emptyCache().timeout(const Duration(seconds: 20));
      } catch (e) {
        complete = false;
        debugPrint('Could not empty image cache index ${entry.value.cacheKey}: $e');
      }
    }
    if (kIsWeb) return complete;
    for (final entry in _stores) {
      try {
        final dir = await _storeDirectory(entry.value);
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
      } catch (e) {
        complete = false;
        debugPrint('Could not delete image cache store ${entry.value.cacheKey}: $e');
      }
    }
    return complete;
  }

  /// Deletes files in the store directories that the index no longer references.
  ///
  /// Because of the deletion bug described on [clearAll], every file the cache
  /// evicts is otherwise left on disk forever. Files younger than a day are kept,
  /// since a download may be in flight and not yet indexed.
  static Future<void> removeOrphanedFiles() async {
    if (kIsWeb) return;
    try {
      final cutoff = DateTime.now().subtract(const Duration(days: 1));
      for (final entry in _stores) {
        // Per store, so one unreadable index cannot skip the others.
        try {
          final dir = await _storeDirectory(entry.value);
          if (!await dir.exists()) continue;
          final referenced = await _indexedFileNames(entry.key, entry.value);
          await for (final entity in dir.list()) {
            if (entity is! File) continue;
            if (referenced.contains(_fileName(entity.path))) continue;
            if ((await entity.lastModified()).isAfter(cutoff)) continue;
            await entity.delete();
          }
        } catch (e) {
          debugPrint('Image cache orphan sweep skipped ${entry.value.cacheKey}: $e');
        }
      }
    } catch (e) {
      debugPrint('Image cache orphan sweep failed: $e');
    }
  }

  /// Where the store keeps its files; mirrors flutter_cache_manager's IOFileSystem.
  static Future<Directory> _storeDirectory(Config config) async {
    final tempDir = await getTemporaryDirectory();
    return Directory('${tempDir.path}${Platform.pathSeparator}${config.cacheKey}');
  }

  /// File names the store's index references, read through the store's own
  /// repository so it is correct on every platform (sqflite on Android, iOS and
  /// macOS; a JSON file elsewhere).
  ///
  /// Waits on the manager's own [CacheStore] rather than calling `open()` here:
  /// `open()` is reference counted through a completer that only the first
  /// caller completes, so opening it a second time could wait forever. If that
  /// first open failed the wait does not complete either, so the timeout is
  /// what turns a failed or wedged store into a caught error.
  static Future<Set<String>> _indexedFileNames(CacheManager manager, Config config) async {
    await manager.store.retrieveCacheData('cacheOrphanSweepProbe').timeout(const Duration(seconds: 20));
    final objects = await config.repo.getAllObjects();
    return {for (final object in objects) _fileName(object.relativePath)};
  }

  static String _fileName(String path) => path.split(RegExp(r'[\\/]')).last;
}
