import 'package:async/async.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_active_tasks_provider.g.dart';

@riverpod
class ControlActiveTasks extends _$ControlActiveTasks {
  JellyService get api => ref.read(jellyApiProvider);

  RestartableTimer? _refreshTimer;

  @override
  List<TaskInfo> build() {
    if (_refreshTimer == null) {
      _refreshTimer = RestartableTimer(const Duration(seconds: 5), () async {
        await fetchActiveTasks();
        _refreshTimer?.reset();
      });
      fetchActiveTasks();
    }

    ref.onDispose(() {
      _refreshTimer?.cancel();
      _refreshTimer = null;
    });
    return [];
  }

  Future<void> fetchActiveTasks() async {
    final activeTasks = (await api.getActiveTasks()).body;
    state = activeTasks ?? [];
  }
}
