import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';

enum Resolution {
  sd("SD"),
  hd("HD"),
  udh("4K");

  const Resolution(this.value);
  final String value;

  Widget icon(
    BuildContext context,
    Function()? onTap,
  ) {
    return DefaultVideoInformationBox(
      onTap: onTap,
      child: Text(
        value,
      ),
    );
  }

  static Resolution? fromVideoStream(VideoStreamModel? model) {
    if (model == null) return null;
    return Resolution.fromSize(model.width, model.height);
  }

  static Resolution? fromSize(int? width, int? height) {
    if (width == null || height == null) return null;
    if (height <= 1080 && width <= 1920) {
      return Resolution.hd;
    } else if (height <= 2160 && width <= 3840) {
      return Resolution.udh;
    } else {
      return Resolution.sd;
    }
  }
}

enum DisplayProfile {
  sdr("SDR"),
  hdr("HDR"),
  hdr10("HDR10"),
  hdr10Plus("HDR10+"),
  dolbyVision("Dolby Vision"),
  dolbyVisionHdr10("DoVi/HDR10"),
  dolbyVisionHlg("DoVi/Hlg"),
  hlg("HLG");

  const DisplayProfile(this.value);
  final String value;

  Widget icon(
    BuildContext context,
    Function()? onTap,
  ) {
    return DefaultVideoInformationBox(
      onTap: onTap,
      child: Text(
        value,
      ),
    );
  }

  static DisplayProfile? fromStreams(List<MediaStream>? mediaStreams) {
    final videoStream = (mediaStreams?.firstWhereOrNull((element) => element.type == dto.MediaStreamType.video) ??
        mediaStreams?.firstOrNull);
    if (videoStream == null) return null;
    return DisplayProfile.fromVideoStream(VideoStreamModel.fromMediaStream(videoStream));
  }

  static DisplayProfile? fromVideoStreams(List<VideoStreamModel>? mediaStreams) {
    final videoStream = mediaStreams?.firstWhereOrNull((element) => element.isDefault) ?? mediaStreams?.firstOrNull;
    if (videoStream == null) return null;
    return DisplayProfile.fromVideoStream(videoStream);
  }

  static DisplayProfile fromVideoStream(VideoStreamModel stream) {
    return switch (stream.videoRangeType) {
      dto.VideoRangeType.doviwithsdr => DisplayProfile.dolbyVisionHlg,
      dto.VideoRangeType.doviwithhdr10 => DisplayProfile.dolbyVisionHdr10,
      dto.VideoRangeType.dovi => DisplayProfile.dolbyVision,
      dto.VideoRangeType.hlg => DisplayProfile.hlg,
      dto.VideoRangeType.hdr10 => DisplayProfile.hdr10,
      dto.VideoRangeType.doviwithhlg => DisplayProfile.dolbyVisionHlg,
      dto.VideoRangeType.hdr10plus => DisplayProfile.hdr10Plus,
      _ => DisplayProfile.sdr
    };
  }
}

class DefaultVideoInformationBox extends ConsumerWidget {
  final Widget child;
  final Function()? onTap;
  const DefaultVideoInformationBox({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: FlatButton(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Material(
            type: MaterialType.button,
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            color: Colors.transparent,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
