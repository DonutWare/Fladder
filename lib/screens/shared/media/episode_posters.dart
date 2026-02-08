import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/screens/syncing/sync_button.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/focus_row.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/status_card.dart';

class EpisodePosters extends ConsumerStatefulWidget {
  final List<EpisodeModel> episodes;
  final List<SeasonModel> seasons;
  final String? label;
  final VerticalDirection? titleActionsPosition;
  final ValueChanged<EpisodeModel> playEpisode;
  final EdgeInsets contentPadding;
  final EpisodeModel? selectedEpisode;
  final Function(VoidCallback action, EpisodeModel episodeModel)? onEpisodeTap;
  final Function(EpisodeModel selected)? onFocused;
  const EpisodePosters({
    this.label,
    this.titleActionsPosition = VerticalDirection.up,
    required this.contentPadding,
    required this.playEpisode,
    required this.episodes,
    this.seasons = const [],
    this.onEpisodeTap,
    this.selectedEpisode,
    this.onFocused,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodePosterState();
}

class _EpisodePosterState extends ConsumerState<EpisodePosters> {
  late int? selectedSeason = widget.episodes.nextUp?.season;

  final FocusNode seasonFocusNode = FocusNode();

  List<EpisodeModel> get episodes {
    if (selectedSeason == null) {
      return widget.episodes;
    } else {
      return widget.episodes.where((element) => element.season == selectedSeason).toList();
    }
  }

  @override
  void dispose() {
    seasonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indexOfCurrent = (episodes.nextUp != null ? episodes.indexOf(episodes.nextUp!) : 0).clamp(0, episodes.length);
    final episodesBySeason = widget.episodes.episodesBySeason;
    final allPlayed = episodes.allPlayed;

    final isDPad = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;

    final constructSeasonNames = <int, String>{
      for (final entry in episodesBySeason.entries)
        entry.key: () {
          if (widget.seasons.isNotEmpty) {
            final season = widget.seasons.firstWhereOrNull((element) => element.season == entry.key);
            if (season != null) {
              return season.name;
            }
          }
          return "${context.localized.season(1)} ${entry.key}";
        }()
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        HorizontalList(
          label: widget.label,
          titleActionsPosition: widget.titleActionsPosition,
          onFocused: (index) {
            widget.onFocused?.call(episodes[index]);
          },
          titleActions: [
            if (episodesBySeason.isNotEmpty && episodesBySeason.length > 1 && !isDPad) ...{
              const SizedBox(width: 16),
              if (!isDPad)
                EnumBox(
                  current: selectedSeason != null
                      ? constructSeasonNames[selectedSeason!] ?? "${context.localized.season(1)} ${selectedSeason!}"
                      : context.localized.all,
                  onFocusChanged: (focused) {},
                  itemBuilder: (context) => [
                    ItemActionButton(
                      label: Text(context.localized.all),
                      action: () => setState(() => selectedSeason = null),
                    ),
                    ...episodesBySeason.entries.map(
                      (e) => ItemActionButton(
                        label: Text(constructSeasonNames[e.key] ?? "${context.localized.season(1)} ${e.key}"),
                        action: () {
                          setState(() => selectedSeason = e.key);
                        },
                      ),
                    )
                  ],
                )
            }
          ],
          contentPadding: widget.contentPadding,
          startIndex: indexOfCurrent,
          items: episodes,
          itemBuilder: (context, index) {
            final episode = episodes[index];
            final tag = UniqueKey();
            return EpisodePoster(
              episode: episode,
              heroTag: tag,
              blur: allPlayed ? false : indexOfCurrent < index,
              onTap: widget.onEpisodeTap != null
                  ? () {
                      widget.onEpisodeTap?.call(
                        () {
                          episode.navigateTo(context, tag: tag);
                        },
                        episode,
                      );
                    }
                  : () {
                      episode.navigateTo(context, tag: tag);
                    },
              onLongPress: () async {
                await showBottomSheetPill(
                  context: context,
                  item: episode,
                  content: (context, scrollController) {
                    return ListView(
                      shrinkWrap: true,
                      controller: scrollController,
                      children: episode.generateActions(context, ref).listTileItems(context, useIcons: true).toList(),
                    );
                  },
                );
                context.refreshData();
              },
              actions: episode.generateActions(context, ref),
              isCurrentEpisode: widget.selectedEpisode == episode,
            );
          },
        ),
        if (isDPad)
          FocusRow(
            focusNode: seasonFocusNode,
            child: Container(
              padding: widget.contentPadding,
              height: 40,
              child: Row(
                spacing: 8,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Builder(builder: (context) {
                        return Row(
                          children: [
                            ItemActionButton(
                              selected: selectedSeason == null,
                              label: Text(context.localized.all),
                              action: () => setState(() => selectedSeason = null),
                            ),
                            ...episodesBySeason.entries.map(
                              (e) => ItemActionButton(
                                selected: selectedSeason == e.key,
                                label: Text(constructSeasonNames[e.key] ?? "${context.localized.season(1)} ${e.key}"),
                                action: () {
                                  setState(() => selectedSeason = e.key);
                                },
                              ),
                            ),
                          ]
                              .groupButtons(
                                context,
                                useIcons: true,
                                shouldPop: false,
                              )
                              .addInBetween(
                                const SizedBox(width: 12),
                              ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class EpisodePoster extends ConsumerWidget {
  final EpisodeModel episode;
  final bool showLabel;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool blur;
  final List<ItemAction> actions;
  final Function(bool value)? onFocusChanged;
  final bool isCurrentEpisode;
  final Object? heroTag;

  const EpisodePoster({
    super.key,
    required this.episode,
    this.showLabel = true,
    this.onTap,
    this.onLongPress,
    this.blur = false,
    required this.actions,
    this.onFocusChanged,
    this.isCurrentEpisode = false,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget placeHolder = Container(
      height: double.infinity,
      child: const Icon(Icons.local_movies_outlined),
    );
    bool episodeAvailable = episode.status == EpisodeStatus.available;
    final syncedDetails = ref.watch(syncedItemProvider(episode));
    return AspectRatio(
      aspectRatio: 1.76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: FocusButton(
              onTap: onTap,
              onLongPress: onLongPress,
              onFocusChanged: onFocusChanged,
              onSecondaryTapDown: (details) async {
                Offset localPosition = details.globalPosition;
                RelativeRect position =
                    RelativeRect.fromLTRB(localPosition.dx, localPosition.dy, localPosition.dx, localPosition.dy);
                await showMenu(context: context, position: position, items: actions.popupMenuItems(useIcons: true));
              },
              child: Hero(
                tag: heroTag ?? UniqueKey(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: FladderTheme.smallShape.borderRadius,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: FladderImage(
                    image: !episodeAvailable ? episode.parentImages?.primary : episode.images?.primary,
                    placeHolder: placeHolder,
                    blurOnly: !episodeAvailable
                        ? true
                        : ref.watch(clientSettingsProvider.select((value) => value.blurUpcomingEpisodes))
                            ? blur
                            : false,
                  ),
                ),
              ),
              overlays: [
                if (!episodeAvailable)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        color: episode.status.color,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            episode.status.label(context),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      switch (syncedDetails) {
                        AsyncValue<SyncedItem?>(:final value) => Builder(
                            builder: (context) {
                              if (value == null) {
                                return const SizedBox.shrink();
                              }
                              return StatusCard(
                                child: SyncButton(item: episode, syncedItem: value),
                              );
                            },
                          ),
                      },
                      if (episode.userData.isFavourite)
                        const StatusCard(
                          color: Colors.red,
                          child: Icon(
                            Icons.favorite_rounded,
                          ),
                        ),
                      if (episode.userData.played)
                        StatusCard(
                          color: Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.check_rounded,
                          ),
                        ),
                    ],
                  ),
                ),
                if ((episode.userData.progress) > 0)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      backgroundColor: Colors.black.withValues(alpha: 0.75),
                      value: episode.userData.progress / 100,
                    ),
                  ),
              ],
              focusedOverlays: [
                if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer && actions.isNotEmpty)
                  ExcludeFocus(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: PopupMenuButton(
                        tooltip: context.localized.options,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => actions.popupMenuItems(useIcons: true),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (showLabel) ...{
            const SizedBox(height: 4),
            Row(
              children: [
                if (isCurrentEpisode)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                Flexible(
                  child: Text(
                    episode.episodeLabel(context),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          }
        ],
      ),
    );
  }
}
