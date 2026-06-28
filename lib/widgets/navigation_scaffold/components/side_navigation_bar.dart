import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/collapse_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/navigation_scaffold/components/side_navigation_buttons.dart';
import 'package:fladder/widgets/shared/custom_tooltip.dart';

final navBarNode = FocusNode();

class SideNavigationRail extends ConsumerWidget {
  final int currentIndex;
  final List<DestinationModel> destinations;
  final String currentLocation;
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideNavigationRail({
    required this.currentIndex,
    required this.destinations,
    required this.currentLocation,
    required this.child,
    required this.scaffoldKey,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textDirection = Directionality.of(context);
    final isRtl = textDirection == TextDirection.rtl;
    final expandedSideBar = ref.watch(clientSettingsProvider.select((value) => value.expandSideBar));

    final expandedWidth = 200.0;

    final padding = MediaQuery.paddingOf(context);
    final directionalPadding = EdgeInsetsDirectional.fromSTEB(
      padding.left,
      padding.top,
      padding.right,
      padding.bottom,
    );
    final startInset = directionalPadding.resolve(textDirection).left;
    final tooltipPosition = isRtl ? TooltipPosition.left : TooltipPosition.right;

    final largeBar = AdaptiveLayout.layoutModeOf(context) != LayoutMode.single;
    final fullyExpanded = largeBar ? expandedSideBar : false;
    final shouldExpand = fullyExpanded;
    final isDesktop = AdaptiveLayout.of(context).isDesktop;

    final railPadding = directionalPadding
        .copyWith(
          start: startInset,
          end: 0,
          top: isDesktop ? directionalPadding.top : null,
        )
        .resolve(textDirection);
    final collapsedWidth = 90.0 + startInset;

    final fullScreenChildRoute = fullScreenRoutes.contains(context.router.current.name);

    final hasOverlay = AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual ||
        homeRoutes.any((element) => element.name.contains(context.router.current.name));

    final useBlurredBackground = ref.watch(clientSettingsProvider.select(
          (value) => value.backgroundImage == BackgroundType.blurred && value.enableBlurEffects,
        )) &&
        !topBarNoBlurRoutes.contains(context.router.current.name);

    final blurWidth = (shouldExpand ? expandedWidth : collapsedWidth) + 25;

    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Stack(
      children: [
        AdaptiveLayout(
          data: AdaptiveLayout.of(context).copyWith(
            // -0.1 offset to fix single visible pixel line
            sideBarWidth: (fullyExpanded ? expandedWidth : collapsedWidth) - 0.1,
          ),
          child: child,
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: RepaintBoundary(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: !fullScreenChildRoute ? 1 : 0,
                child: IgnorePointer(
                  child: Container(
                    width: blurWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                        end: isRtl ? Alignment.centerLeft : Alignment.centerRight,
                        colors: [
                          surfaceColor.withAlpha(255),
                          surfaceColor.withAlpha(175),
                          surfaceColor.withAlpha(0),
                        ],
                      ),
                    ),
                    child: useBlurredBackground
                        ? ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                                end: isRtl ? Alignment.centerLeft : Alignment.centerRight,
                                colors: [
                                  Colors.white.withAlpha(255),
                                  Colors.white.withAlpha(175),
                                  Colors.white.withAlpha(0),
                                ],
                              ).createShader(
                                Rect.fromLTRB(0, 0, blurWidth, bounds.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: const BackgroundImage(),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: FocusTraversalGroup(
              policy: _RailTraversalPolicy(),
              child: IgnorePointer(
                ignoring: !hasOverlay || fullScreenChildRoute,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: !fullScreenChildRoute ? 1 : 0,
                  child: SizedBox(
                    width: shouldExpand ? expandedWidth : collapsedWidth,
                    child: Padding(
                      key: const Key('navigation_rail'),
                      padding: railPadding,
                      child: Column(
                        spacing: 2,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: CollapseButton(
                              label: shouldExpand ? Expanded(child: Text(context.localized.navigation)) : null,
                              keepVisible: !(largeBar && expandedSideBar),
                              icon: Icon(
                                largeBar && expandedSideBar ? IconsaxPlusLinear.sidebar_left : IconsaxPlusLinear.menu,
                                color: Theme.of(context).colorScheme.onSurface.withValues(
                                      alpha: largeBar && expandedSideBar ? 0.65 : 1,
                                    ),
                              ),
                              onPressed: !largeBar
                                  ? () => scaffoldKey.currentState?.openDrawer()
                                  : () => ref
                                      .read(clientSettingsProvider.notifier)
                                      .update((state) => state.copyWith(expandSideBar: !state.expandSideBar)),
                            ),
                          ),
                          if (largeBar) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4).copyWith(bottom: expandedSideBar ? 10 : 0),
                              child: AnimatedFadeSize(
                                duration: const Duration(milliseconds: 250),
                                child: actionButtonWidget(context, shouldExpand),
                              ),
                            ),
                          ],
                          Expanded(
                            child: SideNavigationButtons(
                              largeBar: largeBar,
                              destinations: destinations,
                              tooltipPosition: tooltipPosition,
                              currentIndex: currentIndex,
                              shouldExpand: shouldExpand,
                            ),
                          ),
                          NavigationButton(
                            label: context.localized.settings,
                            selected: currentLocation.contains(const SettingsRoute().routeName),
                            selectedIcon: const Icon(IconsaxPlusBold.setting_3),
                            horizontal: true,
                            expanded: shouldExpand,
                            icon: const SizedBox.shrink(),
                            customIcon: const ExcludeFocusTraversal(
                                child: SizedBox.square(dimension: 40, child: SettingsUserIcon())),
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AdaptiveFab actionButton(BuildContext context) {
    return ((currentIndex >= 0 && currentIndex < destinations.length)
            ? destinations[currentIndex].floatingActionButton
            : null) ??
        AdaptiveFab(
          context: context,
          title: context.localized.search,
          key: const Key("Search"),
          onPressed: () => context.router.navigate(LibrarySearchRoute()),
          child: const Icon(IconsaxPlusLinear.search_normal_1),
        );
  }

  Widget actionButtonWidget(BuildContext context, bool expanded) {
    final destination = (widget.currentIndex >= 0 && widget.currentIndex < widget.destinations.length)
        ? widget.destinations[widget.currentIndex]
        : null;

    // If there's a custom FAB widget, use it (DashboardFabs already
    // includes SyncPlay for the dashboard route).
    if (destination?.customFab != null) {
      return destination!.customFab!;
    }

    // For non-dashboard rails: show only the route's primary action FAB.
    // SyncPlay access comes from the dashboard FAB and the SyncPlayBadge
    // (a non-FAB indicator that opens the same sheet) — stacking two FABs
    // here violates AGENTS.md rule 4.
    final fab = actionButton(context);
    return expanded ? fab.extended : fab.normal;
  }
}

class _RailTraversalPolicy extends ReadingOrderTraversalPolicy {
  _RailTraversalPolicy();

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final isRtl = Directionality.of(currentNode.context!) == TextDirection.rtl;
    final toMainDirection = isRtl ? TraversalDirection.left : TraversalDirection.right;
    final awayFromMainDirection = isRtl ? TraversalDirection.right : TraversalDirection.left;

    if (direction == awayFromMainDirection) {
      return false;
    }
    if (direction == toMainDirection) {
      if (lastMainFocus != null && _isLaidOut(lastMainFocus!)) {
        lastMainFocus!.requestFocus();
        return true;
      } else {
        return super.inDirection(currentNode, direction);
      }
    }
    if (direction == TraversalDirection.up || direction == TraversalDirection.down) {
      final scope = currentNode.enclosingScope;
      if (scope == null) {
        return false;
      }

      final candidates = scope.traversalDescendants
          .where((n) => n.canRequestFocus && FocusTraversalGroup.maybeOfNode(n) == this && _isLaidOut(n))
          .toList();

      if (candidates.isEmpty) return false;

      final sorted = sortDescendants(candidates, currentNode).toList();

      var index = sorted.indexOf(currentNode);
      if (index == -1) {
        index = direction == TraversalDirection.down ? -1 : sorted.length;
      }

      final nextIndex = direction == TraversalDirection.down ? index + 1 : index - 1;

      if (nextIndex < 0 || nextIndex >= sorted.length) {
        return true;
      }

      requestFocusCallback(sorted[nextIndex]);
      return true;
    }
    return super.inDirection(currentNode, direction);
  }
}

bool _isLaidOut(FocusNode node) {
  final ro = node.context?.findRenderObject();
  return ro is RenderBox && ro.hasSize;
}

bool isNodeInCurrentRoute(FocusNode node) {
  if (!node.canRequestFocus) return false;
  if (node.context == null) return false;

  final nearestScope = FocusScope.of(node.context!);
  return nearestScope.hasFocus || nearestScope.isFirstFocus;
}
