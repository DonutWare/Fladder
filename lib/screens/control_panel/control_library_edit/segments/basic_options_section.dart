import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/collection_types.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';

class BasicOptionsSection extends ConsumerWidget {
  final VirtualFolderInfo selectedFolder;
  final LibraryOptions? currentOptions;

  const BasicOptionsSection({
    required this.selectedFolder,
    required this.currentOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(controlLibrariesProvider.notifier);
    final currentCollectionType = ref.watch(
      controlLibrariesProvider.select((state) => state.currentCollectionType),
    );

    if (currentOptions == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.library(1)),
          [
            SettingsListTileCheckbox(
              label: Text(context.localized.enabled),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(enabled: value),
                );
              },
              value: currentOptions?.enabled ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.enabledRealtimeMonitoring),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(enableRealtimeMonitor: value),
                );
              },
              value: currentOptions?.enableRealtimeMonitor ?? false,
            ),
            if (currentCollectionType.photos == true)
              SettingsListTileCheckbox(
                label: Text(context.localized.enabledPhotos),
                onChanged: (value) {
                  provider.updateSelectedLibraryOptions(
                    currentOptions?.copyWith(enablePhotos: value),
                  );
                },
                value: currentOptions?.enablePhotos ?? false,
              ),
            if (currentCollectionType.audio == true)
              SettingsListTileCheckbox(
                label: Text(context.localized.enabledLUFSScan),
                onChanged: (value) {
                  provider.updateSelectedLibraryOptions(
                    currentOptions?.copyWith(enableLUFSScan: value),
                  );
                },
                value: currentOptions?.enableLUFSScan ?? false,
              ),
            if (currentCollectionType.videos == true) ...[
              SettingsListTileCheckbox(
                label: Text(context.localized.automaticallyAddToCollection),
                onChanged: (value) {
                  provider.updateSelectedLibraryOptions(
                    currentOptions?.copyWith(automaticallyAddToCollection: value),
                  );
                },
                value: currentOptions?.automaticallyAddToCollection ?? false,
              ),
              SettingsListTileCheckbox(
                label: Text(context.localized.enabledEmbeddedTitles),
                onChanged: (value) {
                  provider.updateSelectedLibraryOptions(
                    currentOptions?.copyWith(enableEmbeddedTitles: value),
                  );
                },
                value: currentOptions?.enableEmbeddedTitles ?? false,
              ),
              if (currentCollectionType.supportsExtras == true)
                SettingsListTileCheckbox(
                  label: Text(context.localized.enabledEmbeddedExtrasTitles),
                  onChanged: (value) {
                    provider.updateSelectedLibraryOptions(
                      currentOptions?.copyWith(enableEmbeddedExtrasTitles: value),
                    );
                  },
                  value: currentOptions?.enableEmbeddedExtrasTitles ?? false,
                ),
            ],
          ],
        ),
      ],
    );
  }
}
