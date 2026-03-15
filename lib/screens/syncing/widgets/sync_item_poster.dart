import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:path/path.dart' as path;

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/localization_helper.dart';

class SyncItemPoster extends ConsumerWidget {
  final SyncedItem item;
  final Widget child;
  const SyncItemPoster({
    required this.item,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!item.isTranscoded) return child;
    final statusColor = item.status.color(context);
    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(225),
              borderRadius: FladderTheme.smallShape.borderRadius,
            ),
            child: IconButton.outlined(
              icon: Icon(
                IconsaxPlusBold.convert,
                color: statusColor,
              ),
              onPressed: () => _showTranscodeDetails(context, ref, item),
            ),
          ),
        )
      ],
    );
  }
}

Future<void> _showTranscodeDetails(BuildContext context, WidgetRef ref, SyncedItem item) async {
  final itemModel = item.itemModel;
  if (itemModel == null) {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.localized.transcodeInfoTitle),
        content: Text(context.localized.transcodeInfoNoMetadata),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.ok)),
        ],
      ),
    );
    return;
  }

  final streamModel = itemModel.streamModel;
  final videoStream = streamModel?.videoStreams.firstOrNull;
  final audioStream = streamModel?.audioStreams.firstOrNull;

  final container = item.videoFileName != null ? path.extension(item.videoFileName!).replaceFirst('.', '') : null;

  final bitrate = videoStream?.bitRate;
  final videoCodec = videoStream?.codec;
  final audioCodec = audioStream?.codec;
  final resolution = streamModel?.resolutionText ?? context.localized.unknown;

  await showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Row(
        spacing: 16,
        children: [
          const Icon(
            IconsaxPlusBold.convert,
          ),
          Text(context.localized.transcodeDetailsTitle),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (container != null && container.isNotEmpty) Text('${context.localized.containerLabel}: $container'),
          if (videoCodec != null && videoCodec.isNotEmpty) Text('${context.localized.videoCodecLabel}: $videoCodec'),
          if (audioCodec != null && audioCodec.isNotEmpty) Text('${context.localized.audioCodecLabel}: $audioCodec'),
          if (bitrate != null) Text('${context.localized.bitrateLabel}: ${bitrate ~/ 1000} ${context.localized.kbps}'),
          Text(
              '${context.localized.resolutionLabel}: ${resolution.isNotEmpty ? resolution : context.localized.unknown}'),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.ok)),
      ],
    ),
  );
}
