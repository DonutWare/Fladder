import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';

final topBarNode = FocusScopeNode(debugLabel: 'topBarScope');

FocusNode? _lastContentFocus;
final _contentScopeNode = FocusScopeNode(debugLabel: 'topBarContentScope');

class TopNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final List<DestinationModel> destinations;
  final String currentLocation;
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const TopNavigationBar({
    required this.currentIndex,
    required this.destinations,
    required this.currentLocation,
    required this.child,
    required this.scaffoldKey,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = 12.0;
    final barHeight = 55.0;

    final height = barHeight + (MediaQuery.paddingOf(context).top + padding);
    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    final useBlurredBackground =
        ref.watch(clientSettingsProvider.select((value) => value.backgroundImage == BackgroundType.blurred)) &&
            !topBarNoBlurRoutes.contains(currentLocation);

    return Stack(
      children: [
        RepaintBoundary(
          child: FocusScope(
            node: _contentScopeNode,
            child: Actions(
              actions: <Type, Action<Intent>>{
                DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
                  onInvoke: (intent) {
                    final current = primaryFocus;
                    if (current == null) return null;

                    if (intent.direction == TraversalDirection.up) {
                      final handled = current.focusInDirection(TraversalDirection.up);
                      if (!handled) {
                        _lastContentFocus = current;
                        _focusTopBar();
                      }
                    } else {
                      current.focusInDirection(intent.direction);
                    }
                    return null;
                  },
                ),
              },
              child: AdaptiveLayoutBuilder(
                adaptiveLayout: AdaptiveLayout.of(context).copyWith(
                  topBarHeight: barHeight + padding,
                ),
                child: (context) => child,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: height,
          child: RepaintBoundary(
            child: IgnorePointer(
              child: useBlurredBackground
                  ? ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white.withAlpha(200),
                            Colors.white.withAlpha(0),
                          ],
                        ).createShader(
                          Rect.fromLTRB(0, 10, bounds.width, bounds.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: const BackgroundImage(),
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.surface.withAlpha(255),
                            Theme.of(context).colorScheme.surface.withAlpha(175),
                            Theme.of(context).colorScheme.surface.withAlpha(0),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
        RepaintBoundary(
          child: FocusScope(
            node: topBarNode,
            child: FocusTraversalGroup(
              policy: _TopBarTraversalPolicy(),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        actionButton(context).normal,
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ...destinations.mapIndexed(
                                  (index, destination) {
                                    final isActive = currentIndex == index;
                                    final icon = isActive ? destination.selectedIcon : destination.icon;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: FocusButton(
                                        onTap: () {
                                          _lastContentFocus = null;
                                          destination.action?.call();
                                        },
                                        darkOverlay: false,
                                        borderRadius: buttonShape.borderRadius,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primary.withAlpha(isActive ? 50 : 0),
                                            borderRadius: buttonShape.borderRadius,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          child: IconTheme(
                                            data: Theme.of(context).iconTheme.copyWith(
                                                  color: isActive
                                                      ? Theme.of(context).colorScheme.primary
                                                      : Theme.of(context).iconTheme.color,
                                                ),
                                            child: Row(
                                              spacing: 6,
                                              children: [
                                                if (icon != null) icon,
                                                Text(
                                                  destination.label,
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                        color: isActive
                                                            ? Theme.of(context).colorScheme.primary
                                                            : Theme.of(context).textTheme.titleMedium!.color,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        NavigationButton(
                          label: context.localized.settings,
                          selected: currentLocation.contains(const SettingsRoute().routeName),
                          selectedIcon: const Icon(IconsaxPlusBold.setting_3),
                          horizontal: true,
                          expanded: false,
                          icon: const ExcludeFocusTraversal(child: SettingsUserIcon()),
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
        )
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
}

void _focusTopBar() {
  final focused = topBarNode.focusedChild;
  if (focused != null && focused.canRequestFocus) {
    focused.requestFocus();
    return;
  }
  for (final descendant in topBarNode.descendants) {
    if (descendant.canRequestFocus && !descendant.skipTraversal) {
      descendant.requestFocus();
      return;
    }
  }
}

bool _focusFirstInContent() {
  for (final descendant in _contentScopeNode.descendants) {
    if (descendant.canRequestFocus && !descendant.skipTraversal && _isLaidOut(descendant)) {
      descendant.requestFocus();
      return true;
    }
  }
  WidgetsBinding.instance.addPostFrameCallback((_) {
    for (final descendant in _contentScopeNode.descendants) {
      if (descendant.canRequestFocus && !descendant.skipTraversal && _isLaidOut(descendant)) {
        descendant.requestFocus();
        return;
      }
    }
  });
  return false;
}

class _TopBarTraversalPolicy extends ReadingOrderTraversalPolicy {
  _TopBarTraversalPolicy();

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.up) {
      return false;
    }
    if (direction == TraversalDirection.down) {
      if (_lastContentFocus != null && _isLaidOut(_lastContentFocus!)) {
        _lastContentFocus!.requestFocus();
        _lastContentFocus = null;
        return true;
      } else {
        _lastContentFocus = null;
        return _focusFirstInContent();
      }
    }
    if (direction == TraversalDirection.left || direction == TraversalDirection.right) {
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
        index = direction == TraversalDirection.right ? -1 : sorted.length;
      }

      final nextIndex = direction == TraversalDirection.right ? index + 1 : index - 1;

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
  if (node.context == null || node.context?.mounted != true) return false;
  final ro = node.context?.findRenderObject();
  return ro is RenderBox && ro.hasSize;
}
