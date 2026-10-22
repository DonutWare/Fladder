import 'package:collection/collection.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/util/duration_extensions.dart';

/// A user-data update derived from the aggregate progress of a multipart item.
class MultipartUserDataUpdate {
  final String itemId;
  final int playbackPositionTicks;
  final bool? played;
  final DateTime? lastPlayed;

  const MultipartUserDataUpdate({
    required this.itemId,
    required this.playbackPositionTicks,
    this.played,
    this.lastPlayed,
  });
}

/// Where a normal play action should start within a multipart item.
class MultipartResumeDecision {
  final ItemBaseModel item;
  final Duration startPosition;
  final bool resetGroup;

  const MultipartResumeDecision({
    required this.item,
    required this.startPosition,
    this.resetGroup = false,
  });
}

/// The ordered logical parts of a multi-part movie or episode.
///
/// [main] is always Part 1 (the Jellyfin item itself) and [parts] contains the
/// main item followed by the additional parts in part-number order.
class MultipartGroup {
  final ItemBaseModel main;
  final List<ItemBaseModel> parts;

  const MultipartGroup({
    required this.main,
    required this.parts,
  });

  String get parentId => main.id;

  int get partCount => parts.length;

  List<ItemBaseModel> get additionalParts => parts.skip(1).toList(growable: false);

  bool isFirstPart(ItemBaseModel item) => item.id == main.id;

  bool isFinalPart(ItemBaseModel item) => parts.isNotEmpty && parts.last.id == item.id;

  int partIndex(ItemBaseModel item) => parts.indexWhere((part) => part.id == item.id);

  Duration? get totalDuration {
    var total = Duration.zero;
    for (final part in parts) {
      final runtime = part.overview.runTime;
      if (runtime == null || runtime <= Duration.zero) return null;
      total += runtime;
    }
    return total;
  }

  /// Position measured from the start of Part 1.
  Duration combinedPosition(ItemBaseModel current, Duration localPosition) {
    final index = partIndex(current);
    if (index <= 0) return _clamp(localPosition, _runtimeOf(main));

    var combined = Duration.zero;
    for (var i = 0; i < index; i++) {
      combined += _runtimeOf(parts[i]);
    }
    return combined + _clamp(localPosition, _runtimeOf(current));
  }

  /// Aggregate progress (0..100) over the whole logical item.
  double aggregateProgress(ItemBaseModel current, Duration localPosition) {
    final total = totalDuration;
    if (total == null || total <= Duration.zero) return 0;
    final combined = combinedPosition(current, localPosition);
    return (combined.inMicroseconds / total.inMicroseconds * 100).clamp(0.0, 100.0);
  }

  /// Position stored on the parent item so Jellyfin's percentage reflects the
  /// logical aggregate progress.
  ///
  /// Only valid when [current] is Part 2 or later; Part 1 keeps its local
  /// position in the parent's user data.
  int parentPositionTicks(ItemBaseModel current, Duration localPosition) {
    final mainRuntime = _runtimeOf(main);
    final progress = aggregateProgress(current, localPosition);
    return (mainRuntime.inMilliseconds * 10000 * progress / 100).round();
  }

  /// Progress update for the parent while playing.
  ///
  /// Returns null for Part 1 because the session progress call already keeps
  /// the parent's local Part 1 position.
  MultipartUserDataUpdate? progressUpdate(
    ItemBaseModel current,
    Duration localPosition, {
    DateTime? now,
  }) {
    if (isFirstPart(current)) return null;

    return MultipartUserDataUpdate(
      itemId: main.id,
      playbackPositionTicks: parentPositionTicks(current, localPosition),
      played: false,
      lastPlayed: (now ?? DateTime.now()).toUtc(),
    );
  }

