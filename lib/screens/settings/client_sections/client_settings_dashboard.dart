import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';

List<Widget> buildClientSettingsDashboard(BuildContext context, WidgetRef ref) {
  final clientSettings = ref.watch(clientSettingsProvider);
  return [
    SettingsLabelDivider(label: context.localized.dashboard),
    SettingsListTile(
      label: Text(context.localized.settingsHomeBannerTitle),
      subLabel: Text(context.localized.settingsHomeBannerDescription),
      trailing: EnumBox(
        current: ref.watch(
          homeSettingsProvider.select(
            (value) => value.homeBanner.label(context),
          ),
        ),
        itemBuilder: (context) => HomeBanner.values
            .map(
              (entry) => PopupMenuItem(
                value: entry,
                child: Text(entry.label(context)),
                onTap: () =>
                    ref.read(homeSettingsProvider.notifier).update((context) => context.copyWith(homeBanner: entry)),
              ),
            )
            .toList(),
      ),
    ),
    if (ref.watch(homeSettingsProvider.select((value) => value.homeBanner)) != HomeBanner.hide)
      SettingsListTile(
        label: Text(context.localized.settingsHomeBannerInformationTitle),
        subLabel: Text(context.localized.settingsHomeBannerInformationDesc),
        trailing: EnumBox(
          current: ref.watch(
            homeSettingsProvider.select((value) => value.carouselSettings.label(context)),
          ),
          itemBuilder: (context) => HomeCarouselSettings.values
              .map(
                (entry) => PopupMenuItem(
                  value: entry,
                  child: Text(entry.label(context)),
                  onTap: () => ref
                      .read(homeSettingsProvider.notifier)
                      .update((context) => context.copyWith(carouselSettings: entry)),
                ),
              )
              .toList(),
        ),
      ),
    SettingsListTile(
      label: Text(context.localized.settingsHomeNextUpTitle),
      subLabel: Text(context.localized.settingsHomeNextUpDesc),
      trailing: EnumBox(
        current: ref.watch(
          homeSettingsProvider.select(
            (value) => value.nextUp.label(context),
          ),
        ),
        itemBuilder: (context) => HomeNextUp.values
            .map(
              (entry) => PopupMenuItem(
                value: entry,
                child: Text(entry.label(context)),
                onTap: () =>
                    ref.read(homeSettingsProvider.notifier).update((context) => context.copyWith(nextUp: entry)),
              ),
            )
            .toList(),
      ),
    ),
    SettingsListTile(
      label: Text(context.localized.clientSettingsShowAllCollectionsTitle),
      subLabel: Text(context.localized.clientSettingsShowAllCollectionsDesc),
      onTap: () => ref
          .read(clientSettingsProvider.notifier)
          .update((current) => current.copyWith(showAllCollectionTypes: !current.showAllCollectionTypes)),
      trailing: Switch(
        value: clientSettings.showAllCollectionTypes,
        onChanged: (value) => ref
            .read(clientSettingsProvider.notifier)
            .update((current) => current.copyWith(showAllCollectionTypes: value)),
      ),
    ),
    const Divider(),
  ];
}
