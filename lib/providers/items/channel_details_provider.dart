import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'channel_details_provider.g.dart';

@riverpod
class ChannelDetails extends _$ChannelDetails {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  ChannelModel? build(String id) {
    return null;
  }

  Future<void> fetchDetails(String id) async {
    final channelResponse = await api.usersUserIdItemsItemIdGet(itemId: id);
    if (channelResponse.body == null || channelResponse.body is! ChannelModel) return;
    final channelModel = channelResponse.bodyOrThrow as ChannelModel;
    state = channelModel;

    final programsResponse = await api.liveTvChannelProgramms(
      channelIds: [state?.id ?? id],
      minEndDate: DateTime.now(),
    );

    state = state?.copyWithTwo(
      programs: programsResponse.body?.items?.map((e) => ChannelProgram.fromBaseDto(e, ref)).toList() ?? [],
    );
  }
}
