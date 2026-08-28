import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/home_preferences_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/sortable_item_list.dart';

class LibraryOrderEditor extends ConsumerWidget {
  const LibraryOrderEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(homePreferencesProvider);
    final views = ref.watch(viewsProvider).views;
    final orderedIds = preferences.orderedLibraryIds;
    final includedIds = orderedIds.where((id) => !preferences.latestItemsExcludes.contains(id)).toList();

    final hasChanges = ref.watch(homePreferencesProvider.notifier).hasChanges;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: FladderTheme.largeShape.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...settingsListGroup(
            context,
            SettingsLabelDivider(label: context.localized.libraryOrderTitle),
            [
              SettingsListTile(
                label: Text(
                  context.localized.libraryOrderDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SortableItemList<String>(
                items: orderedIds,
                included: includedIds,
                itemBuilder: (id) {
                  final view = views.firstWhereOrNull((v) => v.id == id);
                  return Text(view?.name ?? id);
                },
                onReorder: (reordered) {
                  ref.read(homePreferencesProvider.notifier).setOrderedLibraryIds(reordered);
                },
                onIncludeChange: (included) {
                  final excluded = orderedIds.where((id) => !included.contains(id)).toList();
                  ref.read(homePreferencesProvider.notifier).setLatestItemsExcludes(excluded);
                },
              ),
              SettingsListTileCheckbox(
                label: Text(context.localized.hidePlayedInLatestTitle),
                subLabel: Text(context.localized.hidePlayedInLatestDescription),
                value: preferences.hidePlayedInLatest,
                onChanged: (value) {
                  ref.read(homePreferencesProvider.notifier).setHidePlayedInLatest(value ?? false);
                },
              ),
              SettingsLabelDivider(label: context.localized.groupedFoldersTitle),
              SettingsListTile(
                label: Text(
                  context.localized.groupedFoldersDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ...preferences.availableFolders.map((folder) {
                final isGrouped = preferences.groupedFolders.contains(folder.id);
                return SettingsListTileCheckbox(
                  label: Text(folder.name),
                  value: isGrouped,
                  onChanged: (value) {
                    final updated = [...preferences.groupedFolders];
                    if (value == true) {
                      if (!updated.contains(folder.id)) updated.add(folder.id);
                    } else {
                      updated.remove(folder.id);
                    }
                    ref.read(homePreferencesProvider.notifier).setGroupedFolders(updated);
                  },
                );
              }),
              SettingsListTile(
                label: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButtonAwait(
                      onPressed: hasChanges
                          ? () async {
                              ref.read(homePreferencesProvider.notifier).revert();
                            }
                          : null,
                      child: Text(context.localized.cancel),
                    ),
                    FilledButtonAwait(
                      onPressed: hasChanges
                          ? () async {
                              await FladderSnack.showResponse(
                                ref.read(homePreferencesProvider.notifier).save(),
                                successTitle: context.localized.saved,
                              );
                            }
                          : null,
                      child: Text(context.localized.save),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
