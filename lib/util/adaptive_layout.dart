import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/util/debug_banner.dart';
import 'package:fladder/util/poster_defaults.dart';

enum InputDevice {
  touch,
  pointer,
}

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

class AdaptiveLayout extends InheritedWidget {
  final ViewSize viewSize;
  final LayoutMode layoutMode;
  final InputDevice inputDevice;
  final TargetPlatform platform;
  final bool isDesktop;
  final PosterDefaults posterDefaults;
  final ScrollController controller;

  const AdaptiveLayout({
    super.key,
    required this.viewSize,
    required this.layoutMode,
    required this.inputDevice,
    required this.platform,
    required this.isDesktop,
    required this.posterDefaults,
    required this.controller,
    required super.child,
  });

  static AdaptiveLayout? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveLayout>();
  }

  static ViewSize layoutOf(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.viewSize;
  }

  static PosterDefaults poster(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.posterDefaults;
  }

  static AdaptiveLayout of(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!;
  }

  static ScrollController scrollOf(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.controller;
  }

  static LayoutMode layoutModeOf(BuildContext context) => maybeOf(context)!.layoutMode;
  static ViewSize viewSizeOf(BuildContext context) => maybeOf(context)!.viewSize;

  static InputDevice inputDeviceOf(BuildContext context) => maybeOf(context)!.inputDevice;

  @override
  bool updateShouldNotify(AdaptiveLayout oldWidget) {
    return viewSize != oldWidget.viewSize ||
        layoutMode != oldWidget.layoutMode ||
        platform != oldWidget.platform ||
        inputDevice != oldWidget.inputDevice ||
        isDesktop != oldWidget.isDesktop;
  }
}

const defaultTitleBarHeight = 35.0;

class AdaptiveLayoutBuilder extends ConsumerStatefulWidget {
  final List<LayoutPoints> layoutPoints;
  final ViewSize fallBack;
  final Widget child;
  const AdaptiveLayoutBuilder({required this.layoutPoints, required this.child, required this.fallBack, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdaptiveLayoutBuilderState();
}

class _AdaptiveLayoutBuilderState extends ConsumerState<AdaptiveLayoutBuilder> {
  late ViewSize viewSize = widget.fallBack;
  late LayoutMode layoutMode = LayoutMode.single;
  late TargetPlatform currentPlatform = defaultTargetPlatform;
  late ScrollController controller = ScrollController();

  @override
  void didChangeDependencies() {
    calculateLayout();
    calculateSize();
    super.didChangeDependencies();
  }

  bool get isDesktop {
    if (kIsWeb) return false;
    return [
      TargetPlatform.macOS,
      TargetPlatform.windows,
      TargetPlatform.linux,
    ].contains(currentPlatform);
  }

  void calculateLayout() {
    ViewSize? newType;
    for (var element in widget.layoutPoints) {
      if (MediaQuery.of(context).size.width > element.start && MediaQuery.of(context).size.width < element.end) {
        newType = element.type;
      }
    }
    viewSize = newType ?? widget.fallBack;
  }

  void calculateSize() {
    LayoutMode newSize;
    if (MediaQuery.of(context).size.width > 0 && MediaQuery.of(context).size.width < 960) {
      newSize = LayoutMode.single;
    } else {
      newSize = LayoutMode.dual;
    }
    layoutMode = newSize;
  }

  @override
  Widget build(BuildContext context) {
    final acceptedLayouts = ref.watch(homeSettingsProvider.select((value) => value.screenLayouts));
    final acceptedViewSizes = ref.watch(homeSettingsProvider.select((value) => value.layoutStates));
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding: isDesktop || kIsWeb ? const EdgeInsets.only(top: defaultTitleBarHeight, bottom: 16) : null,
        viewPadding: isDesktop || kIsWeb ? const EdgeInsets.only(top: defaultTitleBarHeight, bottom: 16) : null,
      ),
      child: AdaptiveLayout(
        viewSize: selectAvailableOrSmaller<ViewSize>(viewSize, acceptedViewSizes, ViewSize.values),
        controller: controller,
        layoutMode: selectAvailableOrSmaller<LayoutMode>(layoutMode, acceptedLayouts, LayoutMode.values),
        inputDevice: (isDesktop || kIsWeb) ? InputDevice.pointer : InputDevice.touch,
        platform: currentPlatform,
        isDesktop: isDesktop,
        posterDefaults: switch (viewSize) {
          ViewSize.phone => const PosterDefaults(size: 300, ratio: 0.55),
          ViewSize.tablet => const PosterDefaults(size: 350, ratio: 0.55),
          ViewSize.desktop => const PosterDefaults(size: 400, ratio: 0.55),
        },
        child: DebugBanner(child: widget.child),
      ),
    );
  }
}

double? get topPadding {
  return switch (defaultTargetPlatform) {
    TargetPlatform.linux || TargetPlatform.windows || TargetPlatform.macOS => 35,
    _ => null
  };
}
