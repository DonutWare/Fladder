import 'package:fladder/util/poster_defaults.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fladder/routes/app_routes.dart';

enum LayoutState {
  phone,
  tablet,
  desktop,
}

enum ScreenLayout {
  single,
  dual,
}

enum InputDevice {
  touch,
  pointer,
}

class LayoutPoints {
  final double start;
  final double end;
  final LayoutState type;
  LayoutPoints({
    required this.start,
    required this.end,
    required this.type,
  });

  LayoutPoints copyWith({
    double? start,
    double? end,
    LayoutState? type,
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
  final LayoutState layout;
  final ScreenLayout size;
  final InputDevice inputDevice;
  final TargetPlatform platform;
  final bool isDesktop;
  final GoRouter router;
  final PosterDefaults posterDefaults;

  const AdaptiveLayout({
    super.key,
    required this.layout,
    required this.size,
    required this.inputDevice,
    required this.platform,
    required this.isDesktop,
    required this.router,
    required this.posterDefaults,
    required super.child,
  });

  static AdaptiveLayout? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveLayout>();
  }

  static LayoutState layoutOf(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.layout;
  }

  static PosterDefaults poster(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.posterDefaults;
  }

  static GoRouter routerOf(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.router;
  }

  static AdaptiveLayout of(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(AdaptiveLayout oldWidget) {
    return layout != oldWidget.layout ||
        size != oldWidget.size ||
        platform != oldWidget.platform ||
        inputDevice != oldWidget.inputDevice ||
        isDesktop != oldWidget.isDesktop ||
        router != oldWidget.router;
  }
}

class AdaptiveLayoutBuilder extends ConsumerStatefulWidget {
  final List<LayoutPoints> layoutPoints;
  final LayoutState fallBack;
  final Widget child;
  const AdaptiveLayoutBuilder({required this.layoutPoints, required this.child, required this.fallBack, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdaptiveLayoutBuilderState();
}

class _AdaptiveLayoutBuilderState extends ConsumerState<AdaptiveLayoutBuilder> {
  late LayoutState layout = widget.fallBack;
  late ScreenLayout size = ScreenLayout.single;
  late GoRouter router = AppRoutes.routes(ref: ref, screenLayout: size);
  late TargetPlatform currentPlatform = defaultTargetPlatform;

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
    LayoutState? newType;
    for (var element in widget.layoutPoints) {
      if (MediaQuery.of(context).size.width > element.start && MediaQuery.of(context).size.width < element.end) {
        newType = element.type;
      }
    }
    if (newType == LayoutState.phone && isDesktop) {
      newType = LayoutState.tablet;
    }
    layout = newType ?? widget.fallBack;
  }

  void calculateSize() {
    ScreenLayout newSize;
    if (MediaQuery.of(context).size.width > 0 && MediaQuery.of(context).size.width < 960 && !isDesktop) {
      newSize = ScreenLayout.single;
    } else {
      newSize = ScreenLayout.dual;
    }
    if (size != newSize) {
      size = newSize;
      router = AppRoutes.routes(ref: ref, screenLayout: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      layout: layout,
      size: size,
      inputDevice: (isDesktop || kIsWeb) ? InputDevice.pointer : InputDevice.touch,
      platform: currentPlatform,
      isDesktop: isDesktop,
      router: router,
      posterDefaults: switch (layout) {
        LayoutState.phone => const PosterDefaults(size: 300, ratio: 0.55),
        LayoutState.tablet => const PosterDefaults(size: 350, ratio: 0.55),
        LayoutState.desktop => const PosterDefaults(size: 400, ratio: 0.55),
      },
      child: widget.child,
    );
  }
}