  /// Update to write after the current part stopped.
  MultipartUserDataUpdate? stopUpdate(
    ItemBaseModel current,
    Duration stopPosition, {
    DateTime? now,
  }) {
    if (isFirstPart(current)) {
      // Jellyfin may have just marked the parent played when Part 1 ended.
      // Force it back to in-progress with Part 1's local position.
      final clamped = _clamp(stopPosition, _runtimeOf(main));
      return MultipartUserDataUpdate(
        itemId: main.id,
        playbackPositionTicks: clamped.toRuntimeTicks,
        played: false,
      );
    }
    return progressUpdate(current, stopPosition, now: now);
  }

  /// User-data updates that clear the logical item before a rewatch.
  ///
  /// The parent is Part 1, so it is reset locally just like every additional
  /// part.
  List<MultipartUserDataUpdate> resetUpdates() => [
        MultipartUserDataUpdate(
          itemId: main.id,
          playbackPositionTicks: 0,
          played: false,
        ),
        for (final part in additionalParts)
          MultipartUserDataUpdate(
            itemId: part.id,
            playbackPositionTicks: 0,
            played: false,
          ),
      ];

  /// Explicit start positions and direct part picks bypass aggregate resume.
  static bool bypassesAutoResume(ItemBaseModel requested, Duration? startPosition) =>
      startPosition != null || requested is VideoPartModel;

  /// User data for Part 1 after a progress or stop write.
  ///
  /// Part 1 always keeps its local position and never marks the logical item
  /// played while additional parts remain.
  static UserData? part1UserData(
    UserData? current,
    Duration position,
    Duration partRuntime, {
    DateTime? now,
  }) {
    if (current == null) return null;
    final clamped = _clamp(position, partRuntime);
    final progress = partRuntime.inMilliseconds <= 0
        ? 0.0
        : (clamped.inMilliseconds / partRuntime.inMilliseconds * 100).clamp(0.0, 100.0).toDouble();
    return current.copyWith(
      playbackPositionTicks: clamped.toRuntimeTicks,
      progress: progress,
      played: false,
      lastPlayed: now ?? DateTime.now().toUtc(),
    );
  }

  /// Parent user data for aggregated progress while a later part is playing.
  static UserData? parentProgressUserData(
    UserData? current,
    int playbackPositionTicks,
    double aggregateProgress, {
    DateTime? now,
  }) {
    if (current == null) return null;
    return current.copyWith(
      playbackPositionTicks: playbackPositionTicks,
      progress: aggregateProgress.clamp(0.0, 100.0).toDouble(),
      played: false,
      lastPlayed: now ?? DateTime.now().toUtc(),
    );
  }

  /// Parent user data when the final part has been watched.
  static UserData? completedParentUserData(UserData? current, {DateTime? now}) {
    if (current == null) return null;
    return current.copyWith(
      played: true,
      playbackPositionTicks: 0,
      progress: 100,
      playCount: current.playCount + 1,
      lastPlayed: now ?? DateTime.now().toUtc(),
    );
  }

  /// Whether finishing [current] at [stopPosition] completes the logical item.
  bool shouldMarkCompleted(ItemBaseModel current, Duration stopPosition) {
    if (!isFinalPart(current)) return false;
    final runtime = current.overview.runTime;
    if (runtime == null || runtime <= Duration.zero) return false;
    return UserData.isPlayed(stopPosition, runtime) == true;
  }

  /// Part 1 is logically complete once any additional part has started.
  bool get part1Played =>
      main.userData.played || additionalParts.any((part) => part.userData.played || part.userData.progress > 0);

  /// Watched state of the logical item.
  bool get allPartsPlayed => main.userData.played || additionalParts.every((part) => part.userData.played);

  /// Aggregate progress for display, derived from per-part user data.
  double get aggregateProgressForDisplay {
    final additional = additionalParts;
    final part1Fraction = part1Played ? 1.0 : (main.userData.progress / 100).clamp(0.0, 1.0);

    var watchedMicros = part1Fraction * _runtimeOf(main).inMicroseconds;
    for (final part in additional) {
      final duration = _runtimeOf(part).inMicroseconds;
      final fraction = part.userData.played ? 1.0 : (part.userData.progress / 100).clamp(0.0, 1.0);
      watchedMicros += duration * fraction;
    }

    final total = totalDuration;
    if (total == null || total <= Duration.zero) return main.userData.progress;
    return (watchedMicros / total.inMicroseconds * 100).clamp(0.0, 100.0);
  }

