import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/items/identify_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/focused_outlined_text_field.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

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

enum IdentifyScreenTab {
  search,
  result;

  String label(BuildContext context) => switch (this) {
        IdentifyScreenTab.search => context.localized.search,
        IdentifyScreenTab.result => context.localized.result,
      };
}

class _IdentifyScreenState extends ConsumerState<IdentifyScreen> {
  AutoDisposeStateNotifierProvider<IdentifyNotifier, IdentifyModel> get provider => identifyProvider(widget.item.id);

  late final TextEditingController _nameController;
  late final TextEditingController _yearController;
  final Map<String, TextEditingController> _dynamicControllers = {};

  IdentifyScreenTab selectedTab = IdentifyScreenTab.search;

  ProviderSubscription<IdentifyModel>? listener;

  @override
  void initState() {
    super.initState();

    final initialState = ref.read(provider);

    _nameController = TextEditingController(text: initialState.searchString);
    _yearController = TextEditingController(text: initialState.year?.toString() ?? "");
    for (final entry in initialState.keys.entries) {
      _dynamicControllers[entry.key] = TextEditingController(text: entry.value);
    }

    listener = ref.listenManual(provider, (IdentifyModel? previous, IdentifyModel next) {
      final yearString = next.year?.toString() ?? "";

      if (_nameController.text != next.searchString) {
        _nameController.text = next.searchString;
      }

      if (_yearController.text != yearString) {
        _yearController.text = yearString;
      }

      final newKeys = next.keys.keys.toSet();
      final oldKeys = _dynamicControllers.keys.toSet();

      for (final key in newKeys.difference(oldKeys)) {
        _dynamicControllers[key] = TextEditingController(text: next.keys[key]);
      }

      for (final key in newKeys.intersection(oldKeys)) {
        final controller = _dynamicControllers[key]!;
        final newValue = next.keys[key] ?? "";
        if (controller.text != newValue) {
          controller.text = newValue;
        }
      }

      for (final key in oldKeys.difference(newKeys)) {
        _dynamicControllers.remove(key)?.dispose();
      }
    });

    Future.microtask(() => ref.read(provider.notifier).fetchInformation());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _yearController.dispose();
    for (final controller in _dynamicControllers.values) {
      controller.dispose();
    }
    listener?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final posters = state.results;
    final processing = state.processing;

    final contentWidgets = {
      IdentifyScreenTab.search: inputFields(state),
      IdentifyScreenTab.result: resultsContent(context, state, posters, processing),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.item.detailedName(context) ?? widget.item.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              IconButton(
                onPressed: () async => await ref.read(provider.notifier).fetchInformation(),
                icon: const Icon(IconsaxPlusLinear.refresh),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SegmentedButton<IdentifyScreenTab>(
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              selectedForegroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            segments: IdentifyScreenTab.values
                .map(
                  (tab) => ButtonSegment(
                    value: tab,
                    label: Text(tab.label(context)),
                  ),
                )
                .toList(),
            selected: {selectedTab},
            showSelectedIcon: false,
            onSelectionChanged: (newSelection) {
              setState(() {
                selectedTab = newSelection.first;
              });
            },
          ),
        ),
        Flexible(
          child: AnimatedFadeSize(
            child: contentWidgets[selectedTab]!,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.localized.cancel),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: !processing
                    ? () async {
                        await ref.read(provider.notifier).remoteSearch();
                        setState(() {
                          selectedTab = IdentifyScreenTab.result;
                        });
                      }
                    : null,
                child: processing
                    ? SizedBox(
                        width: 21,
                        height: 21,
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          strokeCap: StrokeCap.round,
                        ),
                      )
                    : Text(context.localized.search),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget resultsContent(BuildContext context, IdentifyModel state, List<dynamic> posters, bool processing) {
    if (posters.isEmpty) {
      return Center(
        child: processing
            ? const CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round)
            : Text(context.localized.noResults),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(context.localized.replaceAllImages),
              const SizedBox(width: 16),
              Switch(
                value: state.replaceAllImages,
                onChanged: (value) {
                  ref.read(provider.notifier).update((state) => state.copyWith(replaceAllImages: value));
                },
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    "${result.name ?? ""}${result.productionYear != null ? " (${result.productionYear})" : ""}"),
                                Opacity(opacity: 0.65, child: Text(result.providerIds?.keys.join(', ') ?? ""))
                              ],
                            ),
                          ),
                          Tooltip(
                            message: context.localized.set,
                            child: IconButton(
                              onPressed: !processing
                                  ? () async {
                                      final response = await ref.read(provider.notifier).setIdentity(result);
                                      if (response?.isSuccessful == true && context.mounted) {
                                        FladderSnack.show(context.localized.setIdentityTo(result.name ?? ""),
                                            context: context);
                                      } else if (context.mounted) {
                                        FladderSnack.showResponse(response: response);
                                      }

                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  : null,
                              icon: const Icon(IconsaxPlusBold.tag_2),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget inputFields(IdentifyModel state) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
                onPressed: () {
                  ref.read(provider.notifier).clearFields();
                },
                child: Text(context.localized.clear)),
          ],
        ),
        const SizedBox(height: 6),
        FocusedOutlinedTextField(
          label: context.localized.name,
          controller: _nameController,
          onChanged: (value) {
            ref.read(provider.notifier).update((state) => state.copyWith(searchString: value));
          },
          onSubmitted: (value) {
            ref.read(provider.notifier).update((state) => state.copyWith(searchString: value));
          },
        ),
        FocusedOutlinedTextField(
          label: context.localized.year(1),
          controller: _yearController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
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
              _yearController.text = state.year?.toString() ?? "";
            }
          },
          onSubmitted: (value) {
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
        ),
        ...state.keys.entries.map(
          (searchKey) {
            final controller = _dynamicControllers[searchKey.key];
            return FocusedOutlinedTextField(
              label: searchKey.key,
              controller: controller,
              onChanged: (value) {
                ref.read(provider.notifier).updateKey(MapEntry(searchKey.key, value));
              },
              onSubmitted: (value) => ref.read(provider.notifier).updateKey(MapEntry(searchKey.key, value)),
            );
          },
        ),
      ].addInBetween(const SizedBox(height: 12)),
    );
  }
}
