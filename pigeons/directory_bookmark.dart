import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/directory_bookmark.g.dart',
    dartOptions: DartOptions(),
    swiftOut: 'macos/Runner/DirectoryBookmark.g.swift',
    swiftOptions: SwiftOptions(
      includeErrorClass: true,
    ),
    dartPackageName: 'nl_jknaapen_fladder.directory_bookmark',
  ),
)
@HostApi()
abstract class DirectoryBookmark {
  void saveDirectory(String key, String path);
  String? resolveDirectory(String key);
  void closeDirectory(String key);
}
