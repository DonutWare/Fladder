import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/settings/client_sections/client_settings_advanced.dart';
import 'package:fladder/screens/settings/client_sections/client_settings_dashboard.dart';
import 'package:fladder/screens/settings/client_sections/client_settings_download.dart';
import 'package:fladder/screens/settings/client_sections/client_settings_theme.dart';
import 'package:fladder/screens/settings/client_sections/client_settings_visual.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/simple_duration_picker.dart';

@RoutePage()
class ClientSettingsPage extends ConsumerStatefulWidget {
  const ClientSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientSettingsPageState();
}

class _ClientSettingsPageState extends ConsumerState<ClientSettingsPage> {
  late final nextUpDaysEditor = TextEditingController(
      text: ref.read(clientSettingsProvider.select((value) => value.nextUpDateCutoff?.inDays ?? 14)).toString());

  late final libraryPageSizeController = TextEditingController(
      text: ref.read(clientSettingsProvider.select((value) => value.libraryPageSize))?.toString() ?? "");

  @override
  Widget build(BuildContext context) {
    final clientSettings = ref.watch(clientSettingsProvider);
    final showBackground = AdaptiveLayout.viewSizeOf(context) != ViewSize.phone &&
        AdaptiveLayout.layoutModeOf(context) != LayoutMode.single;

    return Card(
      elevation: showBackground ? 2 : 0,
      child: SettingsScaffold(
        label: "Fladder",
        items: [
          ...buildClientSettingsDownload(context, ref, setState),
          SettingsLabelDivider(label: context.localized.lockscreen),
          SettingsListTile(
            label: Text(context.localized.timeOut),
            subLabel: Text(timePickerString(context, clientSettings.timeOut)),
            onTap: () async {
              final timePicker = await showSimpleDurationPicker(
                context: context,
                initialValue: clientSettings.timeOut ?? const Duration(),
              );

              if (timePicker == null) return;

              ref.read(clientSettingsProvider.notifier).setTimeOut(timePicker != Duration.zero
                  ? Duration(minutes: timePicker.inMinutes, seconds: timePicker.inSeconds % 60)
                  : null);
            },
          ),
          const Divider(),
          ...buildClientSettingsDashboard(context, ref),
          ...buildClientSettingsVisual(context, ref, nextUpDaysEditor, libraryPageSizeController),
          ...buildClientSettingsTheme(context, ref),
          if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer) ...[
            SettingsLabelDivider(label: context.localized.controls),
            SettingsListTile(
              label: Text(context.localized.mouseDragSupport),
              subLabel: Text(clientSettings.mouseDragSupport ? context.localized.enabled : context.localized.disabled),
              onTap: () => ref
                  .read(clientSettingsProvider.notifier)
                  .update((current) => current.copyWith(mouseDragSupport: !clientSettings.mouseDragSupport)),
              trailing: Switch(
                value: clientSettings.mouseDragSupport,
                onChanged: (value) => ref
                    .read(clientSettingsProvider.notifier)
                    .update((current) => current.copyWith(mouseDragSupport: !clientSettings.mouseDragSupport)),
              ),
            ),
          ],
          const Divider(),
          ...buildClientSettingsAdvanced(context, ref),
          if (kDebugMode) ...[
            const SizedBox(height: 64),
            SettingsListTile(
              label: Text(
                context.localized.clearAllSettings,
              ),
              contentColor: Theme.of(context).colorScheme.error,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.localized.clearAllSettingsQuestion,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            context.localized.unableToReverseAction,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FilledButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(context.localized.cancel),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  await ref.read(sharedPreferencesProvider).clear();
                                  context.router.push(const LoginRoute());
                                },
                                child: Text(context.localized.clear),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
