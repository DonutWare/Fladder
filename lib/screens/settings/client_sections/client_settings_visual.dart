import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';

List<Widget> buildClientSettingsVisual(
  BuildContext context,
  WidgetRef ref,
  TextEditingController nextUpDaysEditor,
  TextEditingController libraryPageSizeController,
) {
  final clientSettings = ref.watch(clientSettingsProvider);
  Locale currentLocale = WidgetsBinding.instance.platformDispatcher.locale;
  return settingsListGroup(
    context,
    SettingsLabelDivider(label: context.localized.settingsVisual),
    [
      SettingsListTile(
        label: Text(context.localized.displayLanguage),
        trailing: Localizations.override(
          context: context,
          locale: ref.watch(clientSettingsProvider.select((value) => (value.selectedLocale ?? currentLocale))),
          child: Builder(builder: (context) {
            String language = "English";
            try {
              language = context.localized.nativeName;
            } catch (_) {}
            return EnumBox(
              current: language,
              itemBuilder: (context) {
                return [
                  ...AppLocalizations.supportedLocales.map(
                    (entry) => PopupMenuItem(
                      value: entry,
                      child: Localizations.override(
                        context: context,
                        locale: entry,
                        child: Builder(builder: (context) {
                          return Text("${context.localized.nativeName} (${entry.toDisplayCode()})");
                        }),
                      ),
                      onTap: () => ref
                          .read(clientSettingsProvider.notifier)
                          .update((state) => state.copyWith(selectedLocale: entry)),
                    ),
                  )
                ];
              },
            );
          }),
        ),
      ),
      SettingsListTile(
        label: Text(context.localized.settingsBlurredPlaceholderTitle),
        subLabel: Text(context.localized.settingsBlurredPlaceholderDesc),
        onTap: () => ref.read(clientSettingsProvider.notifier).setBlurPlaceholders(!clientSettings.blurPlaceHolders),
        trailing: Switch(
          value: clientSettings.blurPlaceHolders,
          onChanged: (value) => ref.read(clientSettingsProvider.notifier).setBlurPlaceholders(value),
        ),
      ),
      SettingsListTile(
        label: Text(context.localized.settingsBlurEpisodesTitle),
        subLabel: Text(context.localized.settingsBlurEpisodesDesc),
        onTap: () => ref.read(clientSettingsProvider.notifier).setBlurEpisodes(!clientSettings.blurUpcomingEpisodes),
        trailing: Switch(
          value: clientSettings.blurUpcomingEpisodes,
          onChanged: (value) => ref.read(clientSettingsProvider.notifier).setBlurEpisodes(value),
        ),
      ),
      SettingsListTile(
        label: Text(context.localized.settingsEnableOsMediaControls),
        subLabel: Text(context.localized.settingsEnableOsMediaControlsDesc),
        onTap: () => ref.read(clientSettingsProvider.notifier).setMediaKeys(!clientSettings.enableMediaKeys),
        trailing: Switch(
          value: clientSettings.enableMediaKeys,
          onChanged: (value) => ref.read(clientSettingsProvider.notifier).setMediaKeys(value),
        ),
      ),
      SettingsListTile(
        label: Text(context.localized.enableBackgroundPostersTitle),
        subLabel: Text(context.localized.enableBackgroundPostersDesc),
        onTap: () => ref
            .read(clientSettingsProvider.notifier)
            .update((cb) => cb.copyWith(backgroundPosters: !clientSettings.backgroundPosters)),
        trailing: Switch(
          value: clientSettings.backgroundPosters,
          onChanged: (value) =>
              ref.read(clientSettingsProvider.notifier).update((cb) => cb.copyWith(backgroundPosters: value)),
        ),
      ),
      SettingsListTile(
        label: Text(context.localized.settingsNextUpCutoffDays),
        trailing: SizedBox(
            width: 100,
            child: IntInputField(
              suffix: context.localized.days,
              controller: nextUpDaysEditor,
              onSubmitted: (value) {
                if (value != null) {
                  ref.read(clientSettingsProvider.notifier).update((current) => current.copyWith(
                        nextUpDateCutoff: Duration(days: value),
                      ));
                }
              },
            )),
      ),
      SettingsListTile(
        label: Text(context.localized.libraryPageSizeTitle),
        subLabel: Text(context.localized.libraryPageSizeDesc),
        trailing: SizedBox(
            width: 100,
            child: IntInputField(
              controller: libraryPageSizeController,
              placeHolder: "500",
              onSubmitted: (value) => ref.read(clientSettingsProvider.notifier).update(
                    (current) => current.copyWith(libraryPageSize: value),
                  ),
            )),
      ),
      SettingsListTile(
        label: Text(AdaptiveLayout.of(context).isDesktop
            ? context.localized.settingsShowScaleSlider
            : context.localized.settingsPosterPinch),
        onTap: () => ref.read(clientSettingsProvider.notifier).update(
              (current) => current.copyWith(pinchPosterZoom: !current.pinchPosterZoom),
            ),
        trailing: Switch(
          value: clientSettings.pinchPosterZoom,
          onChanged: (value) => ref.read(clientSettingsProvider.notifier).update(
                (current) => current.copyWith(pinchPosterZoom: value),
              ),
        ),
      ),
      Column(
        children: [
          SettingsListTile(
            label: Text(context.localized.settingsPosterSize),
            trailing: Text(
              clientSettings.posterSize.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FladderSlider(
              min: 0.5,
              max: 1.5,
              value: clientSettings.posterSize,
              divisions: 20,
              onChanged: (value) =>
                  ref.read(clientSettingsProvider.notifier).update((current) => current.copyWith(posterSize: value)),
            ),
          ),
        ],
      ),
    ],
  );
}
