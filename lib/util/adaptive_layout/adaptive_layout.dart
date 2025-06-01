import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout_model.dart';
import 'package:fladder/util/debug_banner.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/poster_defaults.dart';

enum InputDevice {
  touch,
  pointer,
}

enum ViewSize {
  phone,
  tablet,
  desktop;

  const ViewSize();

  String label(BuildContext context) => switch (this) {
        ViewSize.phone => context.localized.phone,
        ViewSize.tablet => context.localized.tablet,
        ViewSize.desktop => context.localized.desktop,
      };

  bool operator >(ViewSize other) => index > other.index;
  bool operator >=(ViewSize other) => index >= other.index;
  bool operator <(ViewSize other) => index < other.index;
  bool operator <=(ViewSize other) => index <= other.index;
}

enum LayoutMode {
  single,
  dual;

  const LayoutMode();

  String label(BuildContext context) => switch (this) {
        LayoutMode.single => context.localized.layoutModeSingle,
        LayoutMode.dual => context.localized.layoutModeDual,
      };

  bool operator >(ViewSize other) => index > other.index;
  bool operator >=(ViewSize other) => index >= other.index;
  bool operator <(ViewSize other) => index < other.index;
  bool operator <=(ViewSize other) => index <= other.index;
}

class AdaptiveLayout extends InheritedWidget {
  final AdaptiveLayoutModel data;

  const AdaptiveLayout({
    super.key,
    required this.data,
    required super.child,
  });

  static AdaptiveLayoutModel of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<AdaptiveLayout>();
    assert(inherited != null, 'No AdaptiveLayout found in context');
    return inherited!.data;
  }

  static AdaptiveLayout? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveLayout>();
  }

  static ViewSize layoutOf(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.data.viewSize;
  }

  static PosterDefaults poster(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.data.posterDefaults;
  }

  static ScrollController scrollOf(BuildContext context) {
    final AdaptiveLayout? result = maybeOf(context);
    return result!.data.controller;
  }

  static EdgeInsets adaptivePadding(BuildContext context, {double horizontalPadding = 16}) {
    final viewPadding = MediaQuery.paddingOf(context);
    final padding = viewPadding.copyWith(
      left: AdaptiveLayout.of(context).sideBarWidth + horizontalPadding + viewPadding.left,
      top: 0,
      bottom: 0,
      right: viewPadding.left + horizontalPadding,
    );
    return padding;
  }

  static LayoutMode layoutModeOf(BuildContext context) => maybeOf(context)!.data.layoutMode;
  static ViewSize viewSizeOf(BuildContext context) => maybeOf(context)!.data.viewSize;

  static InputDevice inputDeviceOf(BuildContext context) => maybeOf(context)!.data.inputDevice;

  @override
  bool updateShouldNotify(AdaptiveLayout oldWidget) => data != oldWidget.data;
}

const defaultTitleBarHeight = 35.0;

class AdaptiveLayoutBuilder extends ConsumerStatefulWidget {
  final AdaptiveLayoutModel? adaptiveLayout;
  final Widget Function(BuildContext context) child;
  const AdaptiveLayoutBuilder({
    this.adaptiveLayout,
    required this.child,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdaptiveLayoutBuilderState();
}

class _AdaptiveLayoutBuilderState extends ConsumerState<AdaptiveLayoutBuilder> {
  List<LayoutPoints> layoutPoints = [
    LayoutPoints(start: 0, end: 599, type: ViewSize.phone),
    LayoutPoints(start: 600, end: 1919, type: ViewSize.tablet),
    LayoutPoints(start: 1920, end: 3180, type: ViewSize.desktop),
  ];
  late ViewSize viewSize = ViewSize.tablet;
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
    for (var element in layoutPoints) {
      if (MediaQuery.of(context).size.width > element.start && MediaQuery.of(context).size.width < element.end) {
        newType = element.type;
      }
    }
    viewSize = newType ?? ViewSize.tablet;
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

    final selectedViewSize = selectAvailableOrSmaller<ViewSize>(viewSize, acceptedViewSizes, ViewSize.values);
    final selectedLayoutMode = selectAvailableOrSmaller<LayoutMode>(layoutMode, acceptedLayouts, LayoutMode.values);
    final input = (isDesktop || kIsWeb) ? InputDevice.pointer : InputDevice.touch;

    final posterDefaults = switch (selectedViewSize) {
      ViewSize.phone => const PosterDefaults(size: 300, ratio: 0.55),
      ViewSize.tablet => const PosterDefaults(size: 350, ratio: 0.55),
      ViewSize.desktop => const PosterDefaults(size: 400, ratio: 0.55),
    };

    final currentLayout = widget.adaptiveLayout ??
        AdaptiveLayoutModel(
          viewSize: selectedViewSize,
          layoutMode: selectedLayoutMode,
          inputDevice: input,
          platform: currentPlatform,
          isDesktop: isDesktop,
          sideBarWidth: 0,
          controller: controller,
          posterDefaults: posterDefaults,
        );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding: isDesktop || kIsWeb ? const EdgeInsets.only(top: defaultTitleBarHeight, bottom: 16) : null,
        viewPadding: isDesktop || kIsWeb ? const EdgeInsets.only(top: defaultTitleBarHeight, bottom: 16) : null,
      ),
      child: AdaptiveLayout(
        data: currentLayout.copyWith(
          viewSize: selectedViewSize,
          layoutMode: selectedLayoutMode,
          inputDevice: input,
          platform: currentPlatform,
          isDesktop: isDesktop,
          controller: controller,
          posterDefaults: posterDefaults,
        ),
        child: widget.adaptiveLayout == null ? DebugBanner(child: widget.child(context)) : widget.child(context),
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
