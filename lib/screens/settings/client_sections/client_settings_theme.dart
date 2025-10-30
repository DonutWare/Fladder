import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/custom_color_themes.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/option_dialogue.dart';
import 'package:fladder/util/theme_mode_extension.dart';

List<Widget> buildClientSettingsTheme(BuildContext context, WidgetRef ref) {
  final clientSettings = ref.watch(clientSettingsProvider);
  return settingsListGroup(context, SettingsLabelDivider(label: context.localized.theme), [
    SettingsListTile(
      label: Text(context.localized.mode),
      subLabel: Text(clientSettings.themeMode.label(context)),
      onTap: () => openMultiSelectOptions<ThemeMode>(
        context,
        label: "${context.localized.theme} ${context.localized.mode}",
        items: ThemeMode.values,
        selected: [ref.read(clientSettingsProvider.select((value) => value.themeMode))],
        onChanged: (values) => ref.read(clientSettingsProvider.notifier).setThemeMode(values.first),
        itemBuilder: (type, selected, tap) => CheckboxListTile(
          value: selected,
          onChanged: (value) => tap(),
          title: Text(type.label(context)),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ),
    SettingsListTile(
      label: Text(context.localized.color),
      subLabel: Text(clientSettings.themeColor?.name ?? context.localized.dynamicText),
      onTap: () => openMultiSelectOptions<ColorThemes?>(
        context,
        label: context.localized.color,
        items: [null, ...ColorThemes.values],
        selected: [(ref.read(clientSettingsProvider.select((value) => value.themeColor)))],
        onChanged: (values) => ref.read(clientSettingsProvider.notifier).setThemeColor(values.first),
        itemBuilder: (type, selected, tap) => CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: selected,
          onChanged: (value) => tap(),
          title: Row(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  gradient: type == null
                      ? const SweepGradient(
                          center: FractionalOffset.center,
                          colors: <Color>[
                            Color(0xFF4285F4), // blue
                            Color(0xFF34A853), // green
                            Color(0xFFFBBC05), // yellow
                            Color(0xFFEA4335), // red
                            Color(0xFF4285F4), // blue again to seamlessly transition to the start
                          ],
                          stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                        )
                      : null,
                  color: type?.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(type?.name ?? context.localized.dynamicText),
            ],
          ),
        ),
      ),
    ),
    SettingsListTile(
      label: Text(context.localized.clientSettingsSchemeVariantTitle),
      subLabel: Text(clientSettings.schemeVariant.label(context)),
      onTap: () async {
        await openMultiSelectOptions<DynamicSchemeVariant>(
          context,
          label: context.localized.clientSettingsSchemeVariantTitle,
          items: DynamicSchemeVariant.values,
          selected: [(ref.read(clientSettingsProvider.select((value) => value.schemeVariant)))],
          onChanged: (values) => ref.read(clientSettingsProvider.notifier).setSchemeVariant(values.first),
          itemBuilder: (type, selected, tap) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: selected,
            onChanged: (value) => tap(),
            title: Text(type.label(context)),
          ),
        );
      },
    ),
    SettingsListTile(
      label: Text(context.localized.amoledBlack),
      subLabel: Text(clientSettings.amoledBlack ? context.localized.enabled : context.localized.disabled),
      onTap: () => ref.read(clientSettingsProvider.notifier).setAmoledBlack(!clientSettings.amoledBlack),
      trailing: Switch(
        value: clientSettings.amoledBlack,
        onChanged: (value) => ref.read(clientSettingsProvider.notifier).setAmoledBlack(value),
      ),
    ),
    SettingsListTile(
      label: Text(context.localized.itemColorsTitle),
      subLabel: Text(context.localized.itemColorsDesc),
      onTap: () =>
          ref.read(clientSettingsProvider.notifier).setDerivedColorsFromItem(!clientSettings.deriveColorsFromItem),
      trailing: Switch(
        value: clientSettings.deriveColorsFromItem,
        onChanged: (value) => ref.read(clientSettingsProvider.notifier).setDerivedColorsFromItem(value),
      ),
    ),
  ]);
}
