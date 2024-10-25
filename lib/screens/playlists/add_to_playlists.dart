import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/playlist_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/alert_content.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

Future<void> addItemToPlaylist(BuildContext context, List<ItemBaseModel> item) {
  return showDialogAdaptive(context: context, builder: (context) => AddToPlaylist(items: item));
}

class AddToPlaylist extends ConsumerStatefulWidget {
  final List<ItemBaseModel> items;
  const AddToPlaylist({required this.items, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends ConsumerState<AddToPlaylist> {
  final TextEditingController controller = TextEditingController();
  late final provider = playlistProvider;

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
                    context.localized.addToPlaylist,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                else
                  Text(
                    context.localized.addItemsToPlaylist(widget.items.length),
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
                  label: context.localized.addToNewPlaylist,
                  controller: controller,
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const SizedBox(width: 32),
              IconButton(
                  onPressed: controller.text.isNotEmpty
                      ? () async {
                          final response = await ref.read(provider.notifier).addToNewPlaylist(
                                name: controller.text,
                              );
                          if (context.mounted) {
                            fladderSnackbar(context,
                                title: response.isSuccessful
                                    ? context.localized.addedToPlaylist(controller.text)
                                    : '${context.localized.somethingWentWrong} - (${response.statusCode}) - ${response.base.reasonPhrase}');
                          }
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
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: Text(
                                e.key.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                              IconButton.filledTonal(
                                style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                onPressed: () async {
                                  final response = await ref.read(provider.notifier).addToPlaylist(playlist: e.key);
                                  if (context.mounted) {
                                    fladderSnackbar(context,
                                        title: response.isSuccessful
                                            ? context.localized.addedToPlaylist(controller.text)
                                            : '${context.localized.somethingWentWrong} - (${response.statusCode}) - ${response.base.reasonPhrase}');
                                  }
                                },
                                icon: Icon(Icons.add_rounded, color: Theme.of(context).colorScheme.primary),
                              ),
                            ],
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
}
