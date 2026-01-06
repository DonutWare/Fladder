import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/sortable_item_list.dart';

class FetchersSection extends ConsumerWidget {
  final LibraryOptions? currentOptions;

  const FetchersSection({
    required this.currentOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(controlLibrariesProvider.notifier);

    if (currentOptions == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Metadata Fetchers
        ...?currentOptions?.typeOptions?.where((e) => e.metadataFetcherOrder?.isNotEmpty == true).mapIndexed(
          (index, metaData) {
            final lastIndex =
                (currentOptions?.typeOptions?.where((e) => e.metadataFetcherOrder?.isNotEmpty == true).length ?? 1) - 1;
            return SettingsListChild(
              isFirst: index == 0,
              isLast: index == lastIndex,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsLabelDivider(label: context.localized.metadataFetchers(metaData.type ?? "")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SortableItemList<String>(
                      items: metaData.metadataFetcherOrder ?? [],
                      included: metaData.metadataFetchers,
                      itemBuilder: (item) => Text(item),
                      onIncludeChange: (items) {
                        provider.updateSelectedLibraryOptions(
                          currentOptions?.copyWith(
                            typeOptions: currentOptions?.typeOptions?.map(
                              (e) {
                                if (e.type != metaData.type) return e;
                                return e.copyWith(
                                  metadataFetchers: items,
                                );
                              },
                            ).toList(),
                          ),
                        );
                      },
                      onReorder: (items) {
                        provider.updateSelectedLibraryOptions(
                          currentOptions?.copyWith(
                            typeOptions: currentOptions?.typeOptions?.map(
                              (e) {
                                if (e.type != metaData.type) return e;
                                return e.copyWith(
                                  metadataFetcherOrder: items,
                                );
                              },
                            ).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      context.localized.enableAndRankMetadataFetchers,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(175),
                          ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        // Image Fetchers
        ...?currentOptions?.typeOptions?.where((e) => e.imageFetcherOrder?.isNotEmpty == true).mapIndexed(
          (index, imageFetcher) {
            return SettingsListChild(
              isFirst: index == 0,
              isLast: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsLabelDivider(label: context.localized.imageFetchers(imageFetcher.type ?? "")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SortableItemList<String>(
                      items: imageFetcher.imageFetcherOrder ?? [],
                      included: imageFetcher.imageFetchers,
                      itemBuilder: (item) => Text(item),
                      onIncludeChange: (items) {
                        provider.updateSelectedLibraryOptions(
                          currentOptions?.copyWith(
                            typeOptions: currentOptions?.typeOptions?.map(
                              (e) {
                                if (e.type != imageFetcher.type) return e;
                                return e.copyWith(
                                  imageFetchers: items,
                                );
                              },
                            ).toList(),
                          ),
                        );
                      },
                      onReorder: (items) {
                        provider.updateSelectedLibraryOptions(
                          currentOptions?.copyWith(
                            typeOptions: currentOptions?.typeOptions?.map(
                              (e) {
                                if (e.type != imageFetcher.type) return e;
                                return e.copyWith(
                                  imageFetcherOrder: items,
                                );
                              },
                            ).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      context.localized.enableAndRankImagesFetchers,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(175),
                          ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        if (currentOptions?.typeOptions?.where((e) => e.imageFetcherOrder?.isNotEmpty == true).isNotEmpty == true)
          SettingsListChild(
            isFirst: false,
            isLast: true,
            child: SettingsListTileCheckbox(
              label: Text(context.localized.saveArtWorkNextToMedia),
              subLabel: Text(context.localized.saveArtWorkNextToMediaDesc),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(saveLocalMetadata: value),
                );
              },
              value: currentOptions?.saveLocalMetadata ?? false,
            ),
          ),
      ],
    );
  }
}
