import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/disable_keypad_focus.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class ChapterRow extends ConsumerWidget {
  final List<Chapter> chapters;
  final EdgeInsets contentPadding;
  final Function(Chapter)? onPressed;
  const ChapterRow({required this.contentPadding, this.onPressed, required this.chapters, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

        return AspectRatio(
          aspectRatio: 1.75,
          child: Card(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: chapter.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      color: Theme.of(context).cardColor.withValues(alpha: 0.4),
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
                FlatButton(
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
                ),
                if (AdaptiveLayout.of(context).isDesktop)
                  DisableFocus(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: PopupMenuButton(
                        tooltip: context.localized.options,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => generateActions().popupMenuItems(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      contentPadding: contentPadding,
    );
  }
}
