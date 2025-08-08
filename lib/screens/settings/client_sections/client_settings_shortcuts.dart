import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/settings/widgets/key_listener.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

List<Widget> buildClientSettingsShortCuts(
  BuildContext context,
  WidgetRef ref,
) {
  final clientSettings = ref.watch(clientSettingsProvider);
  return settingsListGroup(
    context,
    SettingsLabelDivider(label: context.localized.shortCuts),
    [
      ...GlobalHotKeys.values.map(
        (entry) {
          final currentEntry = clientSettings.shortcuts[entry];
          final defaultEntry = clientSettings.defaultShortCuts[entry]!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.name.toUpperCaseSplit(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Flexible(
                  child: KeyCombinationWidget(
                    currentKey: currentEntry,
                    defaultKey: defaultEntry,
                    onChanged: (value) =>
                        ref.read(clientSettingsProvider.notifier).setShortcuts(MapEntry(entry, value)),
                  ),
                )
              ],
            ),
          );
        },
      )
    ],
  );
}
