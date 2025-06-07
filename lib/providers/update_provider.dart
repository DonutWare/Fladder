import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/update_checker.dart';

part 'update_provider.freezed.dart';
part 'update_provider.g.dart';

final hasNewUpdateProvider = Provider<bool>((ref) {
  final latestRelease = ref.watch(updateProvider).latestRelease;
  final lastViewedVersion = ref.watch(clientSettingsProvider.select((value) => value.lastViewedUpdate));

  final latestVersion = latestRelease?.version;

  if (latestVersion == null || lastViewedVersion == null) {
    return false;
  }

  return latestVersion != lastViewedVersion;
});

@Riverpod(keepAlive: true)
class Update extends _$Update {
  final updateChecker = UpdateChecker();

  Timer? _timer;

  @override
  UpdatesModel build() {
    ref.listen(
        clientSettingsProvider.select((value) => value.checkForUpdates), (previous, next) => toggleUpdateChecker(next));
    final checkForUpdates = ref.read(clientSettingsProvider.select((value) => value.checkForUpdates));

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

  void toggleUpdateChecker(bool checkForUpdates) {
    _timer?.cancel();
    if (checkForUpdates) {
      _timer = Timer.periodic(const Duration(minutes: 30), (timer) {
        _fetchLatest();
      });
      _fetchLatest();
    }
  }

  Future<List<ReleaseInfo>> _fetchLatest() async {
    final latest = await updateChecker.fetchRecentReleases();
    state = UpdatesModel(
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
