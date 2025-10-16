import 'package:flutter_svg/flutter_svg.dart';

class SvgUtils {
  static List<String> allSvgs = [
    'icons/fladder_icon.svg',
    'icons/fladder_icon_outline.svg',
  ];

  static Future<void> preCacheSVGs() async {
    try {
      for (final path in allSvgs) {
        final loadSvg = SvgAssetLoader(path);
        await svg.cache.putIfAbsent(
          loadSvg.cacheKey(null),
          () => loadSvg.loadBytes(null),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