  /// Resolves where a normal (non-explicit) play action should start.
  ///
  /// Mirrors the rules in plan §4.5.
  MultipartResumeDecision resumeDecision() {
    final additional = additionalParts;
    final parentPlayed = main.userData.played;
    final allAdditionalPlayed = additional.every((part) => part.userData.played);
    final laterPartStarted = additional.any((part) => part.userData.played || part.userData.progress > 0);

    // 1. The logical item is finished: rewatch from Part 1 and reset everything.
    if (parentPlayed && allAdditionalPlayed) {
      return MultipartResumeDecision(
        item: main,
        startPosition: Duration.zero,
        resetGroup: true,
      );
    }

    // 2. Legacy data: Jellyfin marked the parent played after Part 1 only.
    if (parentPlayed) {
      final firstUnplayed = additional.firstWhereOrNull((part) => !part.userData.played);
      if (firstUnplayed != null) {
        return MultipartResumeDecision(
          item: firstUnplayed,
          startPosition: firstUnplayed.userData.playBackPosition,
        );
      }
      return MultipartResumeDecision(
        item: main,
        startPosition: Duration.zero,
        resetGroup: true,
      );
    }

    // 3. Part 1 is logically complete because a later part has started.
    if (laterPartStarted) {
      final inProgress = additional.firstWhereOrNull(
        (part) => part.userData.progress > 0 && !part.userData.played,
      );
      if (inProgress != null) {
        return MultipartResumeDecision(
          item: inProgress,
          startPosition: inProgress.userData.playBackPosition,
        );
      }

      final firstUnplayed = additional.firstWhereOrNull((part) => !part.userData.played);
      if (firstUnplayed != null) {
        return MultipartResumeDecision(
          item: firstUnplayed,
          startPosition: firstUnplayed.userData.playBackPosition,
        );
      }

      return MultipartResumeDecision(
        item: main,
        startPosition: Duration.zero,
        resetGroup: true,
      );
    }

    // 4. No additional part has started: the parent holds Part 1's local
    // position.
    return MultipartResumeDecision(
      item: main,
      startPosition: _clamp(main.userData.playBackPosition, _runtimeOf(main)),
    );
  }

  static MultipartGroup? fromMain(
    ItemBaseModel main,
    List<VideoPartModel> additionalParts,
  ) {
    final sorted = [...additionalParts]..sort((a, b) => a.partNumber.compareTo(b.partNumber));
    if (sorted.isEmpty) return null;

    final allParts = <ItemBaseModel>[main, ...sorted];
    for (final part in allParts) {
      final runtime = part.overview.runTime;
      if (runtime == null || runtime <= Duration.zero) return null;
    }

    return MultipartGroup(main: main, parts: allParts);
  }

  static MultipartGroup? fromQueue(List<ItemBaseModel> queue, ItemBaseModel current) {
    ItemBaseModel? main;
    if (current is VideoPartModel) {
      main = queue.firstWhereOrNull((item) => item.id == current.parentItemId);
    } else if (queue.any((item) => item is VideoPartModel && item.parentItemId == current.id)) {
      main = current;
    }
    if (main == null) return null;

    final additionalParts =
        queue.whereType<VideoPartModel>().where((part) => part.parentItemId == main!.id).toList(growable: false);

    final group = fromMain(main, additionalParts);
    if (group == null) return null;
    if (!group.parts.any((part) => part.id == current.id)) return null;
    return group;
  }

  static Duration _runtimeOf(ItemBaseModel item) => item.overview.runTime ?? Duration.zero;

  static Duration _clamp(Duration position, Duration max) {
    if (position < Duration.zero) return Duration.zero;
    if (max > Duration.zero && position > max) return max;
    return position;
  }
}
