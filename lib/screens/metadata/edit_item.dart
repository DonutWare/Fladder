import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/edit_item_provider.dart';
import 'package:fladder/screens/metadata/edit_screens/edit_fields.dart';
import 'package:fladder/screens/metadata/edit_screens/edit_image_content.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';

enum MetaEditOptions {
  general,
  primary,
  logo,
  backdrops,
  advanced;

  const MetaEditOptions();

  String label(BuildContext context) => switch (this) {
        MetaEditOptions.general => context.localized.general,
        MetaEditOptions.primary => context.localized.primary,
        MetaEditOptions.logo => context.localized.logo(1),
        MetaEditOptions.backdrops => context.localized.backdrop(1),
        MetaEditOptions.advanced => context.localized.advanced
      };
}

Future<ItemBaseModel?> showEditItemPopup(
  BuildContext context,
  String itemId, {
  Set<MetaEditOptions> options = const {
    MetaEditOptions.general,
    MetaEditOptions.primary,
    MetaEditOptions.logo,
    MetaEditOptions.backdrops,
    MetaEditOptions.advanced,
  },
}) async {
  ItemBaseModel? updatedItem;
  var shouldRefresh = false;
  await showDialogAdaptive(
    context: context,
    builder: (context) {
      return EditDialogSwitcher(
        id: itemId,
        itemUpdated: (newItem) => updatedItem = newItem,
        refreshOnClose: (refresh) => shouldRefresh = refresh,
        options: options,
      );
    },
  );
  if (shouldRefresh == true) {
    context.refreshData();
  }
  return updatedItem;
}

class EditDialogSwitcher extends ConsumerStatefulWidget {
  final String id;
  final Function(ItemBaseModel? newItem) itemUpdated;
  final Function(bool refresh) refreshOnClose;
  final Set<MetaEditOptions> options;

  const EditDialogSwitcher({
    required this.id,
    required this.itemUpdated,
    required this.refreshOnClose,
    required this.options,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditDialogSwitcherState();
}

class _EditDialogSwitcherState extends ConsumerState<EditDialogSwitcher> with TickerProviderStateMixin {
  Future<void> refreshEditor() async {
    return ref.read(editItemProvider.notifier).fetchInformation(widget.id);
  }

  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => refreshEditor());
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = ref.watch(editItemProvider.select((value) => value.item));
    final saving = ref.watch(editItemProvider.select((value) => value.saving));
    final state = ref.watch(editItemProvider).editedJson;
    final generalFields = ref.watch(editItemProvider.notifier).getFields ?? {};
    final advancedFields = ref.watch(editItemProvider.notifier).advancedFields ?? {};

    Map<MetaEditOptions, Widget> widgets = Map.fromEntries(
      {
        MetaEditOptions.general: EditFields(fields: generalFields, json: state),
        MetaEditOptions.primary: const EditImageContent(type: ImageType.primary),
        MetaEditOptions.logo: const EditImageContent(type: ImageType.logo),
        MetaEditOptions.backdrops: const EditImageContent(type: ImageType.backdrop),
        MetaEditOptions.advanced: EditFields(fields: advancedFields, json: state),
      }.entries.where((entry) => widget.options.contains(entry.key)),
    );

    return Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  currentItem?.detailedName(context) ?? currentItem?.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(onPressed: () => refreshEditor(), icon: const Icon(IconsaxPlusLinear.refresh))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SegmentedButton(
            segments: widgets.keys
                .map(
                  (value) => ButtonSegment(
                    value: value,
                    label: Text(value.label(context)),
                  ),
                )
                .toList(),
            selected: {widgets.keys.elementAt(selectedTabIndex)},
            showSelectedIcon: false,
            onSelectionChanged: (newSelection) {
              setState(() {
                selectedTabIndex = widgets.keys.toList().indexOf(newSelection.first);
              });
            },
          ),
        ),
        Flexible(
          child: AnimatedFadeSize(
            child: widgets.values.elementAt(selectedTabIndex),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.close)),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: saving
                    ? null
                    : () async {
                        final response = await ref.read(editItemProvider.notifier).saveInformation(widget.options);
                        if (response != null && context.mounted) {
                          if (response.isSuccessful) {
                            widget.itemUpdated(response.body);
                            fladderSnackbar(context,
                                title: context.localized
                                    .metaDataSavedFor(currentItem?.detailedName(context) ?? currentItem?.name ?? ""));
                          } else {
                            fladderSnackbarResponse(context, response);
                          }
                        }
                        widget.refreshOnClose(true);
                        Navigator.of(context).pop();
                      },
                child: saving
                    ? SizedBox(
                        width: 21,
                        height: 21,
                        child: CircularProgressIndicator.adaptive(
                            backgroundColor: Theme.of(context).colorScheme.onPrimary, strokeCap: StrokeCap.round),
                      )
                    : Text(context.localized.save),
              ),
            ],
          ),
        )
      ],
    );
  }
}
