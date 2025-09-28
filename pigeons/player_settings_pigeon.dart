import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/player_settings_helper.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/api/PlayerSettingsHelper.g.kt',
    kotlinOptions: KotlinOptions(
      includeErrorClass: false,
    ),
    dartPackageName: 'nl_jknaapen_fladder.settings',
  ),
)
class PlayerSettings {
  final Map<SegmentType, SegmentSkip> skipTypes;
    final int skipForward;
  final int skipBackward;

  const PlayerSettings({
    required this.skipTypes,
    required this.skipForward,
    required this.skipBackward,
  });
}

enum SegmentType {
  commercial,
  preview,
  recap,
  intro,
  outro,
}

enum SegmentSkip {
  ask,
  skip,
  none,
}

@HostApi()
abstract class PlayerSettingsPigeon {
  void sendPlayerSettings(PlayerSettings playerSettings);
}
