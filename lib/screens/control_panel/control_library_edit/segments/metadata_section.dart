import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class MetadataSection extends ConsumerWidget {
  final LibraryOptions? currentOptions;
  final List<CultureDto> cultures;
  final List<CountryInfo> countries;

  const MetadataSection({
    required this.currentOptions,
    required this.cultures,
    required this.countries,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(controlLibrariesProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...settingsListGroup(
          context,
          null,
          [
            SettingsListTile(
              label: Text(context.localized.automaticRefreshInterval),
              subLabel: Text(context.localized.autoRefreshIntervalNote),
              trailing: EnumBox(
                current: ((currentOptions?.automaticRefreshIntervalDays ?? 0) != 0
                    ? "${currentOptions?.automaticRefreshIntervalDays ?? 0} ${context.localized.days(currentOptions?.automaticRefreshIntervalDays ?? 0)}"
                    : context.localized.never),
                itemBuilder: (context) => [
                  Duration.zero,
                  const Duration(days: 30),
                  const Duration(days: 60),
                  const Duration(days: 90),
                ]
                    .map(
                      (e) => ItemActionButton(
                        label: Text(e.inDays != 0
                            ? "${e.inDays} ${context.localized.days(e.inDays)}"
                            : context.localized.never),
                        action: () {
                          provider.updateSelectedLibraryOptions(
                            currentOptions?.copyWith(automaticRefreshIntervalDays: e.inDays),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            SettingsListTile(
              label: Text(context.localized.preferredDownloadLanguage),
              trailing: EnumBox(
                current: cultures
                        .firstWhereOrNull((element) =>
                            element.twoLetterISOLanguageName?.toLowerCase() ==
                            currentOptions?.preferredMetadataLanguage?.toLowerCase())
                        ?.displayName ??
                    context.localized.unknown,
                itemBuilder: (context) => cultures
                    .map(
                      (e) => ItemActionButton(
                        selected: e.twoLetterISOLanguageName?.toLowerCase() ==
                            currentOptions?.preferredMetadataLanguage?.toLowerCase(),
                        label: Text(e.displayName ?? e.name ?? context.localized.unknown),
                        action: () {
                          provider.updateSelectedLibraryOptions(
                            currentOptions?.copyWith(preferredMetadataLanguage: e.twoLetterISOLanguageName),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            SettingsListTile(
              label: Text(context.localized.countryRegion),
              trailing: EnumBox(
                current: countries
                        .firstWhereOrNull((element) =>
                            element.twoLetterISORegionName?.toLowerCase() ==
                            currentOptions?.metadataCountryCode?.toLowerCase())
                        ?.displayName ??
                    context.localized.unknown,
                itemBuilder: (context) => countries
                    .map(
                      (e) => ItemActionButton(
                        selected: e.twoLetterISORegionName?.toLowerCase() ==
                            currentOptions?.metadataCountryCode?.toLowerCase(),
                        label: Text(e.displayName ?? e.name ?? context.localized.unknown),
                        action: () {
                          provider.updateSelectedLibraryOptions(
                            currentOptions?.copyWith(metadataCountryCode: e.twoLetterISORegionName),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
