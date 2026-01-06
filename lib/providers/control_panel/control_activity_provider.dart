import 'package:async/async.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_activity_provider.freezed.dart';
part 'control_activity_provider.g.dart';

@riverpod
class ControlActivity extends _$ControlActivity {
  RestartableTimer? _refreshTimer;

  JellyService get api => ref.read(jellyApiProvider);

  @override
  List<ControlActivityModel> build() {
    if (_refreshTimer == null) {
      _refreshTimer = RestartableTimer(const Duration(seconds: 2), () async {
        await fetchActivity();
        _refreshTimer?.reset();
      });
      fetchActivity();
    }

    ref.onDispose(() {
      _refreshTimer?.cancel();
      _refreshTimer = null;
    });
    return [];
  }

  Future<void> fetchActivity() async {
    final activities = (await api.getActiveSessions()).bodyOrThrow
      ..sort(
        (a, b) => (b.lastActivityDate ?? DateTime.now()).compareTo(a.lastActivityDate ?? DateTime.now()),
      );

    state = await Future.wait(
      activities.map(
        (activity) async {
          final itemModel =
              activity.nowPlayingItem != null ? ItemBaseModel.fromBaseDto(activity.nowPlayingItem!, ref) : null;
          final trickPlayModel =
              activity.nowPlayingItem != null ? (await api.getTrickPlay(item: itemModel, ref: ref))?.body : null;
          return ControlActivityModel(
            user: activity.userId != null
                ? AccountModel(
                    name: activity.userName ?? "--",
                    id: activity.userId ?? "",
                    avatar: ref.read(imageUtilityProvider).getUserImageUrl(activity.userId ?? ""),
                    lastUsed: DateTime.now(),
                    credentials: CredentialsModel.createNewCredentials(),
                  )
                : null,
            deviceName: activity.deviceName,
            client: activity.$Client,
            nowPlayingItem: itemModel,
            applicationVersion: activity.applicationVersion,
            trickPlay: trickPlayModel,
            lastActivityDate: activity.lastActivityDate,
            playState: activity.playState != null
                ? ActivityPlayState(
                    currentPosition: Duration(milliseconds: (activity.playState?.positionTicks ?? 0) ~/ 10000),
                    playMethod: activity.playState?.playMethod?.value ?? "Unknown",
                    isPaused: activity.playState?.isPaused,
                  )
                : null,
          );
        },
      ),
    );
  }
}

@Freezed(copyWith: true)
abstract class ControlActivityModel with _$ControlActivityModel {
  factory ControlActivityModel({
    AccountModel? user,
    String? deviceName,
    String? client,
    String? applicationVersion,
    String? activityType,
    ItemBaseModel? nowPlayingItem,
    TrickPlayModel? trickPlay,
    ActivityPlayState? playState,
    DateTime? lastActivityDate,
  }) = _ControlActivityModel;
}

@Freezed(copyWith: true)
abstract class ActivityPlayState with _$ActivityPlayState {
  factory ActivityPlayState({
    required Duration currentPosition,
    String? playMethod,
    bool? isPaused,
  }) = _ActivityPlayState;
}
