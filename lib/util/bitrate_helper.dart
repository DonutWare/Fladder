import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

enum Bitrate {
  original(null),
  auto(0),
  b120Mbps(120000000),
  b80Mbps(80000000),
  b60Mbps(60000000),
  b40Mbps(40000000),
  b20Mbps(20000000),
  b15Mbps(15000000),
  b10Mbps(10000000),
  b8Mbps(8000000),
  b6Mbps(6000000),
  b4Mbps(4000000),
  b3Mbps(3000000),
  b1_5Mbps(1500000),
  b720Kbps(720000),
  b420Kbps(420000);

  final int? bitRate;

  const Bitrate(this.bitRate);

  int get calculatedBitRate => bitRate ?? -1;

  String label(BuildContext context) => switch (this) {
        Bitrate.original => context.localized.qualityOptionsOriginal,
        Bitrate.auto => context.localized.qualityOptionsAuto,
        _ => name.toString().replaceAll('b', '').replaceAll('_', '.').toUpperCaseSplit()
      };
}

class VideoQualitySettings {
  final Bitrate? maxBitRate;
  final int videoBitRate;
  final String? videoCodec;

  VideoQualitySettings({
    required this.maxBitRate,
    required this.videoBitRate,
    required this.videoCodec,
  });
}

Map<Bitrate, bool> getVideoQualityOptions(VideoQualitySettings options) {
  final maxStreamingBitrate = options.maxBitRate;
  final videoBitRate = options.videoBitRate;
  final videoCodec = options.videoCodec;
  double referenceBitRate = videoBitRate.toDouble();

  final bitRateValues = Bitrate.values.where((value) => value.calculatedBitRate > 0).toSet();

  final qualityOptions = <Bitrate>{Bitrate.original, Bitrate.auto};

  if (videoBitRate > 0 && videoBitRate < bitRateValues.first.calculatedBitRate) {
    if (videoCodec != null && ['hevc', 'av1', 'vp9'].contains(videoCodec) && referenceBitRate <= 20000000) {
      referenceBitRate *= 1.5;
    }

    final sourceOption = bitRateValues.where((value) => value.calculatedBitRate > referenceBitRate).lastOrNull;

    if (sourceOption != null) {
      qualityOptions.add(sourceOption);
    }
  }

  qualityOptions
      .addAll(bitRateValues.where((value) => videoBitRate <= 0 || value.calculatedBitRate <= referenceBitRate));

  Bitrate? selectedQualityOption;
  if (maxStreamingBitrate != null && maxStreamingBitrate != Bitrate.original) {
    selectedQualityOption = qualityOptions
        .where(
            (value) => value.calculatedBitRate > 0 && value.calculatedBitRate <= maxStreamingBitrate.calculatedBitRate)
        .firstOrNull;
  }

  return qualityOptions.toList().asMap().map(
        (_, bitrate) => MapEntry(
          bitrate,
          bitrate == maxStreamingBitrate || bitrate == selectedQualityOption,
        ),
      );
}
