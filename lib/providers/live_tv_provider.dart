import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/models/live_tv_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'live_tv_provider.g.dart';

@Riverpod(keepAlive: true)
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

  Future<LiveTvModel> fetchDashboard() async {
    final channelsResponse = await api.liveTvChannelsGet();
    final channels = channelsResponse.body?.items?.map((e) => ChannelModel.fromBaseDto(e, ref)).toList() ?? [];

    final now = DateTime.now();
    final minutesSinceMidnight = now.hour * 60 + now.minute;
    final roundedTo15 = (minutesSinceMidnight ~/ 15) * 15;
    final startDate = DateTime(now.year, now.month, now.day).add(Duration(minutes: roundedTo15 - 15));
    final endDate = startDate.add(const Duration(hours: 16));
    return state = state.copyWith(
      channels: channels,
      loadedChannelIds: {},
      loadingChannelIds: {},
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<List<ChannelProgram>> fetchPrograms(ChannelModel channelProgram) async {
    if (state.channels.isEmpty) {
      await fetchDashboard();
    }

    ChannelModel? existingChannel;
    for (final c in state.channels) {
      if (c.id == channelProgram.id) {
        existingChannel = c;
        break;
      }
    }

    if (state.loadedChannelIds.contains(channelProgram.id)) {
      return existingChannel?.programs ?? <ChannelProgram>[];
    }

    if (state.loadingChannelIds.contains(channelProgram.id)) {
      return existingChannel?.programs ?? <ChannelProgram>[];
    }
    final newLoading = {...state.loadingChannelIds}..add(channelProgram.id);
    state = state.copyWith(loadingChannelIds: newLoading);

    final programs = await fetchProgramsForChannel(channelProgram);

    final updatedChannels = state.channels.map((c) {
      if (c.id == channelProgram.id) {
        return c.copyChannelWith(programs: programs);
      }
      return c;
    }).toList();

    final newLoaded = {...state.loadedChannelIds}..add(channelProgram.id);
    final newLoadingAfter = {...state.loadingChannelIds}..remove(channelProgram.id);

    state = state.copyWith(
      channels: updatedChannels,
      loadedChannelIds: newLoaded,
      loadingChannelIds: newLoadingAfter,
    );
    return programs;
  }

  Future<List<ChannelProgram>> fetchProgramsForChannel(ChannelModel channelModel) async {
    final programsResponse = await api.liveTvChannelPrograms(
      channelIds: [channelModel.id],
      maxStartDate: channelModel.endDate.add(const Duration(hours: 2)).toUtc(),
      minEndDate: channelModel.startDate.toUtc(),
    );

    final programs = programsResponse.body?.items?.map((e) => ChannelProgram.fromBaseDto(e, ref)).toList() ?? [];

    return programs;
  }
}
