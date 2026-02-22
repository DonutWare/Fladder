import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/util/string_extensions.dart';

part 'application_info.freezed.dart';

final applicationInfoProvider = StateProvider<ApplicationInfo>((ref) {
  return ApplicationInfo(
    name: "",
    version: "",
    buildNumber: "",
    platform: defaultTargetPlatform,
  );
});

@Freezed(toJson: false, fromJson: false)
abstract class ApplicationInfo with _$ApplicationInfo {
  const ApplicationInfo._();

  factory ApplicationInfo({
    required String name,
    required String version,
    required String buildNumber,
    required TargetPlatform platform,
  }) = _ApplicationInfo;

  String get platformLabel {
    final leanbackMode = leanBackMode;
    final label = platform.name.capitalize();
    return switch (platform) {
      TargetPlatform.macOS => "macOS",
      TargetPlatform.iOS => "iOS",
      TargetPlatform.android => kIsWeb ? "$label Web" : (leanbackMode ? "$label TV" : label),
      _ => !kIsWeb ? label : "$label Web",
    };
  }

  String get versionPlatformBuild => "$version ($platformLabel)\n#$buildNumber";

  String get versionAndPlatform => "$version ($platformLabel)";

  @override
  String toString() => 'ApplicationInfo(name: $name, version: $version, platform: $platformLabel)';
}
