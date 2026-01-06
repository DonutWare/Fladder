import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/sortable_item_list.dart';

class SegmentProvidersSection extends ConsumerWidget {
  final LibraryOptions? currentOptions;
  final LibraryOptionsResultDto? availableOptions;

  const SegmentProvidersSection({
    required this.currentOptions,
    required this.availableOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(controlLibrariesProvider.notifier);

    if (currentOptions == null) {
      return const SizedBox.shrink();
    }

    final availableMediaProviders = <String>{
      ...currentOptions?.mediaSegmentProviderOrder ?? [],
      ...(availableOptions?.mediaSegmentProviders ?? []).map((e) => e.name).nonNulls,
    }.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsListChild(
          isFirst: true,
          isLast: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsLabelDivider(label: context.localized.mediaSegmentProviders),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: SortableItemList<String>(
                  items: availableMediaProviders,
                  included: availableMediaProviders.toList()
                    ..removeWhere((element) => (currentOptions?.disabledMediaSegmentProviders ?? []).contains(element)),
                  itemBuilder: (item) => Text(item),
                  onIncludeChange: (items) {
                    provider.updateSelectedLibraryOptions(
                      currentOptions?.copyWith(
                        disabledMediaSegmentProviders:
                            availableMediaProviders.where((element) => !items.contains(element)).toList(),
                      ),
                    );
                  },
                  onReorder: (items) {
                    provider.updateSelectedLibraryOptions(
                      currentOptions?.copyWith(
                        mediaSegmentProviderOrder: items,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  context.localized.enableAndRankMediaSegmentProviders,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(175),
                      ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
