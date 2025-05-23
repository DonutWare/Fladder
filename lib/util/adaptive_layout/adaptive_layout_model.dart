import 'package:flutter/material.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/poster_defaults.dart';

class LayoutPoints {
  final double start;
  final double end;
  final ViewSize type;
  LayoutPoints({
    required this.start,
    required this.end,
    required this.type,
  });

  LayoutPoints copyWith({
    double? start,
    double? end,
    ViewSize? type,
  }) {
    return LayoutPoints(
      start: start ?? this.start,
      end: end ?? this.end,
      type: type ?? this.type,
    );
  }

  @override
  String toString() => 'LayoutPoints(start: $start, end: $end, type: $type)';

  @override
  bool operator ==(covariant LayoutPoints other) {
    if (identical(this, other)) return true;
    return other.start == start && other.end == end && other.type == type;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ type.hashCode;
}

@immutable
class AdaptiveLayoutModel {
  final ViewSize viewSize;
  final LayoutMode layoutMode;
  final InputDevice inputDevice;
  final TargetPlatform platform;
  final bool isDesktop;
  final PosterDefaults posterDefaults;
  final ScrollController controller;
  final double sideBarWidth;

  const AdaptiveLayoutModel({
    required this.viewSize,
    required this.layoutMode,
    required this.inputDevice,
    required this.platform,
    required this.isDesktop,
    required this.posterDefaults,
    required this.controller,
    required this.sideBarWidth,
  });

  AdaptiveLayoutModel copyWith({
    ViewSize? viewSize,
    LayoutMode? layoutMode,
    InputDevice? inputDevice,
    TargetPlatform? platform,
    bool? isDesktop,
    PosterDefaults? posterDefaults,
    ScrollController? controller,
    double? sideBarWidth,
  }) {
    return AdaptiveLayoutModel(
      viewSize: viewSize ?? this.viewSize,
      layoutMode: layoutMode ?? this.layoutMode,
      inputDevice: inputDevice ?? this.inputDevice,
      platform: platform ?? this.platform,
      isDesktop: isDesktop ?? this.isDesktop,
      posterDefaults: posterDefaults ?? this.posterDefaults,
      controller: controller ?? this.controller,
      sideBarWidth: sideBarWidth ?? this.sideBarWidth,
    );
  }
}
