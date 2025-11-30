import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/application_menu.g.dart',
    dartOptions: DartOptions(),
    swiftOut: 'macos/Runner/ApplicationMenu.g.swift',
    swiftOptions: SwiftOptions(
      includeErrorClass: false,
    ),
    dartPackageName: 'nl_jknaapen_fladder.application_menu',
  ),
)
@FlutterApi()
abstract class ApplicationMenu {
  void openNewWindow();
}
