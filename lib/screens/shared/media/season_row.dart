import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/disable_keypad_focus.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/status_card.dart';

class SeasonsRow extends ConsumerWidget {
  final EdgeInsets contentPadding;
  final ValueChanged<SeasonModel>? onSeasonPressed;
  final List<SeasonModel>? seasons;

  const SeasonsRow({
    super.key,
    this.onSeasonPressed,
    required this.seasons,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HorizontalList(
      label: context.localized.season(seasons?.length ?? 1),
      items: seasons ?? [],
      height: AdaptiveLayout.poster(context).size,
      contentPadding: contentPadding,
      itemBuilder: (
        context,
        index,
      ) {
        final season = (seasons ?? [])[index];
        return SeasonPoster(
          season: season,
          onSeasonPressed: onSeasonPressed,
        );
      },
    );
  }
}

class SeasonPoster extends ConsumerWidget {
  final SeasonModel season;
  final ValueChanged<SeasonModel>? onSeasonPressed;

  const SeasonPoster({required this.season, this.onSeasonPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Padding placeHolder(String title) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          child: Card(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.65),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FladderImage(
                      image: season.getPosters?.primary ??
                          season.parentImages?.backDrop?.firstOrNull ??
                          season.parentImages?.primary,
                      placeHolder: placeHolder(season.name),
                    ),
                  ),
                  if (season.images?.primary == null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: placeHolder(season.name),
                    ),
                  if (season.userData.unPlayedItemCount != 0)
                    Align(
                      alignment: Alignment.topRight,
                      child: StatusCard(
                        color: Theme.of(context).colorScheme.primary,
                        useFittedBox: true,
                        child: Center(
                          child: Text(
                            season.userData.unPlayedItemCount.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.topRight,
                      child: StatusCard(
                        color: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.check_rounded,
                        ),
                      ),
                    ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return FlatButton(
                        onSecondaryTapDown: (details) {
                          Offset localPosition = details.globalPosition;
                          RelativeRect position = RelativeRect.fromLTRB(
                              localPosition.dx - 260, localPosition.dy, localPosition.dx, localPosition.dy);
                          showMenu(
                              context: context,
                              position: position,
                              items: season.generateActions(context, ref).popupMenuItems(useIcons: true));
                        },
                        onTap: () => onSeasonPressed?.call(season),
                        onLongPress: AdaptiveLayout.of(context).inputDevice != InputDevice.touch
                            ? () {
                                showBottomSheetPill(
                                  context: context,
                                  content: (context, scrollController) => ListView(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    children:
                                        season.generateActions(context, ref).listTileItems(context, useIcons: true),
                                  ),
                                );
                              }
                            : null,
                      );
                    },
                  ),
                  if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer)
                    DisableFocus(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: PopupMenuButton(
                          tooltip: context.localized.options,
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          itemBuilder: (context) => season.generateActions(context, ref).popupMenuItems(useIcons: true),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          ClickableText(
            text: season.localizedName(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
