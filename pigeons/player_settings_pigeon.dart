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
  final bool enableTunneling;
  final Map<SegmentType, SegmentSkip> skipTypes;
  //Color in ARGB32 format
  final int? themeColor;
  final int skipForward;
  final int skipBackward;
  final AutoNextType autoNextType;
  final List<PlayerOrientations> acceptedOrientations;

  const PlayerSettings({
    required this.enableTunneling,
    required this.skipTypes,
    required this.themeColor,
    required this.skipForward,
    required this.skipBackward,
    required this.autoNextType,
    required this.acceptedOrientations,
  });
}

enum PlayerOrientations {
  portraitUp,
  portraitDown,
  landScapeLeft,
  landScapeRight,
}

enum AutoNextType {
  off,
  static,
  smart,
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
