import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/sortable_item_list.dart';

class SubtitleDownloadsSection extends ConsumerWidget {
  final LibraryOptions? currentOptions;
  final List<CultureDto> cultures;
  final LibraryOptionsResultDto? availableOptions;

  const SubtitleDownloadsSection({
    required this.currentOptions,
    required this.cultures,
    required this.availableOptions,
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
          SettingsLabelDivider(label: context.localized.subtitleDownloads),
          [
            SettingsListChild(
              isFirst: true,
              isLast: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsLabelDivider(label: context.localized.downloadLanguages),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SortableItemList<CultureDto>(
                      items: cultures,
                      included: cultures
                          .where((element) =>
                              currentOptions?.subtitleDownloadLanguages?.contains(
                                element.threeLetterISOLanguageName,
                              ) ==
                              true)
                          .toList(),
                      itemBuilder: (item) => Text(item.displayName ?? item.name ?? context.localized.unknown),
                      maxHeight: 250,
                      onIncludeChange: (items) {
                        provider.updateSelectedLibraryOptions(
                          currentOptions?.copyWith(
                            subtitleDownloadLanguages: items.map((e) => e.threeLetterISOLanguageName).nonNulls.toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Builder(builder: (context) {
              final availableSubtitleFetchers = <String>{
                ...currentOptions?.subtitleFetcherOrder ?? [],
                ...(availableOptions?.subtitleFetchers ?? []).map((e) => e.name).nonNulls,
              }.toList();
              return SettingsListChild(
                isFirst: true,
                isLast: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsLabelDivider(label: context.localized.subtitleDownloaders),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SortableItemList<String>(
                        items: availableSubtitleFetchers,
                        included: availableSubtitleFetchers.toList()
                          ..removeWhere(
                              (element) => (currentOptions?.disabledSubtitleFetchers ?? []).contains(element)),
                        itemBuilder: (item) => Text(item),
                        onIncludeChange: (items) {
                          provider.updateSelectedLibraryOptions(
                            currentOptions?.copyWith(
                              disabledSubtitleFetchers: currentOptions?.subtitleFetcherOrder
                                  ?.where((element) => !items.contains(element))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
            SettingsListTileCheckbox(
              label: Text(context.localized.onlyPerfectSubtitleMatch),
              subLabel: Text(context.localized.perfectSubtitleMatchDescription),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(requirePerfectSubtitleMatch: value),
                );
              },
              value: currentOptions?.requirePerfectSubtitleMatch ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.skipSubtitlesIfAudioMatches),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(skipSubtitlesIfAudioTrackMatches: value),
                );
              },
              value: currentOptions?.skipSubtitlesIfAudioTrackMatches ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.skipSubtitlesIfEmbedded),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(skipSubtitlesIfEmbeddedSubtitlesPresent: value),
                );
              },
              value: currentOptions?.skipSubtitlesIfEmbeddedSubtitlesPresent ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.saveSubtitlesNextToMedia),
              onChanged: (value) {
                provider.updateSelectedLibraryOptions(
                  currentOptions?.copyWith(saveSubtitlesWithMedia: value),
                );
              },
              value: currentOptions?.saveSubtitlesWithMedia ?? false,
            ),
          ],
        ),
      ],
    );
  }
}
