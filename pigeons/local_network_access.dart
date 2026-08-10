import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/local_network_access_pigeon.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/api/LocalNetworkAccessPigeon.g.kt',
    kotlinOptions: KotlinOptions(
      includeErrorClass: false,
    ),
    dartPackageName: 'nl_jknaapen_fladder.settings',
  ),
)
@HostApi()
abstract class LocalNetworkAccessPigeon {
  /// False on platforms where local network access is implicit (below API 36).
  bool isPermissionRequired();

  bool hasLocalNetworkAccess();

  /// Android only prompts once; after a denial this returns false without UI.
  @async
  bool requestLocalNetworkAccess();

  void openAppSettings();
}
