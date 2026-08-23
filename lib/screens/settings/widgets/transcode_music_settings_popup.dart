import 'package:flutter/material.dart';

import 'package:fladder/models/syncing/transcode_music_download_model.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

Future<void> showTranscodeMusicSettingsPopup({
  required BuildContext context,
  required TranscodeMusicDownloadModel current,
  required Function(TranscodeMusicDownloadModel value) onChanged,
  Function? onClosed,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TranscodeMusicSettingsPopup(
            current: current,
            onChanged: onChanged,
            onClosed: onClosed,
          ),
        ),
      );
    },
  );
}

class TranscodeMusicSettingsPopup extends StatefulWidget {
  final TranscodeMusicDownloadModel current;
  final Function(TranscodeMusicDownloadModel value) onChanged;
  final Function? onClosed;
  const TranscodeMusicSettingsPopup({
    required this.current,
    required this.onChanged,
    this.onClosed,
    super.key,
  });

  @override
  State<TranscodeMusicSettingsPopup> createState() => _TranscodeMusicSettingsPopupState();
}

class _TranscodeMusicSettingsPopupState extends State<TranscodeMusicSettingsPopup> {
  late TranscodeMusicDownloadModel currentModel = widget.current;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.localized.transcodeInfoTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(),
          SingleChildScrollView(
            child: Column(
              children: [
                SettingsListTile(
                  label: Text(context.localized.enabled),
                  trailing: Switch(
                    value: currentModel.enabled,
                    onChanged: (value) {
                      setState(() {
                        currentModel = currentModel.copyWith(enabled: value);
                      });
                    },
                  ),
                ),
                SettingsListTileEnum(
                  label: Text(context.localized.bitrateLabel),
                  current: currentModel.maxBitrate.label(context),
                  itemBuilder: (context) {
                    return Bitrate.values
                        .where((element) => element != Bitrate.auto)
                        .map((e) => ItemActionButton(
                              label: Text(e.label(context)),
                              action: () {
                                setState(() {
                                  currentModel = currentModel.copyWith(maxBitrate: e);
                                });
                              },
                            ))
                        .toList();
                  },
                ),
                SettingsListTileEnum(
                  label: Text(context.localized.audioCodecLabel),
                  current: currentModel.audioCodec.label,
                  itemBuilder: (context) {
                    return MusicAudioCodec.values
                        .map((e) => ItemActionButton(
                              label: Text(e.label),
                              action: () {
                                setState(() {
                                  currentModel = currentModel.copyWith(audioCodec: e);
                                });
                              },
                            ))
                        .toList();
                  },
                ),
                SettingsListTileEnum(
                  label: Text(context.localized.containerLabel),
                  current: currentModel.container.label,
                  itemBuilder: (context) {
                    return MusicContainer.values
                        .map((e) => ItemActionButton(
                              label: Text(e.label),
                              action: () {
                                setState(() {
                                  currentModel = currentModel.copyWith(container: e);
                                });
                              },
                            ))
                        .toList();
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  if (widget.onClosed != null) {
                    widget.onClosed!();
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  context.localized.cancel,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onChanged(currentModel);
                  Navigator.of(context).pop();
                },
                child: Text(context.localized.set),
              ),
            ],
          )
        ],
      ),
    );
  }
}
