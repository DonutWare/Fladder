import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

part 'control_device_discovery_provider.freezed.dart';
part 'control_device_discovery_provider.g.dart';

@Freezed(copyWith: true)
abstract class ControlDeviceDiscoveryModel with _$ControlDeviceDiscoveryModel {
  const factory ControlDeviceDiscoveryModel({
    @Default(true) bool isLoading,
    @Default([]) List<TunerHostInfo> devices,
  }) = _ControlDeviceDiscoveryModel;
}

@riverpod
class ControlDeviceDiscovery extends _$ControlDeviceDiscovery {
  @override
  ControlDeviceDiscoveryModel build() => const ControlDeviceDiscoveryModel();

  Future<void> discoverDevices(Future<List<TunerHostInfo>> Function() onDiscover) async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await onDiscover();
      state = state.copyWith(
        isLoading: false,
        devices: result,
      );
    } catch (e, stackTrace) {
      log('Failed to discover tuner devices', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        devices: [],
      );
    }
  }
}
