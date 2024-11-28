import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/items/identify_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/focused_outlined_text_field.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/alert_content.dart';

Future<void> showIdentifyScreen(BuildContext context, ItemBaseModel item) async {
  return showDialogAdaptive(
    context: context,
    builder: (context) => IdentifyScreen(
      item: item,
    ),
  );
}

class IdentifyScreen extends ConsumerStatefulWidget {
  final ItemBaseModel item;
  const IdentifyScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IdentifyScreenState();
}

class _IdentifyScreenState extends ConsumerState<IdentifyScreen> with TickerProviderStateMixin {
  AutoDisposeStateNotifierProvider<IdentifyNotifier, IdentifyModel> get provider => identifyProvider(widget.item.id);
  late final TabController tabController = TabController(length: 2, vsync: this);

  TextEditingController? currentController;
  String? currentKey;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(provider.notifier).fetchInformation());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final posters = state.results;
    final processing = state.processing;
    return ActionContent(
      showDividers: false,
      title: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  widget.item.detailedName(context) ?? widget.item.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async => await ref.read(provider.notifier).fetchInformation(),
                    icon: const Icon(IconsaxOutline.refresh)),
              ],
            ),
            TabBar(
              isScrollable: true,
              controller: tabController,
              onTap: (value) {
                setState(() {
                  currentTab = value;
                });
              },
              tabs: [
                Tab(
                  text: context.localized.search,
                ),
                Tab(
                  text: context.localized.result,
                )
              ],
            )
          ],
        ),
      ),
      child: TabBarView(
        controller: tabController,
        children: [
          inputFields(state),
          if (posters.isEmpty)
            Center(
              child: processing
                  ? const CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round)
                  : Text(context.localized.noResults),
            )
          else
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(context.localized.replaceAllImages),
                    const SizedBox(width: 16),
                    Switch.adaptive(
                      value: state.replaceAllImages,
                      onChanged: (value) {
                        ref.read(provider.notifier).update((state) => state.copyWith(replaceAllImages: value));
                      },
                    ),
                  ],
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: posters
                        .map((result) => ListTile(
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 75,
                                    child: Card(
                                      child: CachedNetworkImage(
                                        imageUrl: result.imageUrl ?? "",
                                        errorWidget: (context, url, error) => SizedBox(
                                          height: 75,
                                          child: Card(
                                            child: Center(
                                              child: Text(result.name?.getInitials() ?? ""),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${result.name ?? ""}${result.productionYear != null ? "(${result.productionYear})" : ""}"),
                                        Opacity(opacity: 0.65, child: Text(result.providerIds?.keys.join(',') ?? ""))
                                      ],
                                    ),
                                  ),
                                  Tooltip(
                                    message: context.localized.openWebLink,
                                    child: IconButton(
                                        onPressed: () {
                                          final providerKeyEntry = result.providerIds?.entries.first;
                                          final providerKey = providerKeyEntry?.key;
                                          final providerValue = providerKeyEntry?.value;

                                          final externalId = state.externalIds
                                              .firstWhereOrNull((element) => element.key == providerKey)
                                              // ignore: deprecated_member_use_from_same_package
                                              ?.urlFormatString;

                                          final url = externalId?.replaceAll("{0}", providerValue?.toString() ?? "");

                                          launchUrl(context, url ?? "");
                                        },
                                        icon: const Icon(Icons.launch_rounded)),
                                  ),
                                  Tooltip(
                                    message: "Select result",
                                    child: IconButton(
                                      onPressed: !processing
                                          ? () async {
                                              final response = await ref.read(provider.notifier).setIdentity(result);
                                              if (response?.isSuccessful == true) {
                                                fladderSnackbar(context,
                                                    title: context.localized.setIdentityTo(result.name ?? ""));
                                              } else {
                                                fladderSnackbarResponse(context, response,
                                                    altTitle: context.localized.somethingWentWrong);
                                              }

                                              Navigator.of(context).pop();
                                            }
                                          : null,
                                      icon: const Icon(Icons.save_alt_rounded),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            )
        ],
      ),
      actions: [
        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.cancel)),
        const SizedBox(width: 16),
        FilledButton(
          onPressed: !processing
              ? () async {
                  await ref.read(provider.notifier).remoteSearch();
                  tabController.animateTo(1);
                }
              : null,
          child: processing
              ? SizedBox(
                  width: 21,
                  height: 21,
                  child: CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary, strokeCap: StrokeCap.round),
                )
              : Text(context.localized.search),
        ),
      ],
    );
  }

  ListView inputFields(IdentifyModel state) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
                onPressed: () {
                  currentController = null;
                  currentKey = "";
                  ref.read(provider.notifier).clearFields();
                },
                child: Text(context.localized.clear)),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Builder(builder: (context) {
            final controller =
                currentKey == "Name" ? currentController : TextEditingController(text: state.searchString);
            return FocusedOutlinedTextField(
              label: context.localized.userName,
              controller: controller,
              onChanged: (value) {
                currentController = controller;
                currentKey = "Name";
                return ref.read(provider.notifier).update((state) => state.copyWith(searchString: value));
              },
              onSubmitted: (value) {
                return ref.read(provider.notifier).update((state) => state.copyWith(searchString: value));
              },
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Builder(builder: (context) {
            final controller =
                currentKey == "Year" ? currentController : TextEditingController(text: state.year?.toString() ?? "");
            return FocusedOutlinedTextField(
              label: context.localized.year(1),
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                currentController = controller;
                currentKey = "Year";
                if (value.isEmpty) {
                  ref.read(provider.notifier).update((state) => state.copyWith(
                        year: () => null,
                      ));
                  return;
                }
                final newYear = int.tryParse(value);
                if (newYear != null) {
                  ref.read(provider.notifier).update((state) => state.copyWith(
                        year: () => newYear,
                      ));
                } else {
                  controller?.text = state.year?.toString() ?? "";
                }
              },
              onSubmitted: (value) {
                currentController = null;
                currentKey = null;
                if (value.isEmpty) {
                  ref.read(provider.notifier).update((state) => state.copyWith(
                        year: () => null,
                      ));
                }
                final newYear = int.tryParse(value);
                if (newYear != null) {
                  ref.read(provider.notifier).update((state) => state.copyWith(
                        year: () => newYear,
                      ));
                }
              },
            );
          }),
        ),
        ...state.keys.entries.map(
          (searchKey) => Builder(builder: (context) {
            final controller =
                currentKey == searchKey.key ? currentController : TextEditingController(text: searchKey.value);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FocusedOutlinedTextField(
                label: searchKey.key,
                controller: controller,
                onChanged: (value) {
                  currentController = controller;
                  currentKey = searchKey.key;
                  ref.read(provider.notifier).updateKey(MapEntry(searchKey.key, value));
                },
                onSubmitted: (value) => ref.read(provider.notifier).updateKey(MapEntry(searchKey.key, value)),
              ),
            );
          }),
        ),
      ],
    );
  }
}
