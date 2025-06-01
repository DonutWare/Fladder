import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/update_checker.dart';

part 'update_provider.freezed.dart';
part 'update_provider.g.dart';

Set<TargetPlatform> get _directUpdatePlatforms => {
      TargetPlatform.linux,
      TargetPlatform.macOS,
      TargetPlatform.windows,
    };

final hasNewUpdateProvider = Provider<bool>((ref) {
  //Disable update notification for platforms that are updated outside of Github.
  if (!_directUpdatePlatforms.contains(defaultTargetPlatform)) {
    return false;
  }
  return ref.watch(clientSettingsProvider.select((value) => value.lastViewedUpdate)) !=
      ref.watch(updateProvider.select((value) => value.latestRelease?.version));
});

@Riverpod(keepAlive: true)
class Update extends _$Update {
  final updateChecker = UpdateChecker();

  Timer? _timer;

  @override
  UpdatesModel build() {
    final checkForUpdates = ref.watch(clientSettingsProvider.select((value) => value.checkForUpdates));

    if (!checkForUpdates) {
      _timer?.cancel();
      return UpdatesModel();
    }
    ref.onDispose(() {
      _timer?.cancel();
    });

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(minutes: 30), (timer) {
      _fetchLatest();
    });

    _fetchLatest();

    return UpdatesModel();
  }

  Future<List<ReleaseInfo>> _fetchLatest() async {
    final latest = await updateChecker.fetchRecentReleases();
    state = state.copyWith(
      lastRelease: latest,
    );
    return latest;
  }
}

@Freezed(toJson: false, fromJson: false)
class UpdatesModel with _$UpdatesModel {
  const UpdatesModel._();

  factory UpdatesModel({
    @Default([]) List<ReleaseInfo> lastRelease,
  }) = _UpdatesModel;

  ReleaseInfo? get latestRelease => lastRelease.firstWhereOrNull((value) => value.isNewerThanCurrent);
}
