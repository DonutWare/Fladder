import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/wallpaper_api.g.dart',
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/wallpaper/WallpaperApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'nl.jknaapen.fladder.wallpaper',
      includeErrorClass: false,
    ),
    dartPackageName: 'nl_jknaapen_fladder.wallpaper',
  ),
)
@HostApi()
abstract class WallpaperApi {
  @async
  bool openWallpaperPopup(String filePath);
}
