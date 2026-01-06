import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

/// Tizen TV device profile
/// - TV supports H.264, HEVC, VP9, AV1 video
/// - TV supports AAC, MP3, FLAC, WAV, Vorbis, Opus, E-AC-3, AC-3 audio
/// - TV does NOT support DTS or most TrueHD
/// - Audio-only transcoding will handle unsupported audio
const DeviceProfile tizenProfile = DeviceProfile(
  maxStreamingBitrate: 120000000,
  maxStaticBitrate: 120000000,
  musicStreamingTranscodingBitrate: 384000,

  // ------------------------
  // Direct Play Profiles
  // ------------------------
  directPlayProfiles: [
    // Video: allow only codecs Tizen supports
    DirectPlayProfile(
      type: DlnaProfileType.video,
      videoCodec: 'h264,hevc,vp8,vp9,av1',
      audioCodec: 'aac,mp3,flac,wav,vorbis,opus,eac3,ac3', // exclude dts/truehd
    ),
    // Audio-only
    DirectPlayProfile(container: 'mp3', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'aac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'm4a', audioCodec: 'aac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'm4b', audioCodec: 'aac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'flac', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'wav', type: DlnaProfileType.audio),
    DirectPlayProfile(container: 'ogg', type: DlnaProfileType.audio),
  ],

  // ------------------------
  // Transcoding Profiles
  // ------------------------
  transcodingProfiles: [
    // Video copy + audio transcode for unsupported audio (e.g., DTS/TrueHD)
    TranscodingProfile(
      type: DlnaProfileType.video,
      protocol: MediaStreamProtocol.hls,
      container: 'ts',
      videoCodec: 'copy',           // copy video, no transcode
      audioCodec: 'eac3,ac3,aac',   // transcode unsupported audio
      context: EncodingContext.streaming,
      maxAudioChannels: '6',        // support up to 5.1
    ),
    // Audio-only transcoding for playback
    TranscodingProfile(
      type: DlnaProfileType.audio,
      protocol: MediaStreamProtocol.http,
      container: 'mp4',
      audioCodec: 'aac,eac3,ac3',
      context: EncodingContext.streaming,
      maxAudioChannels: '6',
    ),
  ],

  containerProfiles: [],

  // ------------------------
  // Codec Profiles
  // ------------------------
  codecProfiles: [
    // Video codec profiles: allow direct play if Tizen supports it
    CodecProfile(
      type: CodecType.video,
      codec: 'h264',
      conditions: [
        ProfileCondition(
          condition: ProfileConditionType.notequals,
          property: ProfileConditionValue.isanamorphic,
          $Value: 'true',
        ),
        ProfileCondition(
          condition: ProfileConditionType.equalsany,
          property: ProfileConditionValue.videorangetype,
          $Value: 'SDR',
        ),
        ProfileCondition(
          condition: ProfileConditionType.lessthanequal,
          property: ProfileConditionValue.videolevel,
          $Value: '52',
        ),
        ProfileCondition(
          condition: ProfileConditionType.notequals,
          property: ProfileConditionValue.isinterlaced,
          $Value: 'true',
        ),
      ],
    ),
    CodecProfile(
      type: CodecType.video,
      codec: 'hevc',
      conditions: [
        ProfileCondition(
          condition: ProfileConditionType.notequals,
          property: ProfileConditionValue.isanamorphic,
          $Value: 'true',
        ),
        ProfileCondition(
          condition: ProfileConditionType.equalsany,
          property: ProfileConditionValue.videoprofile,
          $Value: 'main',
        ),
        ProfileCondition(
          condition: ProfileConditionType.equalsany,
          property: ProfileConditionValue.videorangetype,
          $Value: 'SDR|HDR10|HLG',
        ),
        ProfileCondition(
          condition: ProfileConditionType.lessthanequal,
          property: ProfileConditionValue.videolevel,
          $Value: '120',
        ),
        ProfileCondition(
          condition: ProfileConditionType.notequals,
          property: ProfileConditionValue.isinterlaced,
          $Value: 'true',
        ),
      ],
    ),
    CodecProfile(
      type: CodecType.video,
      codec: 'vp9',
      conditions: [
        ProfileCondition(
          condition: ProfileConditionType.equalsany,
          property: ProfileConditionValue.videorangetype,
          $Value: 'SDR|HDR10|HLG',
        ),
      ],
    ),
    CodecProfile(
      type: CodecType.video,
      codec: 'av1',
      conditions: [
        ProfileCondition(
          condition: ProfileConditionType.notequals,
          property: ProfileConditionValue.isanamorphic,
          $Value: 'true',
        ),
        ProfileCondition(
          condition: ProfileConditionType.equalsany,
          property: ProfileConditionValue.videoprofile,
          $Value: 'main',
        ),
        ProfileCondition(
          condition: ProfileConditionType.equalsany,
          property: ProfileConditionValue.videorangetype,
          $Value: 'SDR|HDR10|HLG',
        ),
        ProfileCondition(
          condition: ProfileConditionType.lessthanequal,
          property: ProfileConditionValue.videolevel,
          $Value: '19',
        ),
      ],
    ),

    // Audio codec profiles: allow direct play for supported audio
    CodecProfile(
      type: CodecType.videoaudio,
      codec: 'aac',
      conditions: [
        ProfileCondition(
          condition: ProfileConditionType.equals,
          property: ProfileConditionValue.issecondaryaudio,
          $Value: 'false',
        ),
      ],
    ),
    CodecProfile(
      type: CodecType.videoaudio,
      codec: 'ac3',
    ),
    CodecProfile(
      type: CodecType.videoaudio,
      codec: 'eac3',
    ),
    CodecProfile(
      type: CodecType.videoaudio,
      codec: 'flac',
    ),
    CodecProfile(
      type: CodecType.videoaudio,
      codec: 'mp3',
    ),
  ],

  // ------------------------
  // Subtitles
  // ------------------------
  subtitleProfiles: [
    SubtitleProfile(format: 'vtt', method: SubtitleDeliveryMethod.$external),
    SubtitleProfile(format: 'ass', method: SubtitleDeliveryMethod.$external),
    SubtitleProfile(format: 'ssa', method: SubtitleDeliveryMethod.$external),
    SubtitleProfile(format: 'pgssub', method: SubtitleDeliveryMethod.$external),
  ],
);
