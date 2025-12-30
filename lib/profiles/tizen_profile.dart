import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

/// Device profile for Tizen TV devices
/// 
/// TV does not support DTS and only most TrueHD
const DeviceProfile tizenProfile = DeviceProfile(
  maxStreamingBitrate: 120000000,
  maxStaticBitrate: 120000000,
  musicStreamingTranscodingBitrate: 384000,
  directPlayProfiles: [
    // Video: Allow any container with H.264 and supported audio (excluding DTS and most TrueHD (maybe need some system to try and then fall back))
    // Supports multiple audio channels including Dolby 5.1 and Atmos
    DirectPlayProfile(
      type: DlnaProfileType.video,
      videoCodec: 'h264,hevc,vp8,vp9,av1',
      audioCodec: 'aac,mp3,flac,wav,vorbis,opus,eac3,ac3',
    ),
    // Audio only
    DirectPlayProfile(container: 'mp3', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'aac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'm4a', audioCodec: 'aac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'm4b', audioCodec: 'aac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'flac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'wav', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'ogg', type: DlnaProfileType.audio),
  ],
  /// Transcoding Profiles
  transcodingProfiles: [
    // Video transcoding with E-AC-3 audio
    TranscodingProfile(
      type: DlnaProfileType.video,
      protocol: MediaStreamProtocol.hls,
      container: 'ts',
      videoCodec: 'h264',
      audioCodec: 'eac3,ac3,aac', // Transcode TrueHD/DTS to E-AC-3
    ),
    // Optional: Audio-only transcoding
    TranscodingProfile(
      type: DlnaProfileType.audio,
      protocol: MediaStreamProtocol.http,
      container: 'mp4',
      audioCodec: 'aac,eac3,ac3',
    ),
  ],
  containerProfiles: [],
  subtitleProfiles:  [
      SubtitleProfile(format: 'vtt', method: SubtitleDeliveryMethod.$external),
      SubtitleProfile(format: 'ass', method: SubtitleDeliveryMethod.$external),
      SubtitleProfile(format: 'ssa', method: SubtitleDeliveryMethod.$external),
      SubtitleProfile(format: 'pgssub', method: SubtitleDeliveryMethod.$external),
    ],
);
