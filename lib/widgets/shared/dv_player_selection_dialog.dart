import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/util/external_player_helper.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/screens/settings/widgets/settings_message_box.dart';

class DVPlayerSelectionDialog extends ConsumerStatefulWidget {
  const DVPlayerSelectionDialog({super.key});

  @override
  ConsumerState<DVPlayerSelectionDialog> createState() => _DVPlayerSelectionDialogState();
}

class _DVPlayerSelectionDialogState extends ConsumerState<DVPlayerSelectionDialog> {
  bool _remember = false;
  bool? _isInstalled;

  @override
  void initState() {
    super.initState();
    _checkInstallation();
  }

  Future<void> _checkInstallation() async {
    final installed = await ExternalPlayerHelper.isEnergyPlayerInstalled();
    if (mounted) {
      setState(() => _isInstalled = installed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.localized.dvPlayerDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.localized.dvPlayerDialogDesc),
            const SizedBox(height: 12),
            Text(
              context.localized.dvEnableInstruction,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 12),
            SettingsMessageBox(
              context.localized.dvSyncWarning,
              messageType: MessageType.warning,
            ),
            if (_isInstalled == false) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      context.localized.dvPlayerNotInstalled,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => ExternalPlayerHelper.openStore(),
                      icon: const Icon(Icons.download),
                      label: Text(context.localized.dvPlayerGetFromStore),
                      style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _remember,
              onChanged: (val) => setState(() => _remember = val ?? false),
              title: Text(context.localized.dvRememberChoice),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
        TextButton(
          onPressed: () {
            if (_remember) {
              ref.read(videoPlayerSettingsProvider.notifier).setDVPlayerChoice(DVPlayerChoice.internalPlayer);
            }
            Navigator.of(context).pop(DVPlayerChoice.internalPlayer);
          },
          child: Text(context.localized.dvPlayerDisabled),
        ),
        FilledButton(
          onPressed: () {
            if (_remember) {
              ref.read(videoPlayerSettingsProvider.notifier).setDVPlayerChoice(DVPlayerChoice.energyPlayer);
            }
            Navigator.of(context).pop(DVPlayerChoice.energyPlayer);
          },
          child: Text(context.localized.dvPlayerEnergyPlayer),
        ),
      ],
    );
  }
}
