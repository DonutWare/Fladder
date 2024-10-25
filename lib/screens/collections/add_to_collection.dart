import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/collections_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
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
    final collectonOptions = ref.watch(provider);
    return ActionContent(
      title: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
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
                  icon: const Icon(IconsaxOutline.refresh),
                )
              ],
            ),
            if (widget.items.length == 1) ItemBottomSheetPreview(item: widget.items.first),
          ],
        ),
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
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                ...collectonOptions.collections.entries.map(
                  (e) {
                    if (e.value != null) {
                      return CheckboxListTile.adaptive(
                        title: Text(e.key.name),
                        value: e.value,
                        onChanged: (value) async {
                          final response = await ref
                              .read(provider.notifier)
                              .toggleCollection(boxSet: e.key, value: value == true, item: widget.items.first);
                          if (context.mounted) {
                            fladderSnackbar(context,
                                title: response.isSuccessful
                                    ? value == true
                                        ? context.localized.addedToCollection(e.key.name)
                                        : context.localized.removedFromCollection(e.key.name)
                                    : '${context.localized.somethingWentWrong} - (${response.statusCode}) - ${response.base.reasonPhrase}');
                          }
                        },
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.key.name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final response =
                                        await ref.read(provider.notifier).addToCollection(boxSet: e.key, add: true);
                                    if (context.mounted) {
                                      fladderSnackbar(context,
                                          title: response.isSuccessful
                                              ? context.localized.addedToCollection(e.key.name)
                                              : '${context.localized.somethingWentWrong} - (${response.statusCode}) - ${response.base.reasonPhrase}');
                                    }
                                  },
                                  child: Icon(Icons.add_rounded, color: Theme.of(context).colorScheme.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
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
}
