import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:overflow_view/overflow_view.dart';

import 'package:fladder/models/collection_types.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/metadata/refresh_metadata.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class SideNavigationBar extends ConsumerStatefulWidget {
  final int currentIndex;
  final List<DestinationModel> destinations;
  final String currentLocation;
  final Widget child;
  const SideNavigationBar({
    required this.currentIndex,
    required this.destinations,
    required this.currentLocation,
    required this.child,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends ConsumerState<SideNavigationBar> {
  bool expandedSideBar = false;
  bool showOnHover = false;
  Timer? timer;
  double currentWidth = 80;

  void startTimer() {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        showOnHover = true;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 250), () {
      setState(() {
        showOnHover = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullyExpanded = AdaptiveLayout.viewSizeOf(context) > ViewSize.tablet ? expandedSideBar : false;
    final shouldExpand = showOnHover || fullyExpanded;
    final views = ref.watch(viewsProvider.select((value) => value.views));
    final expandedWidth = 250.0;
    final collapsedWidth = 90.0;
    return Stack(
      children: [
        AdaptiveLayoutBuilder(
          adaptiveLayout: AdaptiveLayout.of(context).copyWith(
            sideBarWidth: fullyExpanded ? expandedWidth : collapsedWidth,
          ),
          child: (context) => widget.child,
        ),
        AnimatedFadeSize(
          alignment: Alignment.topLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: Theme.of(context).colorScheme.surface.withValues(alpha: shouldExpand ? 0.95 : 0.75),
            width: shouldExpand ? expandedWidth : collapsedWidth,
            child: MouseRegion(
              onEnter: (value) => startTimer(),
              onExit: (event) => stopTimer(),
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.paddingOf(context).left),
                child: IntrinsicWidth(
                  stepWidth: 12,
                  child: Column(
                    children: [
                      if (AdaptiveLayout.of(context).isDesktop &&
                          AdaptiveLayout.of(context).platform != TargetPlatform.macOS) ...{
                        const SizedBox(height: 4),
                        Text(
                          "Fladder",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      },
                      if (AdaptiveLayout.of(context).platform == TargetPlatform.macOS)
                        SizedBox(height: MediaQuery.of(context).padding.top),
                      Expanded(
                        child: Padding(
                          key: const Key('navigation_rail'),
                          padding: MediaQuery.paddingOf(context)
                              .copyWith(right: 0, top: AdaptiveLayout.of(context).isDesktop ? 8 : null),
                          child: Column(
                            spacing: 2,
                            children: [
                              IconButton(
                                onPressed: () => setState(() {
                                  expandedSideBar = !expandedSideBar;
                                  if (!expandedSideBar) {
                                    showOnHover = false;
                                  }
                                }),
                                icon: const Icon(IconsaxPlusBold.menu),
                              ),
                              const SizedBox(height: 8),
                              AnimatedFadeSize(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return ScaleTransition(scale: animation, child: child);
                                  },
                                  child: shouldExpand ? actionButton(context).extended : actionButton(context).normal,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 2,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...widget.destinations.mapIndexed(
                                      (index, destination) => destination.toNavigationButton(
                                          widget.currentIndex == index, true, shouldExpand),
                                    ),
                                    if (views.isNotEmpty) ...[
                                      const Divider(
                                        indent: 16,
                                        endIndent: 16,
                                      ),
                                      Flexible(
                                        child: OverflowView.flexible(
                                          direction: Axis.vertical,
                                          spacing: 4,
                                          children: views
                                              .map(
                                                (view) => view.toNavigationButton(
                                                  context.router.currentUrl.contains(view.id),
                                                  true,
                                                  shouldExpand,
                                                  () => context.pushRoute(LibrarySearchRoute(viewModelId: view.id)),
                                                  trailing: [
                                                    ItemActionButton(
                                                      label: Text(context.localized.scanLibrary),
                                                      icon: const Icon(IconsaxPlusLinear.refresh),
                                                      action: () => showRefreshPopup(context, view.id, view.name),
                                                    )
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                          builder: (context, remaining) {
                                            return PopupMenuButton(
                                              iconColor:
                                                  Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                                              padding: EdgeInsets.zero,
                                              icon: NavigationButton(
                                                label: context.localized.other,
                                                selectedIcon: const Icon(IconsaxPlusLinear.arrow_square_down),
                                                icon: const Icon(IconsaxPlusLinear.arrow_square_down),
                                                expanded: shouldExpand,
                                                horizontal: true,
                                              ),
                                              itemBuilder: (context) => views
                                                  .sublist(views.length - remaining)
                                                  .map(
                                                    (e) => PopupMenuItem(
                                                      onTap: () =>
                                                          context.pushRoute(LibrarySearchRoute(viewModelId: e.id)),
                                                      child: Row(
                                                        spacing: 8,
                                                        children: [
                                                          Icon(e.collectionType.iconOutlined),
                                                          Text(e.name),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              NavigationButton(
                                label: "Settings",
                                selected: widget.currentLocation.contains(const SettingsRoute().routeName),
                                selectedIcon: const Icon(IconsaxPlusBold.setting_3),
                                horizontal: true,
                                expanded: shouldExpand,
                                icon: const SizedBox(height: 32, child: SettingsUserIcon()),
                                onPressed: () {
                                  if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single) {
                                    context.router.push(const SettingsRoute());
                                  } else {
                                    context.router.push(const ClientSettingsRoute());
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer) const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AdaptiveFab actionButton(BuildContext context) {
    return ((widget.currentIndex >= 0 && widget.currentIndex < widget.destinations.length)
            ? widget.destinations[widget.currentIndex].floatingActionButton
            : null) ??
        AdaptiveFab(
          context: context,
          title: context.localized.search,
          key: const Key("Search"),
          onPressed: () => context.router.navigate(LibrarySearchRoute()),
          child: const Icon(IconsaxPlusLinear.search_normal_1),
        );
  }
}
