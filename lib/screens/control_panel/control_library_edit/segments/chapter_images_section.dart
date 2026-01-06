import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';

class ChapterImagesSection extends ConsumerWidget {
  final LibraryOptions? currentOptions;

  const ChapterImagesSection({
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
          SettingsLabelDivider(label: context.localized.chapterImages),
          [
            SettingsListTileCheckbox(
              label: Text(context.localized.enableChapterImageExtraction),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(enableChapterImageExtraction: value),
                );
              },
              value: currentOptions?.enableChapterImageExtraction ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.extractChapterImagesDuringLibraryScan),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(extractChapterImagesDuringLibraryScan: value),
                );
              },
              value: currentOptions?.extractChapterImagesDuringLibraryScan ?? false,
            ),
          ],
        ),
      ],
    );
  }
}
