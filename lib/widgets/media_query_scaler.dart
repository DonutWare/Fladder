import 'package:flutter/material.dart';

class MediaQueryScaler extends StatelessWidget {
  final Widget child;
  final bool enable;
  final double scale;

  const MediaQueryScaler({
    required this.child,
    required this.enable,
    this.scale = 1.45,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) return child;
    final mediaQuery = MediaQuery.of(context);
    final screenSize = MediaQuery.sizeOf(context) * scale;

    final scaledMedia = mediaQuery.copyWith(
      navigationMode: NavigationMode.directional,
      size: screenSize,
      padding: mediaQuery.padding * scale,
      viewInsets: mediaQuery.viewInsets * scale,
      viewPadding: mediaQuery.viewPadding * scale,
      devicePixelRatio: mediaQuery.devicePixelRatio * scale,
    );

    return FittedBox(
      alignment: Alignment.center,
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: MediaQuery(
          data: scaledMedia,
          child: child,
        ),
      ),
    );
  }
}
