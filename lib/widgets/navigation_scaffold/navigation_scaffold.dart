import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ConnectionState;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/nested_bottom_appbar.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_app_bar.dart';
import 'package:fladder/widgets/navigation_scaffold/components/floating_player_bar.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_drawer.dart';
import 'package:fladder/widgets/shared/animated_visibility.dart';
import 'package:fladder/widgets/shared/hide_on_scroll.dart';
import 'package:fladder/widgets/shared/offline_banner.dart';

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
    final views = ref.watch(viewsProvider.select((value) => value.views));
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));
    final showPlayerBar = playerState == VideoPlayerState.minimized;

    final isDesktop = AdaptiveLayout.of(context).isDesktop || kIsWeb;

    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final paddingOf = mediaQuery.padding;
    final viewPaddingOf = mediaQuery.viewPadding;

    final bottomPadding = isDesktop ? 12.0 : paddingOf.bottom;
    final bottomViewPadding = isDesktop ? 12.0 : viewPaddingOf.bottom;
    final isHomeScreen = currentIndex != -1;

    final isOffline = ref.watch(connectivityStatusProvider.select((value) => value == ConnectionState.offline));

    final offlineMessageHeight = isOffline && !isDesktop ? 12 : 0;

    final calculatedBottomViewPadding =
        showPlayerBar ? floatingPlayerHeight(context) + bottomViewPadding : bottomViewPadding;

    final currentTab =
        HomeTabs.values.elementAtOrNull(currentIndex.clamp(0, HomeTabs.values.length - 1)) ?? HomeTabs.dashboard;

    final fullScreenChildRoute = fullScreenRoutes.contains(context.router.current.name);

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (currentIndex != 0) {
          widget.destinations.first.action!();
        }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: MediaQuery(
              data: mediaQuery.copyWith(
                padding: paddingOf.copyWith(
                  top: mediaQuery.padding.top + offlineMessageHeight,
                  bottom: showPlayerBar ? floatingPlayerHeight(context) + 12 + bottomPadding : bottomPadding,
                ),
                viewPadding: viewPaddingOf.copyWith(
                  top: mediaQuery.viewPadding.top,
                  bottom: calculatedBottomViewPadding,
                ),
              ),
              //Builder to correctly apply new padding
              child: Builder(builder: (context) {
                return Scaffold(
                  key: _key,
                  appBar: fullScreenChildRoute ? null : const FladderAppBar(),
                  extendBodyBehindAppBar: true,
                  resizeToAvoidBottomInset: false,
                  extendBody: true,
                  floatingActionButton: AdaptiveLayout.layoutModeOf(context) == LayoutMode.single && isHomeScreen
                      ? widget.destinations.elementAtOrNull(currentIndex)?.floatingActionButton?.normal
                      : null,
                  drawer: homeRoutes.any((element) => element.name.contains(currentLocation))
                      ? NestedNavigationDrawer(
                          actionButton: null,
                          toggleExpanded: (value) => _key.currentState?.closeDrawer(),
                          views: views,
                          destinations: widget.destinations,
                          currentLocation: currentLocation,
                        )
                      : null,
                  bottomNavigationBar: AnimatedVisibility(
                    visible: (isHomeScreen && AdaptiveLayout.viewSizeOf(context) == ViewSize.phone),
                    hiddenHeight: calculatedBottomViewPadding,
                    duration: const Duration(milliseconds: 250),
                    child: HideOnScroll(
                      controller: AdaptiveLayout.scrollOf(context, currentTab),
                      forceHide: !homeRoutes.any((element) => element.name.contains(currentLocation)),
                      child: NestedBottomAppBar(
                        child: SizedBox(
                          height: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: widget.destinations
                                .map(
                                  (destination) => destination.toNavigationButton(
                                      widget.currentRouteName == destination.route?.routeName, false, false),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                );
              }),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: AnimatedFadeSize(
              child: Container(
                width: double.infinity,
                child: showPlayerBar ? const FloatingPlayerBar() : const SizedBox.shrink(),
              ),
            ),
          ),
          if (!AdaptiveLayout.of(context).isDesktop)
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isOffline ? 1 : 0,
                child: Container(
                  height: kToolbarHeight + offlineMessageHeight,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.errorContainer.withValues(alpha: 0.8),
                      theme.colorScheme.errorContainer.withValues(alpha: 0.25),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: OfflineBanner(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
