import 'package:collection/collection.dart';
import 'package:fladder/util/custom_cache_manager.dart';
import 'package:fladder/util/sticky_header_text.dart';
import 'package:fladder/widgets/shared/chapter_timeline.dart';
import 'package:fladder/widgets/shared/trick_play_image.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class ChapterRow extends ConsumerWidget {
  final List<Chapter> chapters;
  final EdgeInsets contentPadding;
  final Function(Chapter)? onPressed;
  late final isTrickPlayValid =
      chapters.firstOrNull?.trickplayFallback?.allImagesValidWithCache() ?? Future.value(false);
  late final areChapterImagesValid = chapters.allChapterImagesValidWithCache();
  ChapterRow({required this.contentPadding, this.onPressed, required this.chapters, super.key});

  Future<Map<String, bool>> get canRenderImages async =>
      {"chapter": await areChapterImagesValid, "trickplay": await isTrickPlayValid};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: canRenderImages,
        builder: (context, canRender) {
          if (canRender.hasData && canRender.data!.values.any((i) => i == true)) {
            return HorizontalList(
              label: context.localized.chapter(chapters.length),
              height: AdaptiveLayout.poster(context).size / 1.75,
              items: chapters,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                List<ItemAction> generateActions() {
                  return [
                    ItemActionButton(
                        action: () => onPressed?.call(chapter), label: Text(context.localized.playFrom(chapter.name)))
                  ];
                }

                return FocusButton(
                  onSecondaryTapDown: (details) async {
                    Offset localPosition = details.globalPosition;
                    RelativeRect position =
                        RelativeRect.fromLTRB(localPosition.dx, localPosition.dy, localPosition.dx, localPosition.dy);
                    await showMenu(
                      context: context,
                      position: position,
                      items: generateActions().popupMenuItems(),
                    );
                  },
                  onLongPress: () {
                    showBottomSheetPill(
                      context: context,
                      content: (context, scrollController) {
                        return ListView(
                          shrinkWrap: true,
                          controller: scrollController,
                          children: [
                            ...generateActions().listTileItems(context),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: FladderTheme.smallShape.borderRadius,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      foregroundDecoration: FladderTheme.defaultPosterDecoration,
                      child: canRender.data!["chapter"] == true
                          ? AspectRatio(
                              aspectRatio: 1.75,
                              child: CachedNetworkImage(
                                imageUrl: chapter.imageUrl,
                                fit: BoxFit.cover,
                                cacheManager: CustomCacheManager.instance,
                              ))
                          : AspectRatio(
                              aspectRatio: chapter.trickplayFallback!.width / chapter.trickplayFallback!.height,
                              child: TrickPlayImage(
                                chapter.trickplayFallback!,
                                position: chapter.startPosition,
                              ))),
                  overlays: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: FladderTheme.smallShape.borderRadius,
                            color: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.75),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "${chapter.name} \n${chapter.startPosition.humanize ?? context.localized.start}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  focusedOverlays: [
                    if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ExcludeFocus(
                          child: PopupMenuButton(
                            tooltip: context.localized.options,
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => generateActions().popupMenuItems(),
                          ),
                        ),
                      )
                  ],
                );
              },
              contentPadding: contentPadding,
            );
          }
          return Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StickyHeaderText(label: context.localized.chapter(chapters.length)),
                ChapterTimeline(
                  chapters: chapters,
                  onPressed: onPressed,
                ),
              ],
            ),
          );
        });
  }
}
