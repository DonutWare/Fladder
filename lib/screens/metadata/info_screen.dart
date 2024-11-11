import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/information_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/items/information_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';

Future<void> showInfoScreen(BuildContext context, ItemBaseModel item) async {
  return showDialog(
    context: context,
    builder: (context) => ItemInfoScreen(
      item: item,
    ),
  );
}

class ItemInfoScreen extends ConsumerStatefulWidget {
  final ItemBaseModel item;
  const ItemInfoScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ItemInfoScreenState();
}

class ItemInfoScreenState extends ConsumerState<ItemInfoScreen> {
  AutoDisposeStateNotifierProvider<InformationNotifier, InformationProviderModel> get provider =>
      informationProvider(widget.item.id);

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      focusNode.requestFocus();
      return ref.read(provider.notifier).getItemInformation(widget.item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final info = ref.watch(provider);
    final videoStreams = (info.model?.videoStreams.map((map) => streamModel("Video", map)) ?? []).toList();
    final audioStreams = (info.model?.audioStreams.map((map) => streamModel("Audio", map)) ?? []).toList();
    final subStreams = (info.model?.subStreams.map((map) => streamModel("Subtitle", map)) ?? []).toList();
    return Dialog(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Focus(
          autofocus: true,
          focusNode: focusNode,
          onKeyEvent: (node, event) => KeyEventResult.ignored,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.item.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const Opacity(opacity: 0.3, child: Divider()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),
                          const SizedBox(width: 6),
                          IconButton(
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(text: info.model.toString()));
                                if (context.mounted) {
                                  fladderSnackbar(context, title: "Copied to clipboard");
                                }
                              },
                              icon: const Icon(Icons.copy_all_rounded)),
                          const SizedBox(width: 6),
                          IconButton(
                            onPressed: () => ref.read(provider.notifier).getItemInformation(widget.item),
                            icon: const Icon(IconsaxOutline.refresh),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          if (info.model != null) ...{
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: double.infinity, child: streamModel("Info", info.model!.baseInformation)),
                                if ([...videoStreams, ...audioStreams, ...subStreams].isNotEmpty) ...{
                                  const Divider(),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    runSpacing: 16,
                                    spacing: 16,
                                    children: [
                                      ...videoStreams,
                                      ...audioStreams,
                                      ...subStreams,
                                    ],
                                  ),
                                },
                              ],
                            ),
                          },
                          AnimatedOpacity(
                            opacity: info.loading ? 1 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: const Center(child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.close))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tileRow(String title, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: ClickableText(
            text: title,
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: value));
              fladderSnackbar(context, title: "Copied to clipboard");
            },
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          ":  ",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Flexible(
          flex: 3,
          child: SelectableText(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Card streamModel(String title, Map<String, dynamic> map) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ClickableText(
                    text: title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: InformationModel.mapToString(map)));
                      fladderSnackbar(context, title: "Copied to clipboard");
                    },
                    icon: const Icon(Icons.copy_all_rounded))
              ],
            ),
            const SizedBox(height: 6),
            ...map.entries
                .where((element) => element.value != null)
                .map((mapEntry) => tileRow(mapEntry.key, mapEntry.value.toString()))
          ],
        ),
      ),
    );
  }
}
