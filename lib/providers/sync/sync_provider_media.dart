import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/string_extensions.dart';

extension SyncMediaHelpers on SyncNotifier {
  Future<List<SubStreamModel>> saveExternalSubtitles(List<SubStreamModel>? subtitles, SyncedItem item) async {
    if (subtitles == null) return [];

    final directory = item.directory;

    await directory.create(recursive: true);

    return Stream.fromIterable(subtitles).asyncMap((element) async {
      final canDownload = element.isExternal || (element.supportsExternalStream && element.url != null);
      if (canDownload) {
        try {
          final response = await http.get(Uri.parse(element.url!));
          if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
            final ext = subtitleExtension(element.codec);
            final file = File(path.joinAll([directory.path, "${element.displayTitle}.${element.language}.$ext"]));
            file.writeAsBytesSync(response.bodyBytes);
            return element.copyWith(
              url: () => file.path,
              isExternal: true,
            );
          }
        } catch (e) {
          log('Failed to download subtitle: ${element.displayTitle} - $e');
        }
      }
      return element;
    }).toList();
  }

  // Map codec to subtitle file extension, defaulting to .srt if unknown
  String subtitleExtension(String codec) {
    return switch (codec.toLowerCase()) {
      'ass' => 'ass',
      'ssa' => 'ssa',
      'subrip' || 'srt' => 'srt',
      'webvtt' || 'vtt' => 'vtt',
      'sub' || 'microdvd' => 'sub',
      'pgs' || 'pgssub' => 'sup',
      _ => 'srt',
    };
  }

  Future<TrickPlayModel?> saveTrickPlayData(ItemBaseModel? item, Directory saveDirectory) async {
    if (item == null) return null;
    final trickPlayDirectory = Directory(path.joinAll([saveDirectory.path, SyncedItem.trickPlayPath]))
      ..createSync(recursive: true);
    final trickPlayData = await api.getTrickPlay(item: item, ref: ref);
    final List<String> newStringList = [];

    for (var index = 0; index < (trickPlayData?.body?.images.length ?? 0); index++) {
      final image = trickPlayData?.body?.images[index];
      if (image != null) {
        final http.Response response = await http.get(Uri.parse(image));
        File? newFile;
        final fileName = "tile_$index.jpg";
        if (response.statusCode == 200) {
          final Uint8List bytes = response.bodyBytes;
          newFile = File(path.joinAll([trickPlayDirectory.path, fileName]));
          await newFile.writeAsBytes(bytes);
        }
        if (newFile != null && await newFile.exists()) {
          newStringList.add(path.joinAll(['TrickPlay', fileName]));
        }
      }
    }
    return trickPlayData?.body?.copyWith(images: newStringList.toList());
  }

  Future<ImagesData?> saveImageData(ImagesData? data, Directory saveDirectory) async {
    if (data == null) return data;
    if (!saveDirectory.existsSync()) return data;

    final primary = await urlDataToFileData(data.primary, saveDirectory, "primary.jpg");
    final logo = await urlDataToFileData(data.logo, saveDirectory, "logo.jpg");
    final backdrops = await Stream.fromIterable(data.backDrop ?? <ImageData>[])
        .asyncMap((element) async => await urlDataToFileData(element, saveDirectory, "backdrop-${element.key}.jpg"))
        .toList();

    return data.copyWith(
      primary: () => primary,
      logo: () => logo,
      backDrop: () => backdrops.nonNulls.toList(),
    );
  }

  Future<List<Chapter>?> saveChapterImages(List<Chapter>? data, Directory itemPath) async {
    if (data == null) return data;
    if (!itemPath.existsSync()) return data;
    if (data.isEmpty) return data;
    final saveDirectory = Directory(path.joinAll([itemPath.path, SyncedItem.chaptersPath]));

    await saveDirectory.create(recursive: true);

    final saveChapters = await Stream.fromIterable(data).asyncMap((event) async {
      if (event.imageUrl.isEmpty) return event;

      final safeName = event.name.sanitizedFileName;
      final fileName = '$safeName.jpg';

      try {
        final response = await http.get(Uri.parse(event.imageUrl));
        if (response.statusCode != 200 || response.bodyBytes.isEmpty) return event;

        final file = File(path.joinAll([saveDirectory.path, fileName]));
        await file.parent.create(recursive: true);
        await file.writeAsBytes(response.bodyBytes);

        return event.copyWith(
          imageUrl: path.joinAll([SyncedItem.chaptersPath, fileName]),
        );
      } catch (e, stackTrace) {
        FladderSnack.showException(e, stackTrace: stackTrace);
        return event;
      }
    }).toList();

    return saveChapters.nonNulls.toList();
  }

  Future<ImageData?> urlDataToFileData(ImageData? data, Directory directory, String fileName) async {
    if (data?.path == null) return null;
    final response = await http.get(Uri.parse(data?.path ?? ""));

    final file = File(path.joinAll([directory.path, fileName]));
    file.writeAsBytesSync(response.bodyBytes);

    return data?.copyWith(path: fileName);
  }
}
