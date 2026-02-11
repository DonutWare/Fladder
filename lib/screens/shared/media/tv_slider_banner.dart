import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/media/components/media_header.dart';
import 'package:fladder/screens/shared/media/components/media_play_button.dart';
import 'package:fladder/screens/shared/media/components/small_detail_widgets.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/widgets/navigation_scaffold/components/top_navigation_bar.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

const Duration _kAnimationDuration = Duration(milliseconds: 350);

enum _SlideDirection { left, right }

class TVSliderBanner extends ConsumerStatefulWidget {
  final List<ItemBaseModel> items;
  final Function(ItemBaseModel selected) onSelect;
  final double maxHeight;

  const TVSliderBanner({
    required this.items,
    required this.onSelect,
    required this.maxHeight,
    super.key,
  });

  @override
  ConsumerState<TVSliderBanner> createState() => _FocusedFullBannerState();
}

class _FocusedFullBannerState extends ConsumerState<TVSliderBanner> {
  int _currentIndex = 0;
  _SlideDirection _slideDirection = _SlideDirection.right;

  ItemBaseModel get _currentItem => widget.items[_currentIndex];

  bool _hasFocus = false;

  void _navigateLeft() {
    setState(() {
      _slideDirection = _SlideDirection.left;
      _currentIndex = _currentIndex > 0 ? _currentIndex - 1 : widget.items.length - 1;
    });
  }

  void _navigateRight() {
    setState(() {
      _slideDirection = _SlideDirection.right;
      _currentIndex = (_currentIndex + 1) % widget.items.length;
    });
  }

  bool _focusTopBar() {
    if (!topBarNode.canRequestFocus || topBarNode.context?.mounted != true) {
      return false;
    }

    final focused = topBarNode.focusedChild;
    if (focused != null && focused.canRequestFocus) {
      focused.requestFocus();
      return true;
    }

    for (final descendant in topBarNode.descendants) {
      if (descendant.canRequestFocus && !descendant.skipTraversal) {
        descendant.requestFocus();
        return true;
      }
    }

    return false;
  }

  KeyEventResult _handleFocusKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _navigateLeft();
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _navigateRight();
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (_focusTopBar()) {
        return KeyEventResult.handled;
      }
      Actions.maybeInvoke(context, const DirectionalFocusIntent(TraversalDirection.up));
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final radius = FladderTheme.largeShape.borderRadius;

    final isDpad = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: widget.maxHeight * 1.3,
        child: FocusButton(
          onTap: () => isDpad ? _currentItem.play(context, ref) : _currentItem.navigateTo(context),
          onLongPress: () => _showBottomSheet(context, ref),
          onSecondaryTapDown: (details) => _showContextMenu(context, ref, details.globalPosition),
          visualizeFocus: false,
          borderRadius: radius,
          onKeyEvent: _handleFocusKeyEvent,
          onFocusChanged: (focused) {
            setState(() => _hasFocus = focused);
            if (focused) {
              context.ensureVisible();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
            ),
            clipBehavior: Clip.hardEdge,
            child: AnimatedSwitcher(
              duration: _kAnimationDuration,
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: Offset(_slideDirection == _SlideDirection.right ? 0.1 : -0.1, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ));

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: FladderImage(
                key: ValueKey(_currentItem.id),
                image: _currentItem.tvPosterLarge,
                fit: BoxFit.cover,
              ),
            ),
          ),
          focusedOverlays: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ExcludeFocus(
                  child: _NavigationIndicator(
                    items: widget.items,
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _slideDirection = index > _currentIndex ? _SlideDirection.right : _SlideDirection.left;
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
          overlays: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Flexible(
                      child: IgnorePointer(
                        child: _BannerInfoOverlay(poster: _currentItem),
                      ),
                    ),
                    MediaPlayButton(
                      item: _currentItem,
                      forceFocusOutline: _hasFocus,
                      showRestartOption: !isDpad,
                      onPressed: (restart) {
                        if (restart) {
                          _currentItem.play(context, ref, startPosition: Duration.zero);
                        } else {
                          _currentItem.play(context, ref);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    showBottomSheetPill(
      context: context,
      item: _currentItem,
      content: (scrollContext, scrollController) => ListView(
        shrinkWrap: true,
        controller: scrollController,
        children: _currentItem
            .generateActions(
              context,
              ref,
            )
            .listTileItems(scrollContext, useIcons: true),
      ),
    );
  }

  Future<void> _showContextMenu(BuildContext context, WidgetRef ref, Offset globalPos) async {
    final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
    await showMenu(
      context: context,
      position: position,
      items: _currentItem
          .generateActions(
            context,
            ref,
          )
          .popupMenuItems(useIcons: true),
    );
  }
}

class _BannerInfoOverlay extends StatelessWidget {
  final ItemBaseModel poster;

  const _BannerInfoOverlay({required this.poster});

  @override
  Widget build(BuildContext context) {
    const opacity = 0.95;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            child: MediaHeader(
              name: poster.name,
              alignment: Alignment.topLeft,
              textAlign: TextAlign.start,
              logo: poster.tvPosterLogo,
            ),
          ),
        ),
        ...switch (poster) {
          EpisodeModel episode => [
              Row(
                spacing: 12,
                children: [
                  Text(
                    episode.episodeLabel(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.white,
                  ),
                  MetadataLabels(
                    favourite: poster.userData.isFavourite ? true : null,
                    officialRating: episode.overview.parentalRating,
                    productionYear: episode.overview.productionYear?.toString(),
                    communityRating: episode.overview.communityRating,
                    runTime: episode.overview.runTime,
                    watched: episode.userData.played == true ? true : null,
                  ),
                ],
              ),
              Text(
                episode.overview.summary,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: opacity)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          _ => [
              MetadataLabels(
                favourite: poster.userData.isFavourite ? true : null,
                officialRating: poster.overview.parentalRating,
                productionYear: poster.overview.productionYear?.toString(),
                communityRating: poster.overview.communityRating,
                runTime: poster.overview.runTime,
                watched: poster.userData.played == true ? true : null,
              ),
              Genres(
                genres: poster.overview.genreItems.take(6).toList(),
              ),
              Text(
                poster.overview.summary,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: opacity)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
        },
      ],
    );
  }
}

class _NavigationIndicator extends StatelessWidget {
  final List<ItemBaseModel> items;
  final int currentIndex;
  final Function(int index)? onTap;

  const _NavigationIndicator({
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 12.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: List.generate(items.length, (index) {
        final selected = index == currentIndex;
        return InkWell(
          onTap: () => onTap?.call(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 125),
            width: selected ? size * 2 : size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(selected ? 225 : 100),
              borderRadius: BorderRadius.circular(64),
            ),
          ),
        );
      }),
    );
  }
}
