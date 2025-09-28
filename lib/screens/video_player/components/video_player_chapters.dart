import 'package:cached_network_image/cached_network_image.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showPlayerChapterDialogue(
  BuildContext context, {
  required List<Chapter> chapters,
  required Function(Chapter chapter) onChapterTapped,
  required Duration currentPosition,
}) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: VideoPlayerChapters(
        chapters: chapters,
        onChapterTapped: onChapterTapped,
        currentPosition: currentPosition,
      ),
    ),
  );
}

class VideoPlayerChapters extends ConsumerWidget {
  final List<Chapter> chapters;
  final Function(Chapter chapter) onChapterTapped;
  final Duration currentPosition;
  const VideoPlayerChapters(
      {required this.chapters, required this.onChapterTapped, required this.currentPosition, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChapter = chapters.getChapterFromDuration(currentPosition);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HorizontalList(
          label: "Chapters",
          height: 200,
          startIndex: chapters.indexOf(currentChapter ?? chapters.first),
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          items: chapters.toList(),
          itemBuilder: (context, index, selected) {
            final chapter = chapters[index];
            final isCurrent = chapter == currentChapter;
            return Card(
              color: Colors.black,
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: chapter.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Card(
                      color: isCurrent ? Theme.of(context).colorScheme.onPrimary : null,
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          chapter.name,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: FlatButton(
                      onTap: () {
                        Navigator.of(context).pop();
                        onChapterTapped(chapter);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
