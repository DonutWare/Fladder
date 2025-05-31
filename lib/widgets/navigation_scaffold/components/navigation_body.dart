import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/side_navigation_bar.dart';

class NavigationBody extends ConsumerStatefulWidget {
  final BuildContext parentContext;
  final Widget child;
  final int currentIndex;
  final List<DestinationModel> destinations;
  final String currentLocation;
  final GlobalKey<ScaffoldState> drawerKey;
  const NavigationBody({
    required this.parentContext,
    required this.child,
    required this.currentIndex,
    required this.destinations,
    required this.currentLocation,
    required this.drawerKey,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationBodyState();
}

class _NavigationBodyState extends ConsumerState<NavigationBody> {
  double currentSideBarWidth = 80;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) {
      ref.read(viewsProvider.notifier).fetchViews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasOverlay = AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual ||
        homeRoutes.any((element) => element.name.contains(context.router.current.name));

    ref.listen(
      clientSettingsProvider,
      (previous, next) {
        if (previous != next) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness: next.statusBarBrightness(context),
          ));
        }
      },
    );

    Widget paddedChild() => MediaQuery(
          data: semiNestedPadding(widget.parentContext, hasOverlay),
          child: widget.child,
        );

    return switch (AdaptiveLayout.layoutOf(context)) {
      ViewSize.phone => paddedChild(),
      ViewSize.tablet => hasOverlay
          ? SideNavigationBar(
              currentIndex: widget.currentIndex,
              destinations: widget.destinations,
              currentLocation: widget.currentLocation,
              child: paddedChild(),
              scaffoldKey: widget.drawerKey,
            )
          : paddedChild(),
      ViewSize.desktop => SideNavigationBar(
          currentIndex: widget.currentIndex,
          destinations: widget.destinations,
          currentLocation: widget.currentLocation,
          child: paddedChild(),
          scaffoldKey: widget.drawerKey,
        )
    };
  }

  MediaQueryData semiNestedPadding(BuildContext context, bool hasOverlay) {
    final paddingOf = MediaQuery.paddingOf(context);
    return MediaQuery.of(context).copyWith(
      padding: paddingOf.copyWith(left: hasOverlay ? 0 : paddingOf.left),
    );
  }
}
