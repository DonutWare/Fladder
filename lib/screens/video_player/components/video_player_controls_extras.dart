import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/video_player/components/video_player_chapters.dart';
import 'package:fladder/screens/video_player/components/video_player_queue.dart';
import 'package:fladder/util/localization_helper.dart';

class ChapterButton extends ConsumerWidget {
  final Duration position;
  const ChapterButton({super.key, required this.position});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChapters = ref.watch(playBackModel.select((value) => value?.chapters));
    if (currentChapters != null) {
      return IconButton(
        onPressed: () {
          showPlayerChapterDialogue(
            context,
            chapters: currentChapters,
            currentPosition: position,
            onChapterTapped: (chapter) => ref.read(videoPlayerProvider).seek(
                  chapter.startPosition,
                ),
          );
        },
        icon: const Icon(
          Icons.video_collection_rounded,
        ),
      );
    } else {
      return Container();
    }
  }
}

class OpenQueueButton extends ConsumerWidget {
  const OpenQueueButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playBackModel);
    return IconButton(
      onPressed: state?.queue.isNotEmpty == true
          ? () {
              ref.read(videoPlayerProvider).pause();
              showFullScreenItemQueue(
                context,
                items: state?.queue ?? [],
                currentItem: state?.item,
                playSelected: (itemStreamModel) {
                  throw UnimplementedError();
                },
              );
            }
          : null,
      icon: const Icon(Icons.view_list_rounded),
    );
  }
}

class SkipSegmentButton extends ConsumerWidget {
  final MediaSegment? segment;
  final SegmentSkip? skipType;
  final bool isOverlayVisible;

  final Function() pressedSkip;
  const SkipSegmentButton({
    required this.segment,
    this.skipType,
    required this.isOverlayVisible,
    required this.pressedSkip,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedFadeSize(
      child: segment != null && skipType != SegmentSkip.none
          ? AnimatedOpacity(
              opacity: isOverlayVisible ? 1 : 0.15,
              duration: const Duration(milliseconds: 500),
              child: ElevatedButton(
                onPressed: pressedSkip,
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(context.localized.skipButtonLabel(segment!.type.label(context))),
                      const Icon(Icons.skip_next_rounded)
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(key: Key("Other")),
    );
  }
}
