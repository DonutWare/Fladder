import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class ReleaseInfo {
  final String version;
  final String changelog;
  final String url;
  final bool isNewerThanCurrent;
  final Map<String, String> downloads;

  ReleaseInfo({
    required this.version,
    required this.changelog,
    required this.url,
    required this.isNewerThanCurrent,
    required this.downloads,
  });

  String? downloadUrlFor(String platform) => downloads[platform];

  Map<String, String> get preferredDownloads {
    final group = _platformGroup();
    final entries = downloads.entries.where((e) => e.key.contains(group));
    return Map.fromEntries(entries);
  }

  Map<String, String> get otherDownloads {
    final group = _platformGroup();
    final entries = downloads.entries.where((e) => !e.key.contains(group));
    return Map.fromEntries(entries);
  }

  String _platformGroup() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.linux:
        return 'linux';
      default:
        return '';
    }
  }
}

extension DownloadLabelFormatter on String {
  String prettifyKey() {
    final parts = split('_');
    if (parts.isEmpty) return this;

    final base = parts.first.capitalize();
    if (parts.length == 1) return base;

    final variant = parts.sublist(1).join(' ').capitalize();
    return '$base ($variant)';
  }

  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

class UpdateChecker {
  final String owner = 'DonutWare';
  final String repo = 'Fladder';

  Future<List<ReleaseInfo>> fetchRecentReleases({int count = 5}) async {
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;

    final url = Uri.parse('https://api.github.com/repos/$owner/$repo/releases?per_page=$count');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      print('Failed to fetch releases: ${response.statusCode}');
      return [];
    }

    final List<dynamic> releases = jsonDecode(response.body);
    
    // Filter out pre-releases (nightly builds) and only process stable releases
    // This prevents nightly builds from triggering update notifications
    final stableReleases = releases.where((release) {
      final isPrerelease = release['prerelease'] as bool? ?? false;
      final tagName = release['tag_name'] as String? ?? '';
      final isDraft = release['draft'] as bool? ?? false;
      
      // Exclude pre-releases, drafts, and any release with "nightly" in the tag
      // This ensures users only get notified about stable releases
      return !isPrerelease && !isDraft && !tagName.toLowerCase().contains('nightly');
    }).toList();
    
    return stableReleases.map((json) {
      final tag = (json['tag_name'] as String?)?.replaceFirst(RegExp(r'^v'), '');
      final changelog = json['body'] as String? ?? '';
      final htmlUrl = json['html_url'] as String? ?? '';
      final assets = json['assets'] as List<dynamic>? ?? [];

      final Map<String, String> downloads = {};
      for (final asset in assets) {
        final name = asset['name'] as String? ?? '';
        final downloadUrl = asset['browser_download_url'] as String? ?? '';

        if (name.contains('Android') && name.endsWith('.apk')) {
          downloads['android'] = downloadUrl;
        } else if (name.contains('iOS') && name.endsWith('.ipa')) {
          downloads['ios'] = downloadUrl;
        } else if (name.contains('Windows') && name.endsWith('Setup.exe')) {
          downloads['windows_installer'] = downloadUrl;
        } else if (name.contains('Windows') && name.endsWith('.zip')) {
          downloads['windows_portable'] = downloadUrl;
        } else if (name.contains('macOS') && name.endsWith('.dmg')) {
          downloads['macos'] = downloadUrl;
        } else if (name.contains('Linux') && name.endsWith('.AppImage')) {
          downloads['linux_appimage'] = downloadUrl;
        } else if (name.contains('Linux') && name.endsWith('.flatpak')) {
          downloads['linux_flatpak'] = downloadUrl;
        } else if (name.contains('Linux') && name.endsWith('.zip')) {
          downloads['linux_zip'] = downloadUrl;
        } else if (name.contains('Linux') && name.endsWith('.zsync')) {
          downloads['linux_zsync'] = downloadUrl;
        } else if (name.contains('Web') && name.endsWith('.zip')) {
          downloads['web'] = downloadUrl;
        }
      }

      bool isNewer = tag != null && _compareVersions(tag, currentVersion) > 0;

      return ReleaseInfo(
        version: tag ?? 'unknown',
        changelog: changelog.trim(),
        url: htmlUrl,
        isNewerThanCurrent: isNewer,
        downloads: downloads,
      );
    }).toList();
  }

  Future<bool> isUpToDate() async {
    final releases = await fetchRecentReleases(count: 1);
    if (releases.isEmpty) return true;
    return !releases.first.isNewerThanCurrent;
  }

  static int _compareVersions(String a, String b) {
    // Remove any "v" prefix and split by major.minor.patch
    final cleanA = a.replaceFirst(RegExp(r'^v'), '');
    final cleanB = b.replaceFirst(RegExp(r'^v'), '');
    
    // Split on both '.' and '-' to separate version parts from pre-release identifiers
    final aParts = cleanA.split(RegExp(r'[.-]'));
    final bParts = cleanB.split(RegExp(r'[.-]'));
    
    // Get the main version numbers (first 3 parts: major.minor.patch)
    final aVersionParts = aParts.take(3).map(int.tryParse).toList();
    final bVersionParts = bParts.take(3).map(int.tryParse).toList();
    
    // Compare main version numbers first
    for (var i = 0; i < 3; i++) {
      final aVal = i < aVersionParts.length ? (aVersionParts[i] ?? 0) : 0;
      final bVal = i < bVersionParts.length ? (bVersionParts[i] ?? 0) : 0;
      if (aVal != bVal) return aVal.compareTo(bVal);
    }
    
    // If main versions are equal, check for pre-release identifiers
    final aHasPrerelease = aParts.length > 3 && aParts.any((part) => 
        part.contains('nightly') || part.contains('alpha') || part.contains('beta') || part.contains('rc'));
    final bHasPrerelease = bParts.length > 3 && bParts.any((part) => 
        part.contains('nightly') || part.contains('alpha') || part.contains('beta') || part.contains('rc'));
    
    // If one has pre-release and the other doesn't, the stable version is newer
    if (aHasPrerelease && !bHasPrerelease) return -1;
    if (!aHasPrerelease && bHasPrerelease) return 1;
    
    // Both are the same type (stable or pre-release), so they're equal
    return 0;
  }
}
