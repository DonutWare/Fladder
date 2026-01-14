import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/models/items/channel_model.dart';

part 'live_tv_model.freezed.dart';

@Freezed(copyWith: true)
abstract class LiveTvModel with _$LiveTvModel {
  factory LiveTvModel({
    required DateTime startDate,
    required DateTime endDate,
    @Default([]) List<ChannelModel> channels,
    @Default({}) Set<String> loadedChannelIds,
    @Default({}) Set<String> loadingChannelIds,
  }) = _LiveTvModel;
}
