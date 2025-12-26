import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

/// Device profile for Tizen TV devices
/// 
/// Based on the default profile but with DTS audio codec excluded
/// to force transcoding of DTS audio to AAC
const DeviceProfile tizenProfile = DeviceProfile(
  maxStreamingBitrate: 120000000,
  maxStaticBitrate: 120000000,
  musicStreamingTranscodingBitrate: 384000,
  directPlayProfiles: [
    // Video: Allow any container with H.264 and supported audio (excluding DTS)
    // Supports multiple audio channels including Dolby 5.1 and Atmos
    DirectPlayProfile(
      type: DlnaProfileType.video,
      videoCodec: 'h264,hevc,vp8,vp9,av1',
      audioCodec: 'aac,mp3,flac,wav,vorbis,opus,eac3,ac3,truehd', 
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
  transcodingProfiles: [
    TranscodingProfile(
      audioCodec: 'aac,mp3,mp2',
      container: 'ts',
      protocol: MediaStreamProtocol.hls,
      type: DlnaProfileType.video,
      videoCodec: 'h264',
    ),
  ],
  containerProfiles: [],
  subtitleProfiles: [
    SubtitleProfile(format: 'vtt', method: SubtitleDeliveryMethod.embed),
    SubtitleProfile(format: 'srt', method: SubtitleDeliveryMethod.embed),
  ],
);
