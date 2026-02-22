import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/special_feature_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/screens/syncing/sync_button.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/status_card.dart';

class SpecialFeaturesRow extends ConsumerWidget {
  final List<SpecialFeatureModel> specialFeatures;
  final String? label;
  final EdgeInsets contentPadding;
  final Function(SpecialFeatureModel specialFeatureModel, BuildContext context, WidgetRef ref) onSpecialFeatureTap;
  const SpecialFeaturesRow({
    this.label,
    required this.contentPadding,
    required this.specialFeatures,
    this.onSpecialFeatureTap = defaultOnSpecialFeatureTap,
    super.key,
  });

  static void defaultOnSpecialFeatureTap(SpecialFeatureModel specialFeature, BuildContext context, WidgetRef ref) {
    specialFeature.play(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HorizontalList(
      label: label,
      titleActions: [],
      height: AdaptiveLayout.poster(context).gridRatio,
      contentPadding: contentPadding,
      startIndex: null,
      items: specialFeatures,
      itemBuilder: (context, index) {
        final specialFeature = specialFeatures[index];
        final tag = UniqueKey();
        return SpecialFeaturePoster(
          specialFeature: specialFeature,
          heroTag: tag,
          blur: false,
          onTap: () => {onSpecialFeatureTap(specialFeature, context, ref)},
          onLongPress: () async {
            await showBottomSheetPill(
              context: context,
              item: specialFeature,
              content: (context, scrollController) {
                return ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: specialFeature
                      .generateActions(context, ref, exclude: {ItemActions.details})
                      .listTileItems(context, useIcons: true)
                      .toList(),
                );
              },
            );
            context.refreshData();
          },
          actions: specialFeature.generateActions(context, ref, exclude: {ItemActions.details}),
        );
      },
    );
  }
}

class SpecialFeaturePoster extends ConsumerWidget {
  final SpecialFeatureModel specialFeature;
  final bool showLabel;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool blur;
  final List<ItemAction> actions;
  final Function(bool value)? onFocusChanged;
  final Object? heroTag;

  const SpecialFeaturePoster({
    super.key,
    required this.specialFeature,
    this.showLabel = true,
    this.onTap,
    this.onLongPress,
    this.blur = false,
    required this.actions,
    this.onFocusChanged,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget placeHolder = Container(
      height: double.infinity,
      child: const Icon(Icons.local_movies_outlined),
    );
    final syncedDetails = ref.watch(syncedItemProvider(specialFeature));
    return AspectRatio(
      aspectRatio: 1.76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: FocusButton(
              onTap: onTap,
              onLongPress: onLongPress,
              onFocusChanged: onFocusChanged,
              onSecondaryTapDown: (details) async {
                Offset localPosition = details.globalPosition;
                RelativeRect position =
                    RelativeRect.fromLTRB(localPosition.dx, localPosition.dy, localPosition.dx, localPosition.dy);
                await showMenu(context: context, position: position, items: actions.popupMenuItems(useIcons: true));
              },
              child: Hero(
                tag: heroTag ?? UniqueKey(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: FladderTheme.smallShape.borderRadius,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  foregroundDecoration: FladderTheme.defaultPosterDecoration,
                  child: FladderImage(
                    image: specialFeature.images?.primary,
                    placeHolder: placeHolder,
                    blurOnly: false,
                  ),
                ),
              ),
              overlays: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      switch (syncedDetails) {
                        AsyncValue<SyncedItem?>(:final value) => Builder(
                            builder: (context) {
                              if (value == null) {
                                return const SizedBox.shrink();
                              }
                              return StatusCard(
                                child: SyncButton(item: specialFeature, syncedItem: value),
                              );
                            },
                          ),
                      },
                      if (specialFeature.userData.isFavourite)
                        const StatusCard(
                          color: Colors.red,
                          child: Icon(
                            Icons.favorite_rounded,
                          ),
                        ),
                      if (specialFeature.userData.played)
                        StatusCard(
                          color: Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.check_rounded,
                          ),
                        ),
                    ],
                  ),
                ),
                if ((specialFeature.userData.progress) > 0)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      backgroundColor: Colors.black.withValues(alpha: 0.75),
                      value: specialFeature.userData.progress / 100,
                    ),
                  ),
              ],
              focusedOverlays: [
                if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer && actions.isNotEmpty)
                  ExcludeFocus(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: PopupMenuButton(
                        tooltip: context.localized.options,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => actions.popupMenuItems(useIcons: true),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (showLabel) ...{
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  child: ClickableText(
                    text: specialFeature.label(context.localized),
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
