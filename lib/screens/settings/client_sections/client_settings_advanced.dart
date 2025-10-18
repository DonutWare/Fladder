import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/option_dialogue.dart';

List<Widget> buildClientSettingsAdvanced(BuildContext context, WidgetRef ref) {
  return settingsListGroup(
    context,
    SettingsLabelDivider(label: context.localized.advanced),
    [
      SettingsListTile(
        label: Text(context.localized.settingsLayoutSizesTitle),
        subLabel: Text(context.localized.settingsLayoutSizesDesc),
        onTap: () async {
          final newItems = await openMultiSelectOptions<ViewSize>(
            context,
            label: context.localized.settingsLayoutSizesTitle,
            items: ViewSize.values,
            allowMultiSelection: true,
            selected: ref.read(homeSettingsProvider.select((value) => value.layoutStates.toList())),
            itemBuilder: (type, selected, tap) => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: selected,
              onChanged: (value) => tap(),
              title: Text(type.label(context)),
            ),
          );
          ref.read(homeSettingsProvider.notifier).setViewSize(newItems.toSet());
        },
        trailing: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          shadowColor: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ref
                .watch(homeSettingsProvider.select((value) => value.layoutStates.toList()))
                .map((e) => e.label(context))
                .join(', ')),
          ),
        ),
      ),
      SettingsListTile(
        label: Text(context.localized.settingsLayoutModesTitle),
        subLabel: Text(context.localized.settingsLayoutModesDesc),
        onTap: () async {
          final newItems = await openMultiSelectOptions<LayoutMode>(
            context,
            label: context.localized.settingsLayoutModesTitle,
            items: LayoutMode.values,
            allowMultiSelection: true,
            selected: ref.read(homeSettingsProvider.select((value) => value.screenLayouts.toList())),
            itemBuilder: (type, selected, tap) => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: selected,
              onChanged: (value) => tap(),
              title: Text(type.label(context)),
            ),
          );
          ref.read(homeSettingsProvider.notifier).setLayoutModes(newItems.toSet());
        },
        trailing: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          shadowColor: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(ref
                .watch(homeSettingsProvider.select((value) => value.screenLayouts.toList()))
                .map((e) => e.label(context))
                .join(', ')),
          ),
        ),
      ),
      if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad)
        SettingsListTile(
          label: Text(context.localized.clientSettingsUseSystemIMETitle),
          subLabel: Text(context.localized.clientSettingsUseSystemIMEDesc),
          onTap: () => ref
              .read(clientSettingsProvider.notifier)
              .useSystemIME(!ref.read(clientSettingsProvider.select((value) => value.useSystemIME))),
          trailing: Switch(
            value: ref.watch(clientSettingsProvider.select((value) => value.useSystemIME)),
            onChanged: (value) => ref.read(clientSettingsProvider.notifier).useSystemIME(value),
          ),
        ),
    ],
  );
}
