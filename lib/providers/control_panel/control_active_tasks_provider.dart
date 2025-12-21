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

  Future<void> startTask({required String taskId}) async => api.startTask(taskId);
  Future<void> stopTask({required String taskId}) async => api.stopActiveTask(taskId);

  Future<void> fetchActiveTasks() async {
    final activeTasks = (await api.getActiveTasks()).body;
    state = activeTasks ?? [];
  }

  Future<bool> updateTaskTriggers({required String taskId, required List<TaskTriggerInfo> triggers}) async {
    var response = (await api.updateTaskTriggers(taskId, triggers: triggers));
    if (response.isSuccessful) {
      await fetchActiveTasks();
    }
    return response.isSuccessful;
  }
}
