import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/syncing/sync_button.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/disable_keypad_focus.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/status_card.dart';

class EpisodePosters extends ConsumerStatefulWidget {
  final List<EpisodeModel> episodes;
  final String? label;
  final ValueChanged<EpisodeModel> playEpisode;
  final EdgeInsets contentPadding;
  final Function(VoidCallback action, EpisodeModel episodeModel)? onEpisodeTap;
  const EpisodePosters({
    this.label,
    required this.contentPadding,
    required this.playEpisode,
    required this.episodes,
    this.onEpisodeTap,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodePosterState();
}

class _EpisodePosterState extends ConsumerState<EpisodePosters> {
  late int? selectedSeason = widget.episodes.nextUp?.season;

  List<EpisodeModel> get episodes {
    if (selectedSeason == null) {
      return widget.episodes;
    } else {
      return widget.episodes.where((element) => element.season == selectedSeason).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final indexOfCurrent = (episodes.nextUp != null ? episodes.indexOf(episodes.nextUp!) : 0).clamp(0, episodes.length);
    final episodesBySeason = widget.episodes.episodesBySeason;
    final allPlayed = episodes.allPlayed;

    return HorizontalList(
      label: widget.label,
      titleActions: [
        if (episodesBySeason.isNotEmpty && episodesBySeason.length > 1) ...{
          const SizedBox(width: 12),
          EnumBox(
            current: selectedSeason != null ? "${context.localized.season(1)} $selectedSeason" : context.localized.all,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(context.localized.all),
                onTap: () => setState(() => selectedSeason = null),
              ),
              ...episodesBySeason.entries.map(
                (e) => PopupMenuItem(
                  child: Text("${context.localized.season(1)} ${e.key}"),
                  onTap: () {
                    setState(() => selectedSeason = e.key);
                  },
                ),
              )
            ],
          )
        },
      ],
      height: AdaptiveLayout.poster(context).gridRatio,
      contentPadding: widget.contentPadding,
      startIndex: indexOfCurrent,
      items: episodes,
      itemBuilder: (context, index) {
        final episode = episodes[index];
        final isCurrentEpisode = index == indexOfCurrent;
        final syncedItem = ref.watch(syncProvider.notifier).getSyncedItem(episode);
        return EpisodePoster(
          episode: episode,
          blur: allPlayed ? false : indexOfCurrent < index,
          syncedItem: syncedItem,
          onTap: widget.onEpisodeTap != null
              ? () {
                  widget.onEpisodeTap?.call(
                    () {
                      episode.navigateTo(context);
                    },
                    episode,
                  );
                }
              : () {
                  episode.navigateTo(context);
                },
          onLongPress: () {
            showBottomSheetPill(
              context: context,
              item: episode,
              content: (context, scrollController) {
                return ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: [
                    ...episode.generateActions(context, ref).listTileItems(context, useIcons: true),
                  ],
                );
              },
            );
          },
          actions: episode.generateActions(context, ref),
          isCurrentEpisode: isCurrentEpisode,
        );
      },
    );
  }
}

class EpisodePoster extends ConsumerWidget {
  final EpisodeModel episode;
  final SyncedItem? syncedItem;
  final bool showLabel;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool blur;
  final List<ItemAction> actions;
  final bool isCurrentEpisode;

  const EpisodePoster({
    super.key,
    required this.episode,
    this.syncedItem,
    this.showLabel = true,
    this.onTap,
    this.onLongPress,
    this.blur = false,
    required this.actions,
    required this.isCurrentEpisode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget placeHolder = Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Icon(Icons.local_movies_outlined),
    );
    final SyncedItem? iSyncedItem = syncedItem;
    bool episodeAvailable = episode.status == EpisodeStatus.available;
    return AspectRatio(
      aspectRatio: 1.76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Card(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FladderImage(
                    image: !episodeAvailable ? episode.parentImages?.primary : episode.images?.primary,
                    placeHolder: placeHolder,
                    blurOnly: !episodeAvailable
                        ? true
                        : ref.watch(clientSettingsProvider.select((value) => value.blurUpcomingEpisodes))
                            ? blur
                            : false,
                  ),
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
                        if (iSyncedItem != null)
                          Consumer(builder: (context, ref, child) {
                            final SyncStatus syncStatus =
                                ref.watch(syncStatusesProvider(iSyncedItem)).value ?? SyncStatus.partially;
                            return StatusCard(
                              color: syncStatus.color,
                              child: SyncButton(item: episode, syncedItem: syncedItem),
                            );
                          }),
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return FlatButton(
                        onSecondaryTapDown: (details) {
                          Offset localPosition = details.globalPosition;
                          RelativeRect position = RelativeRect.fromLTRB(
                              localPosition.dx - 260, localPosition.dy, localPosition.dx, localPosition.dy);

                          showMenu(context: context, position: position, items: actions.popupMenuItems(useIcons: true));
                        },
                        onTap: onTap,
                        onLongPress: onLongPress,
                      );
                    },
                  ),
                  if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer && actions.isNotEmpty)
                    DisableFocus(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: PopupMenuButton(
                          tooltip: "Options",
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 8.0),
                              const Shadow(color: Colors.black, blurRadius: 16.0),
                              const Shadow(color: Colors.black, blurRadius: 32.0),
                              const Shadow(color: Colors.black, blurRadius: 64.0),
                            ],
                          ),
                          itemBuilder: (context) => actions.popupMenuItems(useIcons: true),
                        ),
                      ),
                    ),
                ],
              ),
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
                  child: ClickableText(
                    text: episode.episodeLabel(context),
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
