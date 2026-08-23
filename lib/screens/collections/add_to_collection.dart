import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/collections_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/alert_content.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

Future<void> addItemToCollection(BuildContext context, List<ItemBaseModel> item) {
  return showDialogAdaptive(
    context: context,
    builder: (context) => AddToCollection(
      items: item,
    ),
  );
}

class AddToCollection extends ConsumerStatefulWidget {
  final List<ItemBaseModel> items;
  const AddToCollection({required this.items, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddToCollectionState();
}

class _AddToCollectionState extends ConsumerState<AddToCollection> {
  final TextEditingController controller = TextEditingController();
  late final provider = collectionsProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(provider.notifier).setItems(widget.items));
  }

  @override
  Widget build(BuildContext context) {
    final collectionProvider = ref.watch(provider);
    return ActionContent(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.items.length == 1)
                Text(
                  context.localized.addToCollection,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              else
                Text(
                  context.localized.addItemsToCollection(widget.items.length),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              IconButton(
                onPressed: () => ref.read(provider.notifier).setItems(widget.items),
                icon: const Icon(IconsaxPlusLinear.refresh),
              )
            ],
          ),
          if (widget.items.length == 1) ItemBottomSheetPreview(item: widget.items.first),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: OutlinedTextField(
                  label: context.localized.addToNewCollection,
                  controller: controller,
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const SizedBox(width: 32),
              IconButton(
                  onPressed: controller.text.isNotEmpty
                      ? () async {
                          await ref.read(provider.notifier).addToNewCollection(
                                name: controller.text,
                              );
                          setState(() => controller.text = '');
                        }
                      : null,
                  icon: const Icon(Icons.add_rounded)),
            ],
          ),
          if (collectionProvider.isLoading && collectionProvider.collections.isEmpty) const CircularProgressIndicator(),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                ...collectionProvider.collections.entries.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: FocusButton(
                        onTap: () => toggleCollection(e.key, e.value == true),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: e.value == true
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.key.name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                SquareProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                  value: e.value == null && collectionProvider.isLoading ? null : 0,
                                  child: Checkbox(
                                    value: e.value,
                                    tristate: true,
                                    onChanged: (value) async => toggleCollection(e.key, value ?? false),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.close),
        )
      ],
    );
  }

  Future<void> toggleCollection(BoxSetModel boxSet, bool value) async {
    if (value == true) {
      final response = await ref.read(provider.notifier).addToCollection(boxSet: boxSet, add: false);
      if (context.mounted) {
        FladderSnack.show(
            response.isSuccessful
                ? context.localized.removedFromCollection(boxSet.name)
                : '${context.localized.somethingWentWrong} - (${response.statusCode}) - ${response.base.reasonPhrase}',
            context: context);
      }
    } else {
      final response = await ref.read(provider.notifier).addToCollection(boxSet: boxSet, add: true);
      if (context.mounted) {
        FladderSnack.show(
            response.isSuccessful
                ? context.localized.addedToCollection(boxSet.name)
                : '${context.localized.somethingWentWrong} - (${response.statusCode}) - ${response.base.reasonPhrase}',
            context: context);
      }
    }
  }
}
