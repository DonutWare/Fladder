import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';

class TrickplaySection extends ConsumerWidget {
  final LibraryOptions? currentOptions;

  const TrickplaySection({
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
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.trickplay),
          [
            SettingsListTileCheckbox(
              label: Text(context.localized.enableTrickplayImageExtraction),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(enableTrickplayImageExtraction: value),
                );
              },
              value: currentOptions?.enableTrickplayImageExtraction ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.extractTrickplayImagesDuringLibraryScan),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(extractTrickplayImagesDuringLibraryScan: value),
                );
              },
              value: currentOptions?.extractTrickplayImagesDuringLibraryScan ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.saveTrickplayImagesNextToMedia),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(saveTrickplayWithMedia: value),
                );
              },
              value: currentOptions?.saveTrickplayWithMedia ?? false,
            ),
          ],
        ),
      ],
    );
  }
}
