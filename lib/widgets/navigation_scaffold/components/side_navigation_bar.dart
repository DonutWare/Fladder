import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/collection_types.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/metadata/refresh_metadata.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/collapse_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/custom_tooltip.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/simple_overflow_widget.dart';

final navBarNode = FocusNode();

class SideNavigationRail extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => _SideNavigationRail();
}

class _SideNavigationRail extends ConsumerState<SideNavigationRail> {
  @override
  Widget build(BuildContext context) {
    final views = ref.watch(viewsProvider.select((value) => value.views));
    final usePostersForLibrary = ref.watch(clientSettingsProvider.select((value) => value.usePosterForLibrary));
    final expandedSideBar = ref.watch(clientSettingsProvider.select((value) => value.expandSideBar));

    final expandedWidth = 200.0;
    final padding = MediaQuery.paddingOf(context);

    final collapsedWidth = 90 + padding.left;
    final largeBar = AdaptiveLayout.layoutModeOf(context) != LayoutMode.single;
    final fullyExpanded = largeBar ? expandedSideBar : false;
    final shouldExpand = fullyExpanded;
    final isDesktop = AdaptiveLayout.of(context).isDesktop;

    final fullScreenChildRoute = fullScreenRoutes.contains(context.router.current.name);

    final hasOverlay = AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual ||
        homeRoutes.any((element) => element.name.contains(context.router.current.name));

    final sideBarPadding = isDesktop ? 6.0 : 0.0;

    final useBlurredBackground = ref.watch(clientSettingsProvider.select(
          (value) => value.backgroundImage == BackgroundType.blurred && value.enableBlurEffects,
        )) &&
        !topBarNoBlurRoutes.contains(widget.currentLocation);

    final blurWidth = (shouldExpand ? expandedWidth : collapsedWidth) + 25;

    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Stack(
      children: [
        AdaptiveLayout(
          data: AdaptiveLayout.of(context).copyWith(
            // -0.1 offset to fix single visible pixel line
            sideBarWidth: (fullyExpanded ? expandedWidth : collapsedWidth) + sideBarPadding,
          ),
          child: widget.child,
        ),
        RepaintBoundary(
          child: IgnorePointer(
            child: Container(
              width: blurWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
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
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
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
        FocusTraversalGroup(
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
                  padding: padding.copyWith(right: 0, top: isDesktop ? padding.top : null),
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
                              ? () => widget.scaffoldKey.currentState?.openDrawer()
                              : () => ref
                                  .read(clientSettingsProvider.notifier)
                                  .update((state) => state.copyWith(expandSideBar: !state.expandSideBar)),
                        ),
                      ),
                      if (largeBar) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(bottom: expandedSideBar ? 10 : 0),
                          child: AnimatedFadeSize(
                            duration: const Duration(milliseconds: 250),
                            child: shouldExpand ? actionButton(context).extended : actionButton(context).normal,
                          ),
                        ),
                      ],
                      Expanded(
                        child: Column(
                          mainAxisAlignment: !largeBar ? MainAxisAlignment.center : MainAxisAlignment.start,
                          children: [
                            ...widget.destinations.mapIndexed(
                              (index, destination) => CustomTooltip(
                                tooltipContent: expandedSideBar
                                    ? null
                                    : Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            destination.label,
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                        ),
                                      ),
                                position: TooltipPosition.right,
                                child: destination.toNavigationButton(
                                  widget.currentIndex == index,
                                  true,
                                  navFocusNode: index == 0,
                                  shouldExpand,
                                ),
                              ),
                            ),
                            if (views.isNotEmpty && largeBar) ...[
                              const Divider(
                                indent: 32,
                                endIndent: 32,
                              ),
                              Flexible(
                                child: SimpleOverflowWidget(
                                  axis: Axis.vertical,
                                  children: views.map(
                                    (view) {
                                      final selected = context.router.currentUrl.contains(view.id);
                                      final actions = [
                                        ItemActionButton(
                                          label: Text(context.localized.scanLibrary),
                                          icon: const Icon(IconsaxPlusLinear.refresh),
                                          action: () => showRefreshPopup(context, view.id, view.name),
                                        )
                                      ];
                                      return CustomTooltip(
                                        tooltipContent: expandedSideBar
                                            ? null
                                            : Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: FladderTheme.smallShape.borderRadius,
                                                  color: Theme.of(context).colorScheme.surface,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12),
                                                  child: Text(
                                                    view.name,
                                                    style: Theme.of(context).textTheme.titleSmall,
                                                  ),
                                                ),
                                              ),
                                        position: TooltipPosition.right,
                                        child: view.toNavigationButton(
                                          selected,
                                          true,
                                          shouldExpand,
                                          () => view.navigateToView(context),
                                          onSecondaryTapDown: (details) => _showContextMenu(
                                            context,
                                            ref,
                                            details.globalPosition,
                                            actions,
                                          ),
                                          onLongPress: () => showBottomSheetPill(
                                            context: context,
                                            content: (context, scrollController) => ListView(
                                              shrinkWrap: true,
                                              controller: scrollController,
                                              children: actions.listTileItems(context, useIcons: true),
                                            ),
                                          ),
                                          customIcon: usePostersForLibrary
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: FladderTheme.smallShape.borderRadius,
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: SizedBox.square(
                                                    dimension: 45,
                                                    child: FladderImage(
                                                      image: view.imageData?.primary,
                                                      placeHolder: Card(
                                                        child: Icon(
                                                          selected
                                                              ? view.collectionType.icon
                                                              : view.collectionType.iconOutlined,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : null,
                                          trailing: actions,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  overflowBuilder: (remainingCount) => CustomTooltip(
                                    tooltipContent: expandedSideBar
                                        ? null
                                        : Container(
                                            decoration: BoxDecoration(
                                              borderRadius: FladderTheme.smallShape.borderRadius,
                                              color: Theme.of(context).colorScheme.surface,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Text(
                                                context.localized.moreOptions,
                                                style: Theme.of(context).textTheme.titleSmall,
                                              ),
                                            ),
                                          ),
                                    position: TooltipPosition.right,
                                    child: PopupMenuButton(
                                      iconColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                                      padding: EdgeInsets.zero,
                                      tooltip: "",
                                      icon: ExcludeFocus(
                                        child: NavigationButton(
                                          label: context.localized.other,
                                          selectedIcon: const Icon(IconsaxPlusLinear.arrow_square_down),
                                          icon: const Icon(IconsaxPlusLinear.arrow_square_down),
                                          expanded: shouldExpand,
                                          customIcon: usePostersForLibrary
                                              ? ClipRRect(
                                                  borderRadius: FladderTheme.smallShape.borderRadius,
                                                  child: const SizedBox.square(
                                                    dimension: 50,
                                                    child: Card(
                                                      child: Icon(IconsaxPlusLinear.arrow_square_down),
                                                    ),
                                                  ),
                                                )
                                              : null,
                                          horizontal: true,
                                        ),
                                      ),
                                      itemBuilder: (context) => views
                                          .sublist(views.length - remainingCount)
                                          .map(
                                            (e) => PopupMenuItem(
                                              onTap: () => e.navigateToView(context),
                                              child: Row(
                                                spacing: 8,
                                                children: [
                                                  usePostersForLibrary
                                                      ? Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                                          child: ClipRRect(
                                                            borderRadius: FladderTheme.smallShape.borderRadius,
                                                            child: SizedBox.square(
                                                              dimension: 45,
                                                              child: FladderImage(
                                                                image: e.imageData?.primary,
                                                                placeHolder: Card(
                                                                  child: Icon(
                                                                    e.collectionType.iconOutlined,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Icon(e.collectionType.iconOutlined),
                                                  Text(e.name),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      NavigationButton(
                        label: context.localized.settings,
                        selected: widget.currentLocation.contains(const SettingsRoute().routeName),
                        selectedIcon: const Icon(IconsaxPlusBold.setting_3),
                        horizontal: true,
                        expanded: shouldExpand,
                        icon: const SizedBox.shrink(),
                        customIcon: const ExcludeFocusTraversal(
                            child: SizedBox.square(dimension: 45, child: SettingsUserIcon())),
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
      ],
    );
  }

  Future<void> _showContextMenu(BuildContext context, WidgetRef ref, Offset globalPos, List<ItemAction> actions) async {
    final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
    await showMenu(
      context: context,
      position: position,
      items: actions.popupMenuItems(useIcons: true),
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

class _RailTraversalPolicy extends ReadingOrderTraversalPolicy {
  _RailTraversalPolicy();

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.left) {
      return false;
    }
    if (direction == TraversalDirection.right) {
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
