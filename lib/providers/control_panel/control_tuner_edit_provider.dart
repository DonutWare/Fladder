import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_tuner_edit_provider.freezed.dart';
part 'control_tuner_edit_provider.g.dart';

enum TunerType {
  m3u('m3u'),
  hdhomerun('hdhomerun'),
  satip('satip');

  final String value;
  const TunerType(this.value);

  String get displayName => value.toUpperCase();

  static TunerType fromString(String? value) {
    return TunerType.values.firstWhere(
      (type) => type.value == value?.toLowerCase(),
      orElse: () => TunerType.m3u,
    );
  }
}

enum EPGProviderType {
  xmltv('xmltv'),
  schedulesDirect('SchedulesDirect');

  final String value;
  const EPGProviderType(this.value);

  static EPGProviderType fromString(String? value) {
    return EPGProviderType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => EPGProviderType.xmltv,
    );
  }
}

@riverpod
class ControlTunerEdit extends _$ControlTunerEdit {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  ControlTunerEditModel build(TunerHostInfo? initialTuner) {
    return ControlTunerEditModel(
      url: initialTuner?.url ?? '',
      friendlyName: initialTuner?.friendlyName ?? '',
      userAgent: initialTuner?.userAgent ?? '',
      tunerCount: initialTuner?.tunerCount ?? 0,
      fallbackBitrateMbps: initialTuner?.fallbackMaxStreamingBitrate != null
          ? (initialTuner!.fallbackMaxStreamingBitrate! / 1000000).round()
          : 30,
      selectedType: TunerType.fromString(initialTuner?.type),
      allowFmp4Container: initialTuner?.allowFmp4TranscodingContainer ?? false,
      allowStreamSharing: initialTuner?.allowStreamSharing ?? true,
      enableStreamLooping: initialTuner?.enableStreamLooping ?? false,
      ignoreDts: initialTuner?.ignoreDts ?? false,
      readAtNativeFramerate: initialTuner?.readAtNativeFramerate ?? false,
      importFavoritesOnly: initialTuner?.importFavoritesOnly ?? false,
      allowHWTranscoding: initialTuner?.allowHWTranscoding ?? false,
      isEditMode: initialTuner != null,
      tunerId: initialTuner?.id,
    );
  }

  void updateUrl(String value) {
    state = state.copyWith(url: value);
  }

  void updateFriendlyName(String value) {
    state = state.copyWith(friendlyName: value);
  }

  void updateUserAgent(String value) {
    state = state.copyWith(userAgent: value);
  }

  void updateTunerCount(String value) {
    final count = int.tryParse(value) ?? 0;
    state = state.copyWith(tunerCount: count);
  }

  void updateFallbackBitrate(String value) {
    final bitrate = int.tryParse(value) ?? 30;
    state = state.copyWith(fallbackBitrateMbps: bitrate);
  }

  void updateType(TunerType type) {
    state = state.copyWith(selectedType: type);
  }

  void updateAllowFmp4Container(bool value) {
    state = state.copyWith(allowFmp4Container: value);
  }

  void updateAllowStreamSharing(bool value) {
    state = state.copyWith(allowStreamSharing: value);
  }

  void updateEnableStreamLooping(bool value) {
    state = state.copyWith(enableStreamLooping: value);
  }

  void updateIgnoreDts(bool value) {
    state = state.copyWith(ignoreDts: value);
  }

  void updateReadAtNativeFramerate(bool value) {
    state = state.copyWith(readAtNativeFramerate: value);
  }

  void updateImportFavoritesOnly(bool value) {
    state = state.copyWith(importFavoritesOnly: value);
  }

  void updateAllowHWTranscoding(bool value) {
    state = state.copyWith(allowHWTranscoding: value);
  }

  Future<List<TunerHostInfo>> discoverDevices({bool newDevicesOnly = true}) async {
    state = state.copyWith(isDiscovering: true, discoveryError: null);
    try {
      final result = await api.discoverTuners(newDevicesOnly: newDevicesOnly);
      state = state.copyWith(isDiscovering: false);
      return result.body ?? [];
    } catch (e) {
      state = state.copyWith(
        isDiscovering: false,
        discoveryError: e.toString(),
      );
      rethrow;
    }
  }

  void addDiscoveredDevice(TunerHostInfo device) {
    state = state.copyWith(
      url: device.url ?? state.url,
      friendlyName: device.friendlyName ?? state.friendlyName,
      selectedType: state.isEditMode ? state.selectedType : TunerType.fromString(device.type),
      tunerCount: device.tunerCount ?? state.tunerCount,
    );
  }

  TunerHostInfo buildTunerHostInfo() {
    final bitrateInBps = state.fallbackBitrateMbps * 1000000;
    final type = state.selectedType;

    return TunerHostInfo(
      id: state.tunerId,
      url: state.url.isEmpty ? null : state.url,
      type: type.value,
      friendlyName: state.friendlyName.isEmpty ? null : state.friendlyName,
      userAgent: (type == TunerType.m3u && state.userAgent.isNotEmpty) ? state.userAgent : null,
      tunerCount: state.tunerCount,
      fallbackMaxStreamingBitrate: bitrateInBps,
      allowFmp4TranscodingContainer: type == TunerType.m3u ? state.allowFmp4Container : null,
      allowStreamSharing: type == TunerType.m3u ? state.allowStreamSharing : null,
      enableStreamLooping: type == TunerType.m3u ? state.enableStreamLooping : null,
      ignoreDts: type == TunerType.m3u ? state.ignoreDts : null,
      readAtNativeFramerate: type == TunerType.m3u ? state.readAtNativeFramerate : null,
      importFavoritesOnly: type == TunerType.hdhomerun ? state.importFavoritesOnly : null,
      allowHWTranscoding: type == TunerType.hdhomerun ? state.allowHWTranscoding : null,
    );
  }
}

@Freezed(copyWith: true)
abstract class ControlTunerEditModel with _$ControlTunerEditModel {
  factory ControlTunerEditModel({
    @Default('') String url,
    @Default('') String friendlyName,
    @Default('') String userAgent,
    @Default(0) int tunerCount,
    @Default(30) int fallbackBitrateMbps,
    @Default(TunerType.m3u) TunerType selectedType,
    @Default(false) bool allowFmp4Container,
    @Default(true) bool allowStreamSharing,
    @Default(false) bool enableStreamLooping,
    @Default(false) bool ignoreDts,
    @Default(false) bool readAtNativeFramerate,
    @Default(false) bool importFavoritesOnly,
    @Default(false) bool allowHWTranscoding,
    @Default(false) bool isEditMode,
    @Default(false) bool isDiscovering,
    String? tunerId,
    String? discoveryError,
  }) = _ControlTunerEditModel;
}
