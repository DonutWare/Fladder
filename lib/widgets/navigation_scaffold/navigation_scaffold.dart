import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ConnectionState;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/providers/window_title_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/nested_bottom_appbar.dart';
import 'package:fladder/screens/video_player/audio_player_full_screen.dart';
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
  void didUpdateWidget(covariant NavigationScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentRouteName != oldWidget.currentRouteName && currentIndex != -1) {
      Future.microtask(() {
        if (mounted) {
          ref.read(windowTitleProvider.notifier).clearStack();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final views = ref.watch(viewsProvider.select((value) => value.views));
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));
    final currentItem = ref.watch(playBackModel.select((value) => value?.item));
    final showPlayerBar = playerState == VideoPlayerState.minimized;
    final showAudioFullScreen = playerState == VideoPlayerState.fullScreen && currentItem is AudioModel;
    final showAudioSidePanel = showAudioFullScreen && AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual;
    final showAudioOverlay = showAudioFullScreen && !showAudioSidePanel;

    final isDesktop = AdaptiveLayout.of(context).isDesktop || kIsWeb;

    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final paddingOf = mediaQuery.padding;
    final viewPaddingOf = mediaQuery.viewPadding;

    final bottomPadding = isDesktop ? 12.0 : paddingOf.bottom;
    final bottomViewPadding = isDesktop ? 12.0 : viewPaddingOf.bottom;
    final isHomeScreen = currentIndex != -1;

    final isOffline = ref.watch(connectivityStatusProvider.select((value) => value == ConnectionState.offline));

    final offlineMessageHeight = isOffline && !isDesktop ? 18 : 0;

    final calculatedBottomViewPadding =
        showPlayerBar ? floatingPlayerHeight(context) + bottomViewPadding : bottomViewPadding;

    final currentTab =
        HomeTabs.values.elementAtOrNull(currentIndex.clamp(0, HomeTabs.values.length - 1)) ?? HomeTabs.dashboard;

    final fullScreenChildRoute = fullScreenRoutes.contains(context.router.current.name);

    Widget buildMainScaffold(BuildContext scaffoldContext) {
      return Scaffold(
        key: _key,
        appBar: fullScreenChildRoute || showAudioFullScreen
            ? null
            : FladderAppBar(
                isDesktop: isDesktop,
                label: currentIndex == -1 ? "" : null,
              ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        floatingActionButton:
            !showAudioFullScreen && AdaptiveLayout.layoutModeOf(scaffoldContext) == LayoutMode.single && isHomeScreen
                ? widget.destinations.elementAtOrNull(currentIndex)?.floatingActionButton?.normal
                : null,
        drawer: !showAudioFullScreen && homeRoutes.any((element) => element.name.contains(currentLocation))
            ? NestedNavigationDrawer(
                actionButton: null,
                toggleExpanded: (value) => _key.currentState?.closeDrawer(),
                views: views,
                destinations: widget.destinations,
                currentLocation: currentLocation,
              )
            : null,
        bottomNavigationBar: AnimatedVisibility(
          visible:
              !showAudioFullScreen && (isHomeScreen && AdaptiveLayout.viewSizeOf(scaffoldContext) == ViewSize.phone),
          hiddenHeight: calculatedBottomViewPadding,
          duration: const Duration(milliseconds: 250),
          child: HideOnScroll(
            controller: AdaptiveLayout.scrollOf(scaffoldContext, currentTab),
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
                          widget.currentRouteName == destination.route?.routeName,
                          false,
                          false,
                        ),
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
                parentContext: scaffoldContext,
                currentIndex: currentIndex,
                destinations: widget.destinations,
                currentLocation: currentLocation,
                drawerKey: _key,
              )
            : null,
      );
    }

    final Widget audioOverlay = showAudioFullScreen
        ? const AudioPlayerFullScreen(
            key: ValueKey("audio_full_screen"),
          )
        : const SizedBox.shrink();

    final offlineMessagePadding = max((kToolbarHeight), MediaQuery.of(context).padding.top) + offlineMessageHeight;

    return PopScope(
      canPop: !showAudioOverlay && currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (showAudioOverlay) {
          return;
        }
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
                  top: offlineMessagePadding,
                  bottom: showPlayerBar ? floatingPlayerHeight(context) + 12 + bottomPadding : bottomPadding,
                ),
                viewPadding: viewPaddingOf.copyWith(
                  top: mediaQuery.viewPadding.top,
                  bottom: calculatedBottomViewPadding,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final panelWidth = constraints.maxWidth / 3;
                  return Row(
                    children: [
                      Expanded(
                        child: buildMainScaffold(context),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: SizedBox(
                          width: showAudioSidePanel ? panelWidth : 0,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: audioOverlay,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: AnimatedFadeSize(
              child: SizedBox(
                width: double.infinity,
                child: showPlayerBar ? const FloatingPlayerBar() : const SizedBox.shrink(),
              ),
            ),
          ),
          if (showAudioOverlay) audioOverlay,
          if (!AdaptiveLayout.of(context).isDesktop)
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isOffline ? 1 : 0,
                child: Container(
                  height: offlineMessagePadding,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.errorContainer.withValues(alpha: 0.8),
                        theme.colorScheme.errorContainer.withValues(alpha: 0.25),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: offlineMessageHeight / 2),
                    child: const OfflineBanner(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
