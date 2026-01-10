import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/live_tv_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'live_tv_provider.g.dart';

@riverpod
class LiveTv extends _$LiveTv {
  JellyService get api => ref.read(jellyApiProvider);
  @override
  LiveTvModel build() {
    return LiveTvModel();
  }

  Future<void> fetchDashboard() async {}
}
