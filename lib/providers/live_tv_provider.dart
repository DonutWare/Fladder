import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/models/live_tv_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'live_tv_provider.g.dart';

@riverpod
class LiveTv extends _$LiveTv {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  LiveTvModel build() {
    final now = DateTime.now();
    final minutesSinceMidnight = now.hour * 60 + now.minute;
    final roundedTo15 = (minutesSinceMidnight ~/ 15) * 15;
    final startDate = DateTime(now.year, now.month, now.day).add(Duration(minutes: roundedTo15 - 15));
    final model = LiveTvModel(
      startDate: startDate,
      endDate: startDate.add(const Duration(hours: 16)),
    );
    Future.microtask(() => fetchDashboard());
    return model;
  }

  Future<void> fetchDashboard() async {
    final channelsResponse = await api.liveTvChannelsGet();
    final channels = channelsResponse.body?.items?.map((e) => ChannelModel.fromBaseDto(e, ref)).toList() ?? [];

    final now = DateTime.now();
    final minutesSinceMidnight = now.hour * 60 + now.minute;
    final roundedTo15 = (minutesSinceMidnight ~/ 15) * 15;
    final startDate = DateTime(now.year, now.month, now.day).add(Duration(minutes: roundedTo15 - 15));
    final endDate = startDate.add(const Duration(hours: 16));

    state = state.copyWith(
      channels: channels,
      loadedChannelIds: {},
      loadingChannelIds: {},
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<void> fetchPrograms(String channelId) async {
    if (state.loadedChannelIds.contains(channelId) || state.loadingChannelIds.contains(channelId)) return;
    final newLoading = {...state.loadingChannelIds}..add(channelId);
    state = state.copyWith(loadingChannelIds: newLoading);

    final programsResponse = await api.liveTvChannelProgramms(
      channelIds: [channelId],
      maxStartDate: state.endDate.add(const Duration(hours: 2)).toUtc(),
      minEndDate: state.startDate.toUtc(),
    );

    final programs = programsResponse.body?.items?.map((e) => ChannelProgram.fromBaseDto(e, ref)).toList() ?? [];

    final updatedChannels = state.channels.map((c) {
      if (c.id == channelId) {
        return c.copyWithTwo(programs: programs);
      }
      return c;
    }).toList();

    final newLoaded = {...state.loadedChannelIds}..add(channelId);
    final newLoadingAfter = {...state.loadingChannelIds}..remove(channelId);

    state = state.copyWith(
      channels: updatedChannels,
      loadedChannelIds: newLoaded,
      loadingChannelIds: newLoadingAfter,
    );
  }
}
