import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/media/components/media_header.dart';
import 'package:fladder/screens/shared/media/components/poster_overlays.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

const Duration _kAnimationDuration = Duration(milliseconds: 200);

class TVPosterRow extends ConsumerStatefulWidget {
  final List<ItemBaseModel> posters;
  final String label;
  final double primaryRatio;
  final EdgeInsets contentPadding;
  final Function()? onLabelClick;
  final Function(ItemBaseModel focused)? onFocused;
  final bool primaryPosters;
  final bool autoFocus;

  const TVPosterRow({
    required this.posters,
    required this.label,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.primaryRatio = 0.67,
    this.onLabelClick,
    this.onFocused,
    this.primaryPosters = false,
    this.autoFocus = false,
    super.key,
  });

  @override
  ConsumerState<TVPosterRow> createState() => _TVPosterRowState();
}

class _TVPosterRowState extends ConsumerState<TVPosterRow> {
  static const double _smallAspectRatio = 0.67;
  static const double _largeAspectRatio = 1.76;

  int _selectedIndex = 0;
  bool _hasFocus = false;

  @override
  void didUpdateWidget(covariant TVPosterRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedIndex >= widget.posters.length && widget.posters.isNotEmpty) {
      setState(() {
        _selectedIndex = widget.posters.length - 1;
      });
    }
  }

  double _basePosterHeight(BuildContext context) {
    final posterSize = ref.watch(clientSettingsProvider.select((value) => value.posterSize));
    final posterDefaults = AdaptiveLayout.poster(context);
    return ((posterDefaults.size * posterSize) / math.pow(_smallAspectRatio, 0.55)) * 0.7;
  }

  double _itemWidth(int index, double posterHeight) {
    if (_hasFocus && index == _selectedIndex) {
      return posterHeight * _largeAspectRatio;
    }
    return posterHeight * _smallAspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posters.isEmpty) return const SizedBox.shrink();

    final selectedPoster = widget.posters[_selectedIndex];
    final posterHeight = _basePosterHeight(context);

    final animationDelay = _kAnimationDuration * 0.25;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Flexible(
          child: HorizontalList(
            autoFocus: widget.autoFocus,
            label: widget.label.isNotEmpty ? widget.label : null,
            onLabelClick: widget.onLabelClick,
            contentPadding: widget.contentPadding,
            height: posterHeight,
            items: widget.posters,
            itemWidthBuilder: (index) => _itemWidth(index, posterHeight),
            onFocusChange: (hasFocus) async {
              if (hasFocus == _hasFocus) return;
              if (hasFocus) {
                await Future.delayed(animationDelay);
                context.ensureVisible(
                  alignment: 0.35,
                );
              }
              setState(() => _hasFocus = hasFocus);
            },
            onFocused: (index) {
              final changed = index != _selectedIndex;
              setState(() {
                _selectedIndex = index;
                _hasFocus = true;
              });
              if (changed || widget.onFocused != null) {
                widget.onFocused?.call(widget.posters[index]);
              }
            },
            itemBuilder: (context, index) {
              final poster = widget.posters[index];
              final isSelected = index == _selectedIndex;
              final isFocused = isSelected && _hasFocus;
              return _TVPosterItem(
                poster: poster,
                height: posterHeight,
                width: _itemWidth(index, posterHeight),
                selected: isSelected,
                focused: isFocused,
                onFocusChanged: (focused) {
                  if (focused) {
                    setState(() => _selectedIndex = index);
                    widget.onFocused?.call(poster);
                  }
                },
                primaryPosters: isFocused || widget.primaryPosters,
                onTap: () => poster.navigateTo(context, ref: ref),
              );
            },
          ),
        ),
        if (_hasFocus)
          Padding(
            padding: widget.contentPadding,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 125),
              child: _TVBottomInfo(
                key: ValueKey(selectedPoster.id),
                poster: selectedPoster,
              ),
            ),
          )
      ],
    );
  }
}

