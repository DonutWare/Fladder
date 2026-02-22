import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_tuner_edit_provider.dart';
import 'package:fladder/screens/control_panel/control_livetv/device_discovery_dialog.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class TunerHostEditDialog extends ConsumerWidget {
  final TunerHostInfo? tunerHost;

  const TunerHostEditDialog({super.key, this.tunerHost});

  Future<void> _discoverDevices(BuildContext context, WidgetRef ref) async {
    final selected = await showDialog<TunerHostInfo>(
      context: context,
      barrierDismissible: false,
      builder: (context) => DeviceDiscoveryDialog(
        onDiscover: () => ref.read(controlTunerEditProvider(tunerHost).notifier).discoverDevices(),
      ),
    );

    if (selected != null) {
      ref.read(controlTunerEditProvider(tunerHost).notifier).addDiscoveredDevice(selected);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controlTunerEditProvider(tunerHost));
    final notifier = ref.read(controlTunerEditProvider(tunerHost).notifier);

    return AlertDialog(
      title: Text(tunerHost == null ? context.localized.addTunerDevice : context.localized.editTunerDevice),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!state.isEditMode) ...[
              FilledButton.icon(
                onPressed: () => _discoverDevices(context, ref),
                icon: const Icon(Icons.search),
                label: Text(context.localized.detectDevices),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.localized.type(1),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                EnumBox(
                  current: state.selectedType.displayName,
                  itemBuilder: (context) => state.isEditMode
                      ? []
                      : TunerType.values
                          .map(
                            (type) => ItemActionButton(
                              label: Text(type.displayName),
                              action: () => notifier.updateType(type),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            OutlinedTextField(
              controller: TextEditingController(text: state.friendlyName)
                ..selection = TextSelection.collapsed(offset: state.friendlyName.length),
              label: context.localized.friendlyName,
              onChanged: notifier.updateFriendlyName,
            ),
            const SizedBox(height: 8),
            if (state.selectedType == TunerType.m3u) ..._buildM3uFields(context, state, notifier),
            if (state.selectedType == TunerType.hdhomerun) ..._buildHdhomerunFields(context, state, notifier),
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
            final tunerHost = notifier.buildTunerHostInfo();
            Navigator.of(context).pop(tunerHost);
          },
          child: Text(context.localized.save),
        ),
      ],
    );
  }

  List<Widget> _buildM3uFields(BuildContext context, ControlTunerEditModel state, ControlTunerEdit notifier) {
    return [
      OutlinedTextField(
        controller: TextEditingController(text: state.url)
          ..selection = TextSelection.collapsed(offset: state.url.length),
        label: context.localized.fileOrUrl,
        onChanged: notifier.updateUrl,
      ),
      const SizedBox(height: 8),
      OutlinedTextField(
        controller: TextEditingController(text: state.userAgent)
          ..selection = TextSelection.collapsed(offset: state.userAgent.length),
        label: context.localized.userAgentOptional,
        onChanged: notifier.updateUserAgent,
      ),
      const SizedBox(height: 8),
      OutlinedTextField(
        controller: TextEditingController(text: state.tunerCount.toString())
          ..selection = TextSelection.collapsed(offset: state.tunerCount.toString().length),
        label: context.localized.concurrentStreams,
        placeHolder: context.localized.concurrentStreamsHint,
        keyboardType: TextInputType.number,
        onChanged: notifier.updateTunerCount,
      ),
      const SizedBox(height: 8),
      OutlinedTextField(
        controller: TextEditingController(text: state.fallbackBitrateMbps.toString())
          ..selection = TextSelection.collapsed(offset: state.fallbackBitrateMbps.toString().length),
        label: context.localized.fallbackMaxBitrate,
        keyboardType: TextInputType.number,
        onChanged: notifier.updateFallbackBitrate,
      ),
      const SizedBox(height: 8),
      SwitchListTile(
        title: Text(context.localized.allowFmp4Container),
        value: state.allowFmp4Container,
        onChanged: notifier.updateAllowFmp4Container,
      ),
      SwitchListTile(
        title: Text(context.localized.allowStreamSharing),
        value: state.allowStreamSharing,
        onChanged: notifier.updateAllowStreamSharing,
      ),
      SwitchListTile(
        title: Text(context.localized.enableStreamLooping),
        value: state.enableStreamLooping,
        onChanged: notifier.updateEnableStreamLooping,
      ),
      SwitchListTile(
        title: Text(context.localized.ignoreDts),
        value: state.ignoreDts,
        onChanged: notifier.updateIgnoreDts,
      ),
      SwitchListTile(
        title: Text(context.localized.readAtNativeFramerate),
        value: state.readAtNativeFramerate,
        onChanged: notifier.updateReadAtNativeFramerate,
      ),
    ];
  }

  List<Widget> _buildHdhomerunFields(BuildContext context, ControlTunerEditModel state, ControlTunerEdit notifier) {
    return [
      OutlinedTextField(
        controller: TextEditingController(text: state.url)
          ..selection = TextSelection.collapsed(offset: state.url.length),
        label: context.localized.tunerIpAddress,
        onChanged: notifier.updateUrl,
      ),
      const SizedBox(height: 8),
      OutlinedTextField(
        controller: TextEditingController(text: state.fallbackBitrateMbps.toString())
          ..selection = TextSelection.collapsed(offset: state.fallbackBitrateMbps.toString().length),
        label: context.localized.fallbackMaxBitrate,
        keyboardType: TextInputType.number,
        onChanged: notifier.updateFallbackBitrate,
      ),
      const SizedBox(height: 8),
      OutlinedTextField(
        controller: TextEditingController(text: state.tunerCount.toString())
          ..selection = TextSelection.collapsed(offset: state.tunerCount.toString().length),
        label: context.localized.concurrentStreams,
        placeHolder: context.localized.concurrentStreamsHint,
        keyboardType: TextInputType.number,
        onChanged: notifier.updateTunerCount,
      ),
      const SizedBox(height: 8),
      SwitchListTile(
        title: Text(context.localized.importFavoritesOnly),
        value: state.importFavoritesOnly,
        onChanged: notifier.updateImportFavoritesOnly,
      ),
      SwitchListTile(
        title: Text(context.localized.allowHWTranscoding),
        value: state.allowHWTranscoding,
        onChanged: notifier.updateAllowHWTranscoding,
      ),
    ];
  }
}
