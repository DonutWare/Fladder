import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/screens/shared/nested_bottom_appbar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_app_bar.dart';
import 'package:fladder/widgets/navigation_scaffold/components/floating_player_bar.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_drawer.dart';
import 'package:fladder/widgets/shared/hide_on_scroll.dart';

class NavigationScaffold extends ConsumerStatefulWidget {
  final String? currentRouteName;
  final Widget? nestedChild;
  final List<DestinationModel> destinations;
  final GlobalKey<NavigatorState>? nestedNavigatorKey;
  const NavigationScaffold({
    this.currentRouteName,
    this.nestedChild,
    required this.destinations,
    this.nestedNavigatorKey,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationScaffoldState();
}

class _NavigationScaffoldState extends ConsumerState<NavigationScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int get currentIndex =>
      widget.destinations.indexWhere((element) => element.route?.routeName == widget.currentRouteName);
  String get currentLocation => widget.currentRouteName ?? "Nothing";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) {
      ref.read(viewsProvider.notifier).fetchViews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));
    final views = ref.watch(viewsProvider.select((value) => value.views));

    final isHomeRoutes = homeRoutes.any((element) => element.name.contains(context.router.current.name));

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (currentIndex != 0) {
          widget.destinations.first.action!();
        }
      },
      child: Scaffold(
        key: _key,
        appBar: const FladderAppBar(),
        extendBodyBehindAppBar: true,
        extendBody: true,
        floatingActionButtonAnimator:
            playerState == VideoPlayerState.minimized ? FloatingActionButtonAnimator.noAnimation : null,
        floatingActionButtonLocation:
            playerState == VideoPlayerState.minimized ? FloatingActionButtonLocation.centerFloat : null,
        floatingActionButton: AdaptiveLayout.layoutModeOf(context) == LayoutMode.single &&
                AdaptiveLayout.viewSizeOf(context) == ViewSize.phone &&
                isHomeRoutes
            ? switch (playerState) {
                VideoPlayerState.minimized => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: FloatingPlayerBar(),
                  ),
                _ => currentIndex != -1
                    ? widget.destinations.elementAtOrNull(currentIndex)?.floatingActionButton?.normal
                    : null,
              }
            : null,
        drawer: NestedNavigationDrawer(
          actionButton: null,
          toggleExpanded: (value) => _key.currentState?.closeDrawer(),
          views: views,
          destinations: widget.destinations,
          currentLocation: currentLocation,
        ),
        bottomNavigationBar: AdaptiveLayout.viewSizeOf(context) == ViewSize.phone
            ? HideOnScroll(
                controller: AdaptiveLayout.scrollOf(context),
                forceHide: !homeRoutes.any((element) => element.name.contains(currentLocation)),
                child: NestedBottomAppBar(
                  child: Transform.translate(
                    offset: const Offset(0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.destinations
                          .map(
                            (destination) => destination.toNavigationButton(
                                widget.currentRouteName == destination.route?.routeName, false),
                          )
                          .toList(),
                    ),
                  ),
                ),
              )
            : null,
        body: widget.nestedChild != null
            ? NavigationBody(
                child: widget.nestedChild!,
                parentContext: context,
                currentIndex: currentIndex,
                destinations: widget.destinations,
                currentLocation: currentLocation,
                drawerKey: _key,
              )
            : null,
      ),
    );
  }
}
