import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/wallpaper_api.g.dart',
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/wallpaper/WallpaperApi.g.kt',
    kotlinOptions: KotlinOptions(package: 'nl.jknaapen.fladder.wallpaper', errorClassName: 'WallpaperError'),
    dartPackageName: 'nl_jknaapen_fladder.wallpaper',
  ),
)
@HostApi()
abstract class WallpaperApi {
  @asyncCallback
  bool openWallpaperPopup(String filePath);
}
