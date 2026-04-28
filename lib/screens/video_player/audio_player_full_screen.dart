import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/video_player/components/video_player_queue.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/button_group.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:fladder/widgets/shared/theme_overwrite.dart';

class AudioPlayerFullScreen extends ConsumerStatefulWidget {
  const AudioPlayerFullScreen({super.key});

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
    final currentIndex = queue.indexWhere((element) => element.id == currentItem.id);
    final upcoming = currentIndex >= 0
        ? queue.sublist(currentIndex + 1)
        : queue.where((element) => element.id != currentItem.id).toList();
    final previewQueue = upcoming.take(5).toList();
    final duration = playbackInfo.duration;

    if (!changingSliderValue) {
      sliderPosition = playbackInfo.position;
    }

    final artwork = currentItem.images?.primary;
    final queueCount = queue.length;

    final isFavourite = currentItem.userData.isFavourite;

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
                  Text(
                    currentItem.album!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(
                                125,
                              ),
                        ),
                  ),
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: isFavourite ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () {},
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

    Widget playbackOptions() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Playback options',
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
                label: const Text('Shuffle'),
                isSelected: playbackInfo.shuffleEnabled,
                onPressed: () => ref.read(videoPlayerProvider).setShuffleEnabled(!playbackInfo.shuffleEnabled),
              ),
              ExpressiveButton(
                icon: Icon(playbackInfo.repeatMode == AudioRepeatMode.one
                    ? IconsaxPlusBold.repeate_one
                    : IconsaxPlusBold.repeate_music),
                label: Text(playbackInfo.repeatMode == AudioRepeatMode.off
                    ? 'Repeat off'
                    : playbackInfo.repeatMode == AudioRepeatMode.one
                        ? 'Repeat one'
                        : 'Repeat all'),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.localized.nextUp,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (queueCount > 1)
                IconButton(
                  onPressed: () {
                    showFullScreenItemQueue(
                      context,
                      items: queue,
                      currentItem: currentItem,
                      onListChanged: ref.read(videoPlayerProvider.notifier).reorderAudioQueue,
                      playSelected: ref.read(videoPlayerProvider.notifier).playAudioQueueItem,
                    );
                  },
                  icon: const Icon(IconsaxPlusLinear.row_vertical),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (previewQueue.isEmpty)
            Text(
              'No upcoming tracks',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            )
          else
            ...previewQueue.map((item) {
              final isActive = item.id == currentItem.id;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: ClipOval(
                  child: SizedBox(
                    width: 36,
                    height: 36,
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
                ),
                subtitle: Text(
                  item.subTextShort(context.localized) ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing:
                    isActive ? Icon(Icons.play_arrow_rounded, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () => ref.read(videoPlayerProvider.notifier).playAudioQueueItem(item),
              );
            }),
        ],
      );
    }

    Widget albumArt() {
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
                    imageErrorBuilder: (context, error, stack) => Center(child: Icon(audioType.selectedicon, size: 56)),
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

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: FladderTheme.largeShape.borderRadius,
        ),
        clipBehavior: Clip.antiAlias,
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
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(mediaPlaybackProvider.notifier)
                                    .update((state) => state.copyWith(state: VideoPlayerState.minimized));
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_rounded),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            albumArt(),
                            const SizedBox(height: 24),
                            buildMetadata(context),
                            controls(context),
                          ],
                        ),
                        const Divider(),
                        playbackOptions(),
                        queuePreview(context),
                      ].addInBetween(const SizedBox(
                        height: 24,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