class _TVPosterItem extends ConsumerWidget {
  final ItemBaseModel poster;
  final double width;
  final double height;
  final bool selected;
  final bool focused;
  final Function(bool focused)? onFocusChanged;
  final bool primaryPosters;
  final VoidCallback onTap;

  const _TVPosterItem({
    required this.poster,
    required this.width,
    required this.height,
    required this.selected,
    required this.focused,
    this.onFocusChanged,
    required this.primaryPosters,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayColor = Theme.of(context).colorScheme.surfaceContainer.harmonizeWith(Colors.black);

    final radius = FladderTheme.defaultShape.borderRadius;

    return FocusButton(
      onTap: onTap,
      onLongPress: () => _showBottomSheet(context, ref),
      onSecondaryTapDown: (details) => _showContextMenu(context, ref, details.globalPosition),
      onFocusChanged: onFocusChanged,
      child: AnimatedContainer(
        duration: _kAnimationDuration,
        curve: Curves.easeInOut,
        width: width,
        height: height,
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
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: _kAnimationDuration,
                transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                child: focused
                    ? FladderImage(
                        key: ValueKey(poster.tvPosterLarge?.key ?? "${poster.id}_large"),
                        image: poster.tvPosterLarge,
                        disableBlur: true,
                        placeHolder: const _TVPosterPlaceholder(),
                      )
                    : FladderImage(
                        key: ValueKey(poster.tvPosterSmall?.key ?? "${poster.id}_small"),
                        image: poster.tvPosterSmall,
                        placeHolder: const _TVPosterPlaceholder(),
                      ),
              ),
              if (focused) ...[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          overlayColor.withAlpha(200),
                          overlayColor.withAlpha(25),
                          overlayColor.withAlpha(0),
                        ],
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FractionallySizedBox(
                        widthFactor: 0.6,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: MediaHeader(
                              name: poster.name,
                              alignment: Alignment.bottomLeft,
                              logo: poster.tvPosterLogo,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                BottomOverlaysContainer(
                  showFavourite: false,
                  showProgress: true,
                  progress: poster.progress,
                  progressHeight: 8.5,
                  itemType: poster.type,
                  progressPadding: const EdgeInsets.all(6),
                ),
              ],
              VideoDurationOverlay(
                poster: poster,
                padding: const EdgeInsets.all(6.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    showBottomSheetPill(
      context: context,
      item: poster,
      content: (scrollContext, scrollController) => ListView(
        shrinkWrap: true,
        controller: scrollController,
        children: poster
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
      items: poster
          .generateActions(
            context,
            ref,
          )
          .popupMenuItems(useIcons: true),
    );
  }
}

class _TVBottomInfo extends StatelessWidget {
  final ItemBaseModel poster;
  const _TVBottomInfo({
    required this.poster,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = 0.65;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: switch (poster) {
          ChannelModel model => [
              ClickableText(
                onTap: AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer
                    ? () => poster.parentBaseModel.navigateTo(context)
                    : null,
                text: model.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (model.subText?.isNotEmpty ?? false)
                    Flexible(
                      child: ClickableText(
                        opacity: opacity,
                        text: model.subText ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    )
                  else
                    Flexible(
                      child: ClickableText(
                        opacity: opacity,
                        text: model.subTextShort(context) ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              ClickableText(
                opacity: opacity,
                text: model.subText?.isNotEmpty ?? false ? model.subTextShort(context) ?? "" : "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          EpisodeModel episode => [
              Row(
                spacing: 12,
                children: [
                  Text(
                    episode.episodeLabel(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
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
                style: Theme.of(context).textTheme.bodyLarge,
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
              Text(
                poster.overview.summary,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
        },
      ),
    );
  }
}

class _TVPosterPlaceholder extends StatelessWidget {
  const _TVPosterPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          IconsaxPlusLinear.image,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          size: 36,
        ),
      ),
    );
  }
}
