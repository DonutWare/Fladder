import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/video_player/components/video_player_chapters.dart';
import 'package:fladder/screens/video_player/components/video_player_queue.dart';

class ChapterButton extends ConsumerWidget {
  final Duration position;
  final Player player;
  const ChapterButton({super.key, required this.position, required this.player});

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
            onChapterTapped: (chapter) => player.seek(
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

class IntroSkipButton extends ConsumerWidget {
  final bool isOverlayVisible;

  final Function()? skipIntro;
  const IntroSkipButton({this.skipIntro, required this.isOverlayVisible, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => skipIntro?.call(),
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text("(S)kip Intro"), Icon(Icons.skip_next_rounded)],
        ),
      ),
    );
  }
}

class OutroSkipButton extends ConsumerWidget {
  final bool isOverlayVisible;
  final Function()? skipOutro;
  const OutroSkipButton({this.skipOutro, required this.isOverlayVisible, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final semiHideSkip = skipCredits.
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 250),
      child: ElevatedButton(
        onPressed: () => skipOutro?.call(),
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("(S)kip Credits"), Icon(Icons.skip_next_rounded)],
          ),
        ),
      ),
    );
  }
}
