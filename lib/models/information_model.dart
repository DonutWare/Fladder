// ignore_for_file: constant_identifier_names

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/util/size_formatting.dart';

class InformationModel {
  final Map<String, dynamic> baseInformation;
  final List<Map<String, dynamic>> videoStreams;
  final List<Map<String, dynamic>> audioStreams;
  final List<Map<String, dynamic>> subStreams;
  InformationModel({
    required this.baseInformation,
    required this.videoStreams,
    required this.audioStreams,
    required this.subStreams,
  });

  static InformationModel? fromResponse(BaseItemDto? item) {
    if (item == null) return null;
    var videoStreams = item.mediaStreams?.where((element) => element.type == MediaStreamType.video).toList() ?? [];
    var audioStreams = item.mediaStreams?.where((element) => element.type == MediaStreamType.audio).toList() ?? [];
    var subStreams = item.mediaStreams?.where((element) => element.type == MediaStreamType.subtitle).toList() ?? [];
    return InformationModel(
      baseInformation: {
        "Title": item.name,
        "Container": item.container,
        "Path": item.path,
        "Size": item.mediaSources?.firstOrNull?.size.byteFormat,
      },
      videoStreams: videoStreams
          .map(
            (e) => {
              "Title": e.displayTitle,
              "Codec": e.codec,
              "Profile": e.profile,
              "Level": e.level,
              "Resolution": "${e.width}x${e.height}",
              "Aspect Ration": e.aspectRatio,
              "Interlaced": e.isInterlaced,
              "FrameRate": e.realFrameRate,
              "Bitrate": e.bitRate! <= 10000000
                  ? "${(e.bitRate! / 1000).round()} kbps"
                  : "${(e.bitRate! / 1000000).toStringAsFixed(1)} Mbps",
              "Bit depth": e.bitDepth,
              "Video range": e.videoRange,
              "Video range type": e.videoRangeType,
              "Ref frames": e.refFrames,
            },
          )
          .toList(),
      audioStreams: audioStreams
          .map(
            (e) => {
              "Title": e.displayTitle,
              "Language": e.language,
              "Codec": e.codec,
              "Layout": e.channelLayout,
              "Bitrate": "${(e.bitRate! / 1000).round()} kbps",
              "Sample Rate": "${e.sampleRate} Hz",
              "Default": e.isDefault,
              "Forced": e.isForced,
              "External": e.isExternal,
            },
          )
          .toList(),
      subStreams: subStreams
          .map(
            (e) => {
              "Title": e.displayTitle,
              "Language": e.language,
              "Codec": e.codec,
              "Profile": e.profile,
              "Default": e.isDefault,
              "Forced": e.isForced,
              "External": e.isExternal,
            },
          )
          .toList(),
    );
  }

  InformationModel copyWith({
    Map<String, dynamic>? baseInformation,
    List<Map<String, dynamic>>? videoStreams,
    List<Map<String, dynamic>>? audioStreams,
    List<Map<String, dynamic>>? subStreams,
  }) {
    return InformationModel(
      baseInformation: baseInformation ?? this.baseInformation,
      videoStreams: videoStreams ?? this.videoStreams,
      audioStreams: audioStreams ?? this.audioStreams,
      subStreams: subStreams ?? this.subStreams,
    );
  }

  static String mapToString(Map<String, dynamic> map) {
    return map.entries.map((e) => "${e.key}: ${e.value}").join("\n");
  }

  static String streamsToString(List<Map<String, dynamic>> streams) {
    return streams.map((e) => mapToString(e)).join("\n");
  }

  @override
  String toString() => "${mapToString(baseInformation)}\n\n"
      "${streamsToString(videoStreams)}\n\n"
      "${streamsToString(audioStreams)}\n\n"
      "${streamsToString(subStreams)}\n\n";
}
