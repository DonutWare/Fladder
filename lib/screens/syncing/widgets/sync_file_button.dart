import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/syncing/transcode_download_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/settings/widgets/transcode_settings_popup.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/icon_button_await.dart';

class SyncFileButton extends ConsumerWidget {
  final SyncedItem syncedItem;
  const SyncFileButton({required this.syncedItem, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcodeEnabled = ref.watch(clientSettingsProvider.select((value) => value.transcodeDownloadModel.enabled));

    return Tooltip(
      message: transcodeEnabled ? context.localized.downloadTranscoded : context.localized.downloadOriginal,
      child: IconButtonAwait(
        onPressed: () async => await ref.read(syncProvider.notifier).syncFile(syncedItem, false),
        onLongPress: () async {
          TranscodeDownloadModel? transcodeModel;
          bool cancelled = true;
          await showTranscodeSettingsPopup(
            context: context,
            current: ref
                .read(clientSettingsProvider.select((value) => value.transcodeDownloadModel.copyWith(enabled: true))),
            onChanged: (value) {
              transcodeModel = value;
              cancelled = false;
            },
            onClosed: () {
              cancelled = true;
            },
          );
          if (cancelled) {
            return;
          }
          await ref.read(syncProvider.notifier).syncFile(syncedItem, false, transcodeModel: transcodeModel);
        },
        icon: Icon(
          transcodeEnabled ? IconsaxPlusLinear.cloud_change : IconsaxPlusLinear.import_3,
        ),
      ),
    );
  }
}
