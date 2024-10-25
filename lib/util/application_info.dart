// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_info.freezed.dart';

final applicationInfoProvider = StateProvider<ApplicationInfo>((ref) {
  return ApplicationInfo(
    name: "",
    version: "",
    buildNumber: "",
    os: "",
  );
});

@Freezed(toJson: false, fromJson: false)
class ApplicationInfo with _$ApplicationInfo {
  const ApplicationInfo._();

  factory ApplicationInfo({
    required String name,
    required String version,
    required String buildNumber,
    required String os,
  }) = _ApplicationInfo;

  String get versionPlatformBuild => "$version ($os)\n#$buildNumber";

  String get versionAndPlatform => "$version ($os)";

  @override
  String toString() => 'ApplicationInfo(name: $name, version: $version, os: $os)';
}
