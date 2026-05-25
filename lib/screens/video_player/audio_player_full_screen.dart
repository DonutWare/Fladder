import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/video_player/components/audio_player_queue_dialog.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/button_group.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/theme_overwrite.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class AudioPlayerFullScreen extends ConsumerStatefulWidget {
  const AudioPlayerFullScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioPlayerFullScreenState();
}

class _AudioPlayerFullScreenState extends ConsumerState<AudioPlayerFullScreen> {
  bool changingSliderValue = false;
  Duration sliderPosition = Duration.zero;

  ItemBaseModel? lastItem;

  Color? dominantColor;

  Future<void> fetchAlbumDominantColor() async {
    final currentItem = ref.read(playBackModel)?.item;
    if (currentItem == null) return;
    final newImage = currentItem.getPosters?.primary;
    if (newImage == null) return;
    final provider = newImage.imageProvider;
    final newColor = await getDominantColor(provider);
    if (!mounted) return;
    setState(() {
      dominantColor = newColor;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAlbumDominantColor();
  }

  @override
  Widget build(BuildContext context) {
    final playbackModel = ref.watch(playBackModel);
    final playbackInfo = ref.watch(mediaPlaybackProvider);
    final player = ref.watch(videoPlayerProvider);

    if (playbackModel == null || playbackModel.item is! AudioModel) {
      return Scaffold(
        body: Center(
          child: Text(
            context.localized.unknown,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
    }

    if (lastItem == null || lastItem!.id != playbackModel.item.id) {
      lastItem = playbackModel.item;
      fetchAlbumDominantColor();
    }

    final currentItem = playbackModel.item as AudioModel;
    final queue = playbackModel.queue;
    final shouldWrapQueue =
        playbackInfo.repeatMode == AudioRepeatMode.all || playbackInfo.repeatMode == AudioRepeatMode.one;
    final queueFromPlayer = player.audioQueueForDisplay(wrapAround: shouldWrapQueue);
    final queueFromCurrent = queueFromPlayer.isNotEmpty
        ? queueFromPlayer
        : _queueFromCurrent(queue, currentItem, wrapAround: shouldWrapQueue);
    final tempStart =
        queueFromPlayer.isNotEmpty ? player.temporaryQueueStartInDisplay(wrapAround: shouldWrapQueue) : null;
    final tempCount = queueFromPlayer.isNotEmpty ? (player.temporaryQueueCountInDisplay() ?? 0) : 0;

    final nowPlaying = queueFromCurrent.isNotEmpty ? queueFromCurrent.first : null;
    final nextUpItems = <ItemBaseModel>[];
    final existingItems = <ItemBaseModel>[];

    if (queueFromCurrent.isNotEmpty) {
      final tempStartValue = tempStart ?? -1;
      final tempEnd = tempStartValue + tempCount;
      for (var i = 1; i < queueFromCurrent.length; i++) {
        final isNextUp = tempStartValue >= 0 && tempCount > 0 && i >= tempStartValue && i < tempEnd;
        if (isNextUp) {
          nextUpItems.add(queueFromCurrent[i]);
        } else {
          existingItems.add(queueFromCurrent[i]);
        }
      }
    }
    final duration = playbackInfo.duration;

    if (!changingSliderValue) {
      sliderPosition = playbackInfo.position;
    }

    final artwork = currentItem.images?.primary;
    final queueCount = queueFromCurrent.length;
    final replayGainVolumeLevel = ref.watch(
      videoPlayerSettingsProvider.select((value) => value.replayGainVolumeLevel),
    );

    final isFavourite = currentItem.userData.isFavourite;

    void closeFullScreen() {
      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.minimized));
    }

    Widget buildMetadata(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  currentItem.artistNames.isNotEmpty ? currentItem.artistNames.join(', ') : currentItem.album ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                if (currentItem.album != null)
                  ClickableText(
                    text: currentItem.album!,
                    maxLines: 1,
                    onTap: () {
                      closeFullScreen();
                      currentItem.navigateTo(context, ref: ref);
                    },
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                const SizedBox(height: 10),
                AudioPropertyLabelsRow(item: currentItem, replayGainVolumeLevel: replayGainVolumeLevel),
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: isFavourite ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () async {
              final result = (await ref.read(userProvider.notifier).setAsFavorite(
                        !isFavourite,
                        currentItem.id,
                      ))
                  ?.body;

              if (result != null) {
                ref.read(playBackModel.notifier).update((state) => state?.updateUserData(result));
              }
            },
            iconSize: 32,
            icon: Icon(
              isFavourite ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
              shadows: [
                Shadow(
                  color: Theme.of(context).colorScheme.primary.withAlpha(125),
                  blurRadius: 24,
                )
              ],
            ),
          ),
        ],
      );
    }

    Widget playbackOptions(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localized.audioPlayerPlaybackOptionsTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              ExpressiveButton(
                icon: const Icon(IconsaxPlusBold.shuffle),
                label: Text(context.localized.audioPlayerShuffle),
                isSelected: playbackInfo.shuffleEnabled,
                onPressed: () => ref.read(videoPlayerProvider).setShuffleEnabled(!playbackInfo.shuffleEnabled),
              ),
              ExpressiveButton(
                icon: Icon(playbackInfo.repeatMode == AudioRepeatMode.one
                    ? IconsaxPlusBold.repeate_one
                    : IconsaxPlusBold.repeate_music),
                label: Text(playbackInfo.repeatMode == AudioRepeatMode.off
                    ? context.localized.audioPlayerRepeatOff
                    : playbackInfo.repeatMode == AudioRepeatMode.one
                        ? context.localized.audioPlayerRepeatOne
                        : context.localized.audioPlayerRepeatAll),
                isSelected: playbackInfo.repeatMode != AudioRepeatMode.off,
                onPressed: () {
                  final nextMode = switch (playbackInfo.repeatMode) {
                    AudioRepeatMode.off => AudioRepeatMode.one,
                    AudioRepeatMode.one => AudioRepeatMode.all,
                    AudioRepeatMode.all => AudioRepeatMode.off,
                  };
                  ref.read(videoPlayerProvider).setAudioRepeatMode(nextMode);
                },
              ),
            ],
          ),
        ],
      );
    }

    Widget queuePreview(BuildContext context) {
      Widget sectionHeader({
        required IconData icon,
        required String title,
        Widget? trailing,
      }) {
        return Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 4),
          child: Row(
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: trailing,
                ),
            ],
          ),
        );
      }

      Widget queueItem(
        ItemBaseModel item, {
        bool isCurrent = false,
        bool canRemove = true,
      }) {
        Future<void> removeItem() {
          return ref.read(videoPlayerProvider.notifier).removeAudioQueueItem(item);
        }

        return FocusButton(
          onTap: () {
            ref.read(videoPlayerProvider.notifier).playAudioQueueItem(item);
          },
          onSecondaryTapDown: (details) {
            final itemActions = item.generateActions(
              context,
              ref,
              exclude: {
                ItemActions.play,
                ItemActions.refreshMetaData,
              },
              onUserDataChanged: (newData) {
                if (newData == null) return;
                ref.read(playBackModel.notifier).update(
                      (state) => state?.updateUserData(newData),
                    );
              },
            );
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy,
                details.globalPosition.dx,
                details.globalPosition.dy,
              ),
              items: [
                if (canRemove)
                  ItemActionButton(
                    label: Text(context.localized.removeFromQueue),
                    icon: const Icon(IconsaxPlusLinear.minus_cirlce),
                    action: removeItem,
                  ),
                ItemActionButton(
                  label: Text(
                    context.localized.play(item.title),
                  ),
                  icon: const Icon(IconsaxPlusLinear.play),
                  action: () {
                    ref.read(videoPlayerProvider.notifier).playAudioQueueItem(item);
                  },
                ),
                ...itemActions,
              ].popupMenuItems(useIcons: true),
            );
          },
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            minLeadingWidth: 0,
            leading: ClipOval(
              child: SizedBox(
                width: 40,
                height: 40,
                child: FladderImage(
                  image: item.images?.primary,
                  fit: BoxFit.cover,
                  placeHolder: const Center(child: Icon(Icons.music_note_rounded, size: 20)),
                  imageErrorBuilder: (context, error, stack) =>
                      const Center(child: Icon(Icons.music_note_rounded, size: 20)),
                ),
              ),
            ),
            title: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: isCurrent ? FontWeight.bold : null,
                  ),
            ),
            subtitle: Text(
              item.subTextShort(context.localized) ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: isCurrent ? Icon(Icons.play_arrow_rounded, color: Theme.of(context).colorScheme.primary) : null,
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.localized.queue,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (queueCount > 0)
                IconButton(
                  onPressed: () {
                    showAudioQueueDialog(
                      context,
                      onSectionReorder: (section, oldIndex, newIndex) {
                        return ref.read(videoPlayerProvider.notifier).reorderAudioQueueSection(
                              section,
                              oldIndex,
                              newIndex,
                            );
                      },
                      playSelected: ref.read(videoPlayerProvider.notifier).playAudioQueueItem,
                    );
                  },
                  icon: const Icon(IconsaxPlusLinear.row_vertical),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (nowPlaying == null)
            Text(
              context.localized.queueIsEmpty,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            )
          else ...[
            if (nextUpItems.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(175),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    sectionHeader(
                      icon: IconsaxPlusBold.music_playlist,
                      title: context.localized.upNext,
                      trailing: IconButton(
                        tooltip: context.localized.clear,
                        onPressed: () async {
                          await ref.read(videoPlayerProvider.notifier).clearTemporaryQueue();
                        },
                        icon: const Icon(Icons.clear_all_rounded),
                      ),
                    ),
                    ...nextUpItems.map((item) => queueItem(item)),
                    const SizedBox(height: 8),
                  ],
                ),
              )
            ],
            if (existingItems.isEmpty)
              Opacity(
                opacity: 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    context.localized.queueIsEmpty,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            else
              ...existingItems.map((item) => queueItem(item)),
          ],
        ],
      );
    }

    Widget albumArt(BuildContext context) {
      final audioType = FladderItemType.audio;
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: 512,
              child: AspectRatio(
                aspectRatio: 1,
                child: FocusButton(
                  onTap: () {
                    closeFullScreen();
                    currentItem.navigateTo(context, ref: ref, tag: 'album');
                  },
                  onSecondaryTapDown: (details) {
                    final itemActions = currentItem.generateActions(
                      context,
                      ref,
                      exclude: {
                        ItemActions.play,
                        ItemActions.showAlbum,
                        ItemActions.details,
                        ItemActions.openParent,
                        ItemActions.openShow,
                        ItemActions.refreshMetaData,
                      },
                      onUserDataChanged: (newData) {
                        if (newData == null) return;
                        ref.read(playBackModel.notifier).update(
                              (state) => state?.updateUserData(newData),
                            );
                      },
                    );
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                      ),
                      items: itemActions.popupMenuItems(useIcons: true),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.surface.withAlpha(125),
                          blurRadius: 36,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    constraints: const BoxConstraints(
                      maxWidth: 512,
                      maxHeight: 512,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FladderImage(
                      image: artwork,
                      fit: BoxFit.cover,
                      placeHolder: Center(child: Icon(audioType.selectedicon, size: 56)),
                      imageErrorBuilder: (context, error, stack) =>
                          Center(child: Icon(audioType.selectedicon, size: 56)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget controls(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withAlpha(35),
                  blurRadius: 60,
                )
              ],
            ),
            child: FladderSlider(
              thumbWidth: 12,
              value: sliderPosition.inMilliseconds.toDouble().clamp(0, duration.inMilliseconds.toDouble()),
              min: 0,
              max: duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1,
              onChanged: (value) {
                setState(() {
                  sliderPosition = Duration(milliseconds: value.round());
                });
              },
              onChangeStart: (_) {
                setState(() {
                  changingSliderValue = true;
                });
              },
              onChangeEnd: (value) async {
                final position = Duration(milliseconds: value.round());
                await player.seek(position);
                await Future.delayed(const Duration(milliseconds: 250));
                if (player.lastState?.playing == true) {
                  await player.play();
                }
                setState(() {
                  changingSliderValue = false;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                playbackInfo.position.readAbleDuration,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                duration.readAbleDuration,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => ref.read(videoPlayerProvider).skipToPrevious(),
                icon: const Icon(IconsaxPlusBold.previous),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: () => ref.read(videoPlayerProvider).playOrPause(),
                iconSize: 42,
                icon: playbackInfo.playing ? const Icon(IconsaxPlusBold.pause) : const Icon(IconsaxPlusBold.play),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => ref.read(videoPlayerProvider).skipToNext(),
                icon: const Icon(IconsaxPlusBold.next),
              ),
            ],
          ),
        ],
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          closeFullScreen();
        }
      },
      child: ThemeOverwrite(
        color: dominantColor,
        child: (context) => Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                      0,
                      1,
                    ],
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
              ),
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: closeFullScreen,
                        icon: const Icon(IconsaxPlusLinear.arrow_down),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      albumArt(context),
                      const SizedBox(height: 24),
                      buildMetadata(context),
                      controls(context),
                    ],
                  ),
                  const Divider(),
                  playbackOptions(context),
                  queuePreview(context),
                ].addInBetween(const SizedBox(
                  height: 24,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ItemBaseModel> _queueFromCurrent(
    List<ItemBaseModel> queue,
    ItemBaseModel currentItem, {
    required bool wrapAround,
  }) {
    if (queue.isEmpty) return const <ItemBaseModel>[];
    final currentIndex = queue.indexWhere((item) => item.id == currentItem.id);
    if (currentIndex < 0) return List<ItemBaseModel>.from(queue);

    return <ItemBaseModel>[
      ...queue.sublist(currentIndex),
      if (wrapAround) ...queue.sublist(0, currentIndex),
    ];
  }
}

class AudioPropertyLabelsRow extends StatelessWidget {
  final AudioModel item;
  final ReplayGainVolumeLevel replayGainVolumeLevel;

  const AudioPropertyLabelsRow({required this.item, required this.replayGainVolumeLevel, super.key});

  String _formatDb(double value) {
    final rounded = value.toStringAsFixed(1);
    return '${value > 0 ? '+' : ''}$rounded dB';
  }

  String? _sampleRateLabel(int? sampleRate) {
    if (sampleRate == null || sampleRate <= 0) return null;
    if (sampleRate % 1000 == 0) {
      return '${sampleRate ~/ 1000} kHz';
    }
    return '${(sampleRate / 1000).toStringAsFixed(1)} kHz';
  }

  String? _replayGainLabel(double? gain) {
    if (gain == null || gain == 0) return null;

    final originalLabel = _formatDb(gain);
    final offset = replayGainVolumeLevel.replayGainOffsetDb;
    if (offset == 0) {
      return originalLabel;
    }

    final adjustedGain = replayGainVolumeLevel.adjustedReplayGainDb(gain);
    return '$originalLabel -> ${_formatDb(adjustedGain)}';
  }

  String? _bitDepthLabel(int? bitDepth) {
    if (bitDepth == null || bitDepth <= 0) return null;
    return '$bitDepth-bit';
  }

  String? _bitRateLabel(BuildContext context, int? bitRate) {
    if (bitRate == null || bitRate <= 0) return null;
    return '${bitRate ~/ 1000} ${context.localized.kbps}';
  }

  String? _channelsLabel(int? channels, String? channelLayout) {
    final layout = channelLayout?.trim();
    if (layout != null && layout.isNotEmpty) {
      return layout.toUpperCase();
    }
    if (channels == null || channels <= 0) return null;
    return '$channels ch';
  }

  String? _spatialFormatLabel(dto.AudioSpatialFormat? spatialFormat) {
    return switch (spatialFormat) {
      null || dto.AudioSpatialFormat.none => null,
      dto.AudioSpatialFormat.dolbyatmos => 'Dolby Atmos',
      dto.AudioSpatialFormat.dtsx => 'DTS:X',
      _ => null,
    };
  }

  String? _profileLabel(String? profile) {
    final trimmed = profile?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }

  List<String> _labels(BuildContext context) {
    final currentAudioStream = item.mediaStreams.currentAudioStream;
    return <String?>[
      if ((currentAudioStream?.codec ?? '').isNotEmpty) currentAudioStream!.codec.toUpperCase(),
      _sampleRateLabel(currentAudioStream?.sampleRate),
      _bitDepthLabel(currentAudioStream?.bitDepth),
      _bitRateLabel(context, currentAudioStream?.bitRate),
      _channelsLabel(currentAudioStream?.channels, currentAudioStream?.channelLayout),
      _profileLabel(currentAudioStream?.profile),
      _spatialFormatLabel(currentAudioStream?.spatialFormat),
      _replayGainLabel(item.normalizationGain),
    ].nonNulls.toList();
  }

  @override
  Widget build(BuildContext context) {
    final labels = _labels(context);
    if (labels.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: labels
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _AudioPropertyChip(value: entry),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PlaybackTypeChip extends StatelessWidget {
  final PlaybackModel playbackModel;

  const _PlaybackTypeChip({required this.playbackModel});

  @override
  Widget build(BuildContext context) {
    final type = switch (playbackModel) {
      DirectPlaybackModel _ => PlaybackType.directStream,
      TranscodePlaybackModel _ => PlaybackType.transcode,
      OfflinePlaybackModel _ => PlaybackType.offline,
      TvPlaybackModel _ => PlaybackType.tv,
      _ => null,
    };
    if (type == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(150),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(type.icon, size: 14, color: Theme.of(context).textTheme.labelMedium?.color),
            const SizedBox(width: 5),
            Text(type.name(context), style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _AudioPropertyChip extends StatelessWidget {
  final String value;

  const _AudioPropertyChip({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(150),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
