import 'dart:async';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_info_provider.freezed.dart';
part 'session_info_provider.g.dart';

@Riverpod()
class SessionInfo extends _$SessionInfo {
  late final api = ref.read(jellyApiProvider);
  Timer? _timer;

  @override
  SessionInfoModel build() {
    ref.onDispose(() => _timer?.cancel());
    _startTimer();
    return SessionInfoModel();
  }

  void _startTimer() {
    _fetchData();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await _fetchData();
    });
  }

  Future<void> _fetchData() async {
    final deviceId = ref.read(userProvider)?.credentials.deviceId;
    if (deviceId == null) {
      state = SessionInfoModel();
      return;
    }

    final response = await api.sessionsInfo(deviceId);

    final session = response.body?.firstOrNull;

    if (session == null) {
      state = SessionInfoModel();
      return;
    }

    state = SessionInfoModel(
      playbackModel: session.playState?.playMethod?.name,
      transCodeInfo: session.transcodingInfo,
    );
  }
}

@freezed
abstract class SessionInfoModel with _$SessionInfoModel {
  const SessionInfoModel._();

  factory SessionInfoModel({
    String? playbackModel,
    TranscodingInfo? transCodeInfo,
  }) = _SessionInfoModel;

  factory SessionInfoModel.fromJson(Map<String, dynamic> json) => _$SessionInfoModelFromJson(json);
}
