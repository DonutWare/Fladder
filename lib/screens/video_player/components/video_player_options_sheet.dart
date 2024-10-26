import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/playback/direct_playback_model.dart';
import 'package:fladder/models/playback/offline_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/playback/transcode_playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/collections/add_to_collection.dart';
import 'package:fladder/screens/metadata/info_screen.dart';
import 'package:fladder/screens/playlists/add_to_playlists.dart';
import 'package:fladder/screens/video_player/components/video_player_queue.dart';
import 'package:fladder/screens/video_player/components/video_subtitle_controls.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/spaced_list_tile.dart';

Future<void> showVideoPlayerOptions(BuildContext context, Function() minimizePlayer) {
  return showBottomSheetPill(
    context: context,
    content: (context, scrollController) {
      return VideoOptions(
        controller: scrollController,
        minimizePlayer: minimizePlayer,
      );
    },
  );
}

class VideoOptions extends ConsumerStatefulWidget {
  final ScrollController controller;
  final Function() minimizePlayer;
  const VideoOptions({required this.controller, required this.minimizePlayer, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoOptionsMobileState();
}

class _VideoOptionsMobileState extends ConsumerState<VideoOptions> {
  late int page = 0;

  @override
  Widget build(BuildContext context) {
    final currentItem = ref.watch(playBackModel.select((value) => value?.item));
    final videoSettings = ref.watch(videoPlayerSettingsProvider);
    final currentMediaStreams = ref.watch(playBackModel.select((value) => value?.mediaStreams));

    Widget mainPage() {
      return ListView(
        key: const Key("mainPage"),
        shrinkWrap: true,
        controller: widget.controller,
        children: [
          InkWell(
            onTap: () => setState(() => page = 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentItem?.title ?? "",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Opacity(opacity: 0.1, child: Icon(Icons.info_outline_rounded))
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          if (!AdaptiveLayout.of(context).isDesktop)
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, child: Text(context.localized.screenBrightness)),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Opacity(
                            opacity: videoSettings.screenBrightness == null ? 0.5 : 1,
                            child: Slider(
                              value: videoSettings.screenBrightness ?? 1.0,
                              min: 0,
                              max: 1,
                              onChanged: (value) =>
                                  ref.read(videoPlayerSettingsProvider.notifier).setScreenBrightness(value),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref.read(videoPlayerSettingsProvider.notifier).setScreenBrightness(null),
                          icon: Opacity(
                            opacity: videoSettings.screenBrightness != null ? 0.5 : 1,
                            child: Icon(
                              IconsaxBold.autobrightness,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SpacedListTile(
            title: Text(context.localized.subtitles),
            content: Text(currentMediaStreams?.currentSubStream?.label(context) ?? context.localized.off),
            onTap: currentMediaStreams?.subStreams.isNotEmpty == true ? () => showSubSelection(context) : null,
          ),
          SpacedListTile(
            title: Text(context.localized.audio),
            content: Text(currentMediaStreams?.currentAudioStream?.label(context) ?? context.localized.off),
            onTap: currentMediaStreams?.audioStreams.isNotEmpty == true ? () => showAudioSelection(context) : null,
          ),
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: EnumSelection(
                    label: Text(context.localized.scale),
                    current: videoSettings.videoFit.name.toUpperCaseSplit(),
                    itemBuilder: (context) => BoxFit.values
                        .map((value) => PopupMenuItem(
                              value: value,
                              child: Text(value.name.toUpperCaseSplit()),
                              onTap: () => ref.read(videoPlayerSettingsProvider.notifier).setFitType(value),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          if (!AdaptiveLayout.of(context).isDesktop)
            ListTile(
              onTap: () => ref.read(videoPlayerSettingsProvider.notifier).setFillScreen(!videoSettings.fillScreen),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(context.localized.videoScalingFill),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                    value: videoSettings.fillScreen,
                    onChanged: (value) => ref.read(videoPlayerSettingsProvider.notifier).setFillScreen(value),
                  )
                ],
              ),
            ),
        ],
      );
    }

    Widget playbackSettings() {
      final playbackState = ref.watch(playBackModel);
      return ListView(
        key: const Key("PlaybackSettings"),
        shrinkWrap: true,
        controller: widget.controller,
        children: [
          navTitle("Playback Settings", null),
          if (playbackState?.queue.isNotEmpty == true)
            ListTile(
              leading: const Icon(Icons.video_collection_rounded),
              title: const Text("Show queue"),
              onTap: () {
                Navigator.of(context).pop();
                ref.read(videoPlayerProvider).pause();
                showFullScreenItemQueue(
                  context,
                  items: playbackState?.queue ?? [],
                  currentItem: playbackState?.item,
                  playSelected: (item) {
                    throw UnimplementedError();
                  },
                );
              },
            )
        ],
      );
    }

    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: switch (page) {
              1 => playbackSettings(),
              2 => itemInfo(currentItem, context),
              _ => mainPage(),
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  ListView itemInfo(ItemBaseModel? currentItem, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        navTitle(currentItem?.title, currentItem?.subTextShort(context)),
        if (currentItem != null) ...{
          if (currentItem.type == FladderItemType.episode)
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                widget.minimizePlayer();
                (this as EpisodeModel).parentBaseModel.navigateTo(context);
              },
              title: Text(context.localized.openShow),
            ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();
              widget.minimizePlayer();
              await currentItem.navigateTo(context);
            },
            title: Text(context.localized.showDetails),
          ),
          if (currentItem.type != FladderItemType.boxset)
            ListTile(
              onTap: () async {
                await addItemToCollection(context, [currentItem]);
                if (context.mounted) {
                  context.refreshData();
                }
              },
              title: Text(context.localized.addToCollection),
            ),
          if (currentItem.type != FladderItemType.playlist)
            ListTile(
              onTap: () async {
                await addItemToPlaylist(context, [currentItem]);
                if (context.mounted) {
                  context.refreshData();
                }
              },
              title: Text(context.localized.addToPlaylist),
            ),
          ListTile(
            onTap: () async {
              final response = await ref
                  .read(userProvider.notifier)
                  .setAsFavorite(!(currentItem.userData.isFavourite == true), currentItem.id);
              final newItem = currentItem.copyWith(userData: response?.body);
              final playbackModel = switch (ref.read(playBackModel)) {
                DirectPlaybackModel value => value.copyWith(item: newItem),
                TranscodePlaybackModel value => value.copyWith(item: newItem),
                OfflinePlaybackModel value => value.copyWith(item: newItem),
                _ => null
              };
              ref.read(playBackModel.notifier).update((state) => playbackModel);
              Navigator.of(context).pop();
            },
            title: Text(currentItem.userData.isFavourite == true
                ? context.localized.removeAsFavorite
                : context.localized.addAsFavorite),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              showInfoScreen(context, currentItem);
            },
            title: Text(context.localized.info),
          ),
        }
      ],
    );
  }

  Widget navTitle(String? title, String? subText) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            BackButton(
              onPressed: () => setState(() => page = 0),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                if (title != null)
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                if (subText != null)
                  Text(
                    subText,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
      ],
    );
  }
}

Future<void> showSubSelection(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final playbackModel = ref.watch(playBackModel);
          final player = ref.watch(videoPlayerProvider);
          return SimpleDialog(
            contentPadding: const EdgeInsets.only(top: 8, bottom: 24),
            title: Row(
              children: [
                Text(context.localized.subtitle),
                const Spacer(),
                IconButton.outlined(
                    onPressed: () {
                      Navigator.pop(context);
                      showSubtitleControls(
                        context: context,
                        label: context.localized.subtitleConfiguration,
                      );
                    },
                    icon: const Icon(Icons.display_settings_rounded))
              ],
            ),
            children: playbackModel?.subStreams?.mapIndexed(
              (index, subModel) {
                final selected = playbackModel.mediaStreams?.defaultSubStreamIndex == subModel.index;
                return ListTile(
                  title: Text(subModel.label(context)),
                  tileColor: selected ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : null,
                  subtitle: subModel.language.isNotEmpty
                      ? Opacity(opacity: 0.6, child: Text(subModel.language.capitalize()))
                      : null,
                  onTap: () async {
                    final newModel = await playbackModel.setSubtitle(subModel, player);
                    ref.read(playBackModel.notifier).update((state) => newModel);
                    if (newModel != null) {
                      await ref.read(playbackModelHelper).shouldReload(newModel);
                    }
                  },
                );
              },
            ).toList(),
          );
        },
      );
    },
  );
}

Future<void> showAudioSelection(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final playbackModel = ref.watch(playBackModel);
          final player = ref.watch(videoPlayerProvider);
          return SimpleDialog(
            contentPadding: const EdgeInsets.only(top: 8, bottom: 24),
            title: Row(
              children: [
                Text(context.localized.audio),
              ],
            ),
            children: playbackModel?.audioStreams?.mapIndexed(
              (index, audioStream) {
                final selected = playbackModel.mediaStreams?.defaultAudioStreamIndex == audioStream.index;
                return ListTile(
                    title: Text(audioStream.label(context)),
                    tileColor: selected ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : null,
                    subtitle: audioStream.language.isNotEmpty
                        ? Opacity(opacity: 0.6, child: Text(audioStream.language.capitalize()))
                        : null,
                    onTap: () async {
                      final newModel = await playbackModel.setAudio(audioStream, player);
                      ref.read(playBackModel.notifier).update((state) => newModel);
                      if (newModel != null) {
                        await ref.read(playbackModelHelper).shouldReload(newModel);
                      }
                    });
              },
            ).toList(),
          );
        },
      );
    },
  );
}
