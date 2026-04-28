import 'package:chopper/chopper.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/information_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/api_provider.dart';

class InformationProviderModel {
  final InformationModel? model;
  final bool loading;
  InformationProviderModel({
    this.model,
    this.loading = false,
  });

  InformationProviderModel copyWith({
    InformationModel? model,
    bool? loading,
  }) {
    return InformationProviderModel(
      model: model ?? this.model,
      loading: loading ?? this.loading,
    );
  }
}

final informationProvider =
    StateNotifierProvider.autoDispose.family<InformationNotifier, InformationProviderModel, String>((ref, id) {
  return InformationNotifier(ref);
});

class InformationNotifier extends StateNotifier<InformationProviderModel> {
  InformationNotifier(this.ref) : super(InformationProviderModel());

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response> getItemInformation(ItemBaseModel item) async {
    state = state.copyWith(loading: true);
    final response = await api.usersUserIdItemsItemIdGetBaseItem(itemId: item.id);
    final selectedMediaSourceId = item.streamModel?.currentVersionStream?.id;
    await Future.delayed(const Duration(milliseconds: 250));
    state = state.copyWith(
        loading: false,
        model: InformationModel.fromResponse(response.body, selectedMediaSourceId: selectedMediaSourceId));
    return response;
  }
}
