import 'package:flutter/material.dart';

class FadeEdges extends StatelessWidget {
  const FadeEdges({
    super.key,
    required this.child,
    this.topFade = 0.0,
    this.bottomFade = 0.0,
    this.leftFade = 0.0,
    this.rightFade = 0.0,
  });

  final Widget child;
  final double topFade;
  final double bottomFade;
  final double leftFade;
  final double rightFade;

  double _clampFade(double value) => value.clamp(0.0, 0.5);

  @override
  Widget build(BuildContext context) {
    final double safeTop = _clampFade(topFade);
    final double safeBottom = _clampFade(bottomFade);
    final double safeLeft = _clampFade(leftFade);
    final double safeRight = _clampFade(rightFade);

    final Map<double, Color> vStopsMap = {};
    if (safeTop > 0) {
      vStopsMap[0.0] = Colors.transparent;
      vStopsMap[safeTop] = Colors.white;
    } else {
      vStopsMap[0.0] = Colors.white;
    }
    if (safeBottom > 0) {
      vStopsMap[1.0 - safeBottom] = Colors.white;
      vStopsMap[1.0] = Colors.transparent;
    } else {
      vStopsMap[1.0] = Colors.white;
    }
    final List<double> finalVStops = vStopsMap.keys.toList()..sort();
    final List<Color> finalVColors = finalVStops.map((stop) => vStopsMap[stop]!).toList();

    Widget verticalMask = ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: finalVColors,
          stops: finalVStops,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );

    if (safeLeft > 0 || safeRight > 0) {
      final Map<double, Color> hStopsMap = {};
      if (safeLeft > 0) {
        hStopsMap[0.0] = Colors.transparent;
        hStopsMap[safeLeft] = Colors.white;
      } else {
        hStopsMap[0.0] = Colors.white;
      }
      if (safeRight > 0) {
        hStopsMap[1.0 - safeRight] = Colors.white;
        hStopsMap[1.0] = Colors.transparent;
      } else {
        hStopsMap[1.0] = Colors.white;
      }
      final List<double> finalHStops = hStopsMap.keys.toList()..sort();
      final List<Color> finalHColors = finalHStops.map((stop) => hStopsMap[stop]!).toList();

      return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: finalHColors,
            stops: finalHStops,
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: verticalMask,
      );
    }

    return verticalMask;
  }
}
