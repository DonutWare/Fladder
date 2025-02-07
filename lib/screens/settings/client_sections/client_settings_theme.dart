import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/custom_color_themes.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/option_dialogue.dart';
import 'package:fladder/util/theme_mode_extension.dart';

List<Widget> buildClientSettingsTheme(BuildContext context, WidgetRef ref) {
  final clientSettings = ref.watch(clientSettingsProvider);
  return [
    SettingsLabelDivider(label: context.localized.theme),
    SettingsListTile(
      label: Text(context.localized.mode),
      subLabel: Text(clientSettings.themeMode.label(context)),
      onTap: () => openOptionDialogue(
        context,
        label: "${context.localized.theme} ${context.localized.mode}",
        items: ThemeMode.values,
        itemBuilder: (type) => RadioListTile(
          value: type,
          title: Text(type?.label(context) ?? context.localized.other),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          groupValue: ref.read(clientSettingsProvider.select((value) => value.themeMode)),
          onChanged: (value) => ref.read(clientSettingsProvider.notifier).setThemeMode(value),
        ),
      ),
    ),
    SettingsListTile(
      label: Text(context.localized.color),
      subLabel: Text(clientSettings.themeColor?.name ?? context.localized.dynamicText),
      onTap: () => openOptionDialogue<ColorThemes>(
        context,
        isNullable: !kIsWeb,
        label: context.localized.themeColor,
        items: ColorThemes.values,
        itemBuilder: (type) => Consumer(
          builder: (context, ref, child) => ListTile(
            title: Row(
              children: [
                Checkbox(
                  value: type == ref.watch(clientSettingsProvider.select((value) => value.themeColor)),
                  onChanged: (value) => ref.read(clientSettingsProvider.notifier).setThemeColor(type),
                ),
                const SizedBox(width: 4),
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
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => ref.read(clientSettingsProvider.notifier).setThemeColor(type),
          ),
        ),
      ),
    ),
    SettingsListTile(
      label: Text(context.localized.clientSettingsSchemeVariantTitle),
      subLabel: Text(clientSettings.schemeVariant.label(context)),
      onTap: () => openOptionDialogue<DynamicSchemeVariant>(
        context,
        isNullable: false,
        label: context.localized.themeColor,
        items: DynamicSchemeVariant.values,
        itemBuilder: (type) => Consumer(
          builder: (context, ref, child) => ListTile(
            title: Row(
              children: [
                Checkbox(
                  value: type == ref.watch(clientSettingsProvider.select((value) => value.schemeVariant)),
                  onChanged: (value) => ref.read(clientSettingsProvider.notifier).setSchemeVariant(type),
                ),
                const SizedBox(width: 8),
                Text(type?.label(context) ?? ""),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => ref.read(clientSettingsProvider.notifier).setSchemeVariant(type),
          ),
        ),
      ),
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
    const Divider(),
  ];
}
