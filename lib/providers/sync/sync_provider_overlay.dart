import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/syncing/transcode_download_model.dart';
import 'package:fladder/providers/sync_provider.dart';

extension SyncOverlayHelpers on SyncNotifier {
  Future<void> writeOverlayFile(
    SyncedItem syncItem,
    TranscodeDownloadModel transcodeModel,
    List<SubStreamModel> subtitles,
  ) async {
    if (!syncItem.dataFile.existsSync()) return;

    if (!transcodeModel.enabled) {
      if (subtitles.isNotEmpty) {
        final originalDto = BaseItemDto.fromJson(jsonDecode(syncItem.dataFile.readAsStringSync()));
        final originalSource = originalDto.mediaSources?.firstOrNull;
        if (originalSource != null) {
          final subStreams = subtitles
              .map((sub) => MediaStream(
                    type: MediaStreamType.subtitle,
                    codec: sub.codec,
                    language: sub.language,
                    title: sub.title,
                    displayTitle: sub.displayTitle,
                    isDefault: sub.isDefault,
                    isExternal: true,
                    index: sub.index,
                    supportsExternalStream: true,
                  ))
              .toList();

          final originalStreams =
              originalSource.mediaStreams?.where((s) => s.type != MediaStreamType.subtitle).toList() ?? [];

          final overlaySource = originalSource.copyWith(
            mediaStreams: [...originalStreams, ...subStreams],
          );

          final overlay = {
            'isTranscoded': false,
            'container': originalDto.container,
            'mediaSources': [overlaySource.toJson()],
          };

          await syncItem.overlayFile.writeAsString(jsonEncode(overlay));
        }
      } else {
        if (syncItem.overlayFile.existsSync()) {
          await syncItem.overlayFile.delete();
        }
      }
      return;
    }

    final originalDto = BaseItemDto.fromJson(jsonDecode(syncItem.dataFile.readAsStringSync()));
    final originalSource = originalDto.mediaSources?.firstOrNull;
    if (originalSource == null) return;

    final videoStreams =
        (originalSource.mediaStreams?.where((s) => s.type == MediaStreamType.video).toList() ?? []).map((stream) {
      final targetHeight = transcodeModel.maxHeight.value;
      final targetWidth = _calculateWidth(stream.width, stream.height, targetHeight);
      final codecName = transcodeModel.videoCodec.name;
      final displayTitle = '${targetHeight}p $codecName SDR';
      return stream.copyWithWrapped(
        codec: Wrapped.value(codecName.toLowerCase()),
        height: Wrapped.value(targetHeight),
        width: Wrapped.value(targetWidth),
        bitRate: Wrapped.value(transcodeModel.maxBitrate.bitRate),
        displayTitle: Wrapped.value(displayTitle),
        videoRange: const Wrapped.value(VideoRange.sdr),
        videoRangeType: const Wrapped.value(VideoRangeType.sdr),
        hdr10PlusPresentFlag: const Wrapped.value(false),
        isAVC: Wrapped.value(transcodeModel.videoCodec == VideoCodec.h264),
        profile: Wrapped.value(_transcodeProfile(transcodeModel.videoCodec)),
      );
    }).toList();

    final audioStreams = originalSource.mediaStreams?.where((s) => s.type == MediaStreamType.audio).map((stream) {
          final codecName = transcodeModel.audioCodec.name;
          return stream.copyWith(
            codec: codecName.toLowerCase(),
            displayTitle: stream.displayTitle?.replaceAll(
                  RegExp(stream.codec ?? '', caseSensitive: false),
                  codecName,
                ) ??
                codecName,
          );
        }).toList() ??
        [];

    final subStreams = subtitles
        .map((sub) => MediaStream(
              type: MediaStreamType.subtitle,
              codec: sub.codec,
              language: sub.language,
              title: sub.title,
              displayTitle: sub.displayTitle,
              isDefault: sub.isDefault,
              isExternal: true,
              index: sub.index,
              supportsExternalStream: true,
            ))
        .toList();

    final overlaySource = originalSource.copyWith(
      container: transcodeModel.container.name,
      bitrate: transcodeModel.maxBitrate.bitRate,
      mediaStreams: [...videoStreams, ...audioStreams, ...subStreams],
    );

    final overlay = {
      'isTranscoded': true,
      'container': transcodeModel.container.name,
      'mediaSources': [overlaySource.toJson()],
    };

    await syncItem.overlayFile.writeAsString(jsonEncode(overlay));
  }

  static int? _calculateWidth(int? originalWidth, int? originalHeight, int targetHeight) {
    if (originalWidth == null || originalHeight == null || originalHeight == 0) return null;
    return ((originalWidth / originalHeight) * targetHeight).round();
  }

  static String _transcodeProfile(VideoCodec codec) => switch (codec) {
        VideoCodec.h264 => 'High',
        VideoCodec.h265 => 'Main',
        VideoCodec.vp9 => 'Profile 0',
        VideoCodec.av1 => 'Main',
      };
}
