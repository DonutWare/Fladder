import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/control_panel/control_server_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class ControlServerPage extends ConsumerStatefulWidget {
  const ControlServerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlServerPageState();
}

class _ControlServerPageState extends ConsumerState<ControlServerPage> {
  final serverNameController = TextEditingController();
  final cachePathController = TextEditingController();
  final metadataPathController = TextEditingController();

  final maxConcurrentLibraryScanController = TextEditingController();
  final maxImageDecodingThreadsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serverConfig = ref.watch(controlServerProvider);
    final provider = ref.read(controlServerProvider.notifier);

    ref.listen(controlServerProvider, (previous, next) {
      serverNameController.text = next.name;
      cachePathController.text = next.cachePath;
      metadataPathController.text = next.metaDataPath;
      maxConcurrentLibraryScanController.text = next.maxConcurrentLibraryScan.toString();
      maxImageDecodingThreadsController.text = next.maxImageDecodingThreads.toString();
    });

    return PullToRefresh(
      onRefresh: () async => await provider.fetchSettings(),
      child: SettingsScaffold(
        label: context.localized.server,
        items: [
          ...settingsListGroup(
            context,
            SettingsLabelDivider(label: context.localized.settings),
            [
              SettingsListTile(
                label: Text(context.localized.serverNameLabel),
                trailing: OutlinedTextField(
                  placeHolder: context.localized.serverName,
                  controller: serverNameController,
                  onSubmitted: (value) => provider.update(
                    serverConfig.copyWith(name: value),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          ...settingsListGroup(
            context,
            SettingsLabelDivider(label: context.localized.storagePaths),
            [
              SettingsListTile(
                label: Text(context.localized.cachePath),
                trailing: OutlinedTextField(
                  placeHolder: context.localized.cachePath,
                  controller: cachePathController,
                  onSubmitted: (value) => provider.update(
                    serverConfig.copyWith(cachePath: value),
                  ),
                ),
              ),
              SettingsListTile(
                label: Text(context.localized.metadataPath),
                trailing: OutlinedTextField(
                  placeHolder: context.localized.metadataPath,
                  controller: metadataPathController,
                  onSubmitted: (value) => provider.update(
                    serverConfig.copyWith(metaDataPath: value),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...settingsListGroup(
            context,
            SettingsLabelDivider(label: context.localized.quickConnectTitle),
            [
              SettingsListTile(
                label: Text(context.localized.quickConnectTitle),
                onTap: () => provider.update(
                  serverConfig.copyWith(quickConnectEnabled: !serverConfig.quickConnectEnabled),
                ),
                trailing: Switch(
                  value: serverConfig.quickConnectEnabled,
                  onChanged: (value) => provider.update(
                    serverConfig.copyWith(quickConnectEnabled: value),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...settingsListGroup(
            context,
            SettingsLabelDivider(label: context.localized.performance),
            [
              SettingsListTile(
                label: Text(context.localized.maxConcurrentLibraryScanLabel),
                trailingInlineWithLabel: true,
                subLabel: Text(context.localized.maxConcurrentLibraryScanDesc),
                trailing: IntInputField(
                  controller: maxConcurrentLibraryScanController,
                  onSubmitted: (value) => provider.update(
                    serverConfig.copyWith(maxConcurrentLibraryScan: value ?? serverConfig.maxConcurrentLibraryScan),
                  ),
                ),
              ),
              SettingsListTile(
                label: Text(context.localized.maxImageDecodingThreadsLabel),
                trailingInlineWithLabel: true,
                subLabel: Text(context.localized.maxImageDecodingThreadsDesc),
                trailing: IntInputField(
                  controller: maxImageDecodingThreadsController,
                  onSubmitted: (value) => provider.update(
                    serverConfig.copyWith(maxImageDecodingThreads: value ?? serverConfig.maxImageDecodingThreads),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: FilledButtonAwait(
              onPressed: () async {
                await provider.save();
                await Future.delayed(const Duration(milliseconds: 250));
              },
              child: Text(context.localized.save),
            ),
          )
        ],
      ),
    );
  }
}
