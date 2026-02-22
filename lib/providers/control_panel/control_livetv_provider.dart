import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/api_result.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_livetv_provider.freezed.dart';
part 'control_livetv_provider.g.dart';

@riverpod
class ControlLiveTv extends _$ControlLiveTv {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  ControlLiveTvModel build() {
    return ControlLiveTvModel();
  }

  Future<void> loadConfiguration() async {
    try {
      final response = await api.getLiveTvConfiguration();
      state = state.copyWith(
        liveTvOptions: response.body,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResult<TunerHostInfo>> addTunerHost(TunerHostInfo tunerHost) async {
    return api.addTunerHost(tunerHost).apiResult;
  }

  Future<ApiResult<TunerHostInfo>> updateTunerHost(TunerHostInfo oldTunerHost, TunerHostInfo newTunerHost) async {
    return api.addTunerHost(newTunerHost.copyWith(id: oldTunerHost.id)).apiResult;
  }

  Future<ApiResult<dynamic>> deleteTunerHost(String id) async {
    return api.deleteTunerHost(id).apiResult;
  }

  Future<ApiResult<ListingsProviderInfo>> addListingProvider(ListingsProviderInfo provider) async {
    return api.addListingProvider(provider).apiResult;
  }

  Future<ApiResult<ListingsProviderInfo>> updateListingProvider(
      ListingsProviderInfo oldProvider, ListingsProviderInfo newProvider) async {
    return api.addListingProvider(newProvider.copyWith(id: oldProvider.id)).apiResult;
  }

  Future<ApiResult<dynamic>> deleteListingProvider(String id) async {
    return api.deleteListingProvider(id).apiResult;
  }
}

@Freezed(copyWith: true)
abstract class ControlLiveTvModel with _$ControlLiveTvModel {
  factory ControlLiveTvModel({
    LiveTvOptions? liveTvOptions,
  }) = _ControlLiveTvModel;
}
