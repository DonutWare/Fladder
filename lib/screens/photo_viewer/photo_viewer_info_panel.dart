import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/settings/photo_view_settings_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/elevated_icon.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class PhotoViewerInfoPanel extends ConsumerWidget {
  final PhotoModel photo;
  final bool asSheet;
  final VoidCallback onClose;
  final Function(ItemBaseModel item) onRemove;
  const PhotoViewerInfoPanel({
    required this.photo,
    required this.asSheet,
    required this.onClose,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(photoViewSettingsProvider);
    final notifier = ref.read(photoViewSettingsProvider.notifier);
    final dateTaken = photo.dateTaken;
    const radius = Radius.circular(32);
    return Material(
      color: theme.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: asSheet ? const BorderRadius.vertical(top: radius) : const BorderRadius.all(radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: asSheet,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (asSheet)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 32,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(photo.name, style: theme.textTheme.titleMedium, overflow: TextOverflow.ellipsis),
                        if (dateTaken != null)
                          Text(
                            DateFormat.yMMMEd(Localizations.localeOf(context).toString()).add_jm().format(dateTaken),
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                      ],
                    ),
                  ),
                  if (!asSheet)
                    IconButton(
                      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                      icon: const Icon(IconsaxPlusLinear.close_circle),
                      onPressed: onClose,
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedIconButtonLabel(
                          label: context.localized.loop,
                          onPressed: () => notifier.update((state) => state.copyWith(repeat: !state.repeat)),
                          icon: settings.repeat ? IconsaxPlusLinear.repeat : IconsaxPlusLinear.repeate_one,
                        ),
                        ElevatedIconButtonLabel(
                          label: context.localized.audio(1),
                          onPressed: () => notifier.update((state) => state.copyWith(mute: !state.mute)),
                          icon: settings.mute ? IconsaxPlusLinear.volume_slash : IconsaxPlusLinear.volume_high,
                        ),
                        ElevatedIconButtonLabel(
                          label: context.localized.autoPlay,
                          onPressed: () => notifier.update((state) => state.copyWith(autoPlay: !state.autoPlay)),
                          icon: settings.autoPlay ? IconsaxPlusLinear.play_remove : IconsaxPlusLinear.play,
                        ),
                        ElevatedIconButtonLabel(
                          label: context.localized.backgroundBlur,
                          onPressed: () => notifier.update((state) => state.copyWith(theaterMode: !state.theaterMode)),
                          icon: settings.theaterMode ? IconsaxPlusLinear.filter_remove : IconsaxPlusLinear.filter,
                        ),
                      ].addInBetween(const SizedBox(width: 16)),
                    ),
                  ),
                  const Divider(),
                  ...photo
                      .generateActions(
                        context,
                        ref,
                        exclude: {
                          ItemActions.details,
                          ItemActions.markPlayed,
                          ItemActions.markUnplayed,
                        },
                        onDeleteSuccesFully: onRemove,
                      )
                      .listTileItems(context, useIcons: true, shouldPop: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
