import 'dart:math' show Random;

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/util/list_extensions.dart';

enum AudioQueueSection {
  nextUp,
  existing,
}

class PlaybackQueueState {
  final List<ItemBaseModel> queue;
  final List<ItemBaseModel> originalQueue;
  final List<ItemBaseModel> nextUpQueue;
  final bool shuffleEnabled;
  final AudioRepeatMode repeatMode;
  final String? mainQueueCurrentId;
  final bool playingFromNextUp;

  const PlaybackQueueState({
    this.queue = const [],
    this.originalQueue = const [],
    this.nextUpQueue = const [],
    this.shuffleEnabled = false,
    this.repeatMode = AudioRepeatMode.off,
    this.mainQueueCurrentId,
    this.playingFromNextUp = false,
  });

  factory PlaybackQueueState.fromQueue(
    List<ItemBaseModel> queue, {
    String? initialItemId,
    bool shuffleEnabled = false,
    AudioRepeatMode repeatMode = AudioRepeatMode.off,
    Random? random,
  }) {
    if (queue.isEmpty) {
      return PlaybackQueueState(shuffleEnabled: shuffleEnabled, repeatMode: repeatMode);
    }
    final original = List<ItemBaseModel>.unmodifiable(queue);
    final effective = shuffleEnabled ? _shuffled(queue, initialItemId, random ?? Random()) : original;
    return PlaybackQueueState(
      queue: effective,
      originalQueue: original,
      shuffleEnabled: shuffleEnabled,
      repeatMode: repeatMode,
      mainQueueCurrentId: initialItemId,
    );
  }

  static List<ItemBaseModel> _shuffled(
    List<ItemBaseModel> items,
    String? anchorId,
    Random random,
  ) {
    final anchorIdx = anchorId != null ? items.indexWhere((e) => e.id == anchorId) : -1;
    final anchor = anchorIdx >= 0 ? items[anchorIdx] : items.first;
    final rest = List<ItemBaseModel>.from(items)..remove(anchor);
    rest.shuffle(random);
    return [anchor, ...rest];
  }

  ItemBaseModel? _nextInQueue(String currentPlayingId) {
    if (queue.isEmpty) return null;
    final anchorId = mainQueueCurrentId ?? currentPlayingId;
    final idx = queue.indexWhere((e) => e.id == anchorId);
    if (idx < 0) return repeatMode == AudioRepeatMode.all ? queue.first : null;
    if (idx + 1 < queue.length) return queue[idx + 1];
    if (repeatMode == AudioRepeatMode.all) return queue.first;
    return null;
  }

  ItemBaseModel? nextItem(String currentPlayingId) {
    if (playingFromNextUp) {
      final nextUpIdx = nextUpQueue.indexWhere((e) => e.id == currentPlayingId);
      if (nextUpIdx >= 0 && nextUpIdx + 1 < nextUpQueue.length) {
        return nextUpQueue[nextUpIdx + 1];
      }
      return _nextInQueue(currentPlayingId);
    }
    if (nextUpQueue.isNotEmpty) return nextUpQueue.first;
    return _nextInQueue(currentPlayingId);
  }

  ItemBaseModel? previousItem(String currentPlayingId) {
    if (queue.isEmpty || playingFromNextUp) return null;
    final idx = queue.indexWhere((e) => e.id == currentPlayingId);
    if (idx > 0) return queue[idx - 1];
    if (repeatMode == AudioRepeatMode.all) return queue.last;
    return null;
  }

  List<ItemBaseModel> _remainingNextUpQueue() {
    if (!playingFromNextUp || nextUpQueue.isEmpty) return nextUpQueue;
    return nextUpQueue.sublist(1);
  }

  List<ItemBaseModel> _queueAfterMainAnchor() {
    final anchorId = mainQueueCurrentId;
    if (anchorId == null) return const [];
    final idx = queue.indexWhere((e) => e.id == anchorId);
    if (idx < 0) return const [];
    return queue.sublist(idx + 1);
  }

  ({ItemBaseModel item, PlaybackQueueState state})? nextTransition(String currentPlayingId) {
    final item = nextItem(currentPlayingId);
    if (item == null) return null;
    return (
      item: item,
      state: advanceTo(
        fromId: currentPlayingId,
        toId: item.id,
        fromNextUp: playingFromNextUp,
      ),
    );
  }

  ({ItemBaseModel item, PlaybackQueueState state})? previousTransition(String currentPlayingId) {
    final item = previousItem(currentPlayingId);
    if (item == null) return null;
    return (
      item: item,
      state: advanceTo(fromId: null, toId: item.id),
    );
  }

  PlaybackQueueState advanceFromCurrentTo(String currentPlayingId, String toId) {
    return advanceTo(
      fromId: currentPlayingId,
      toId: toId,
      fromNextUp: playingFromNextUp,
    );
  }

  PlaybackQueueState advanceTo({required String? fromId, required String toId, bool fromNextUp = false}) {
    var state = this;
    String? newMainQueueCurrentId = state.mainQueueCurrentId;

    if (fromId != null) {
      if (fromNextUp) {
        final fromNextUpIdx = state.nextUpQueue.indexWhere((e) => e.id == fromId);
        if (fromNextUpIdx >= 0) {
          state = state.copyWith(
            nextUpQueue: List.from(state.nextUpQueue)..removeAt(fromNextUpIdx),
          );
        }
      } else if (state.queue.any((e) => e.id == fromId)) {
        newMainQueueCurrentId = fromId;
      }
    }

    final goingToNextUp = state.nextUpQueue.isNotEmpty && state.nextUpQueue.first.id == toId;
    if (!goingToNextUp && state.queue.any((e) => e.id == toId)) {
      newMainQueueCurrentId = toId;
    }

    return state.copyWith(
      mainQueueCurrentId: newMainQueueCurrentId,
      playingFromNextUp: goingToNextUp,
    );
  }

  PlaybackQueueState addToNextUp(List<ItemBaseModel> items) {
    if (items.isEmpty) return this;
    return copyWith(nextUpQueue: [...nextUpQueue, ...items]);
  }

  PlaybackQueueState appendToQueue(List<ItemBaseModel> items, {Random? random}) {
    if (items.isEmpty) return this;

    final existingIds = {
      ...queue.map((item) => item.id),
      ...nextUpQueue.map((item) => item.id),
    };
    final uniqueItems = items.where((item) => !existingIds.contains(item.id)).toList();
    if (uniqueItems.isEmpty) return this;

    final updatedOriginalQueue = [...originalQueue, ...uniqueItems];
    final updatedQueue = shuffleEnabled
        ? [
            ...queue,
            ...uniqueItems..shuffle(),
          ]
        : [...queue, ...uniqueItems];

    return copyWith(
      queue: updatedQueue,
      originalQueue: updatedOriginalQueue,
    );
  }

  PlaybackQueueState clearNextUp() {
    if (nextUpQueue.isEmpty) return this;
    return copyWith(nextUpQueue: const []);
  }

  PlaybackQueueState jumpToItem(String itemId) {
    final nextUpIdx = nextUpQueue.indexWhere((e) => e.id == itemId);
    if (nextUpIdx >= 0) {
      return copyWith(
        nextUpQueue: nextUpQueue.sublist(nextUpIdx),
        playingFromNextUp: true,
      );
    }

    return copyWith(
      nextUpQueue: _remainingNextUpQueue(),
      mainQueueCurrentId: itemId,
      playingFromNextUp: false,
    );
  }

  List<ItemBaseModel> queueAheadForPrefetch() {
    return [
      ..._remainingNextUpQueue(),
      ..._queueAfterMainAnchor(),
    ];
  }

  PlaybackQueueState withRepeatMode(AudioRepeatMode mode) => copyWith(repeatMode: mode);

  PlaybackQueueState withShuffleEnabled(bool enabled, {String? currentId, Random? random}) {
    if (shuffleEnabled == enabled) return this;
    if (!enabled) {
      return copyWith(shuffleEnabled: false, queue: originalQueue);
    }
    final base = originalQueue.isNotEmpty ? originalQueue : queue;
    return copyWith(
      shuffleEnabled: true,
      queue: _shuffled(base, currentId, random ?? Random()),
      originalQueue: List<ItemBaseModel>.unmodifiable(base),
    );
  }

  PlaybackQueueState removeItemById(String itemId) {
    final nextUpIdx = nextUpQueue.indexWhere((e) => e.id == itemId);
    if (nextUpIdx >= 0) {
      return copyWith(nextUpQueue: List.from(nextUpQueue)..removeAt(nextUpIdx));
    }
    final queueIdx = queue.indexWhere((e) => e.id == itemId);
    if (queueIdx < 0) return this;
    final newQueue = List<ItemBaseModel>.from(queue)..removeAt(queueIdx);
    final newOriginal = List<ItemBaseModel>.from(originalQueue)..removeWhere((e) => e.id == itemId);
    if (newQueue.isEmpty) {
      return copyWith(queue: const [], originalQueue: const []);
    }
    return copyWith(queue: newQueue, originalQueue: newOriginal);
  }

  PlaybackQueueState reorderSection(AudioQueueSection section, int oldIndex, int newIndex) {
    if (section != AudioQueueSection.nextUp || nextUpQueue.length <= 1) return this;
    final updated = List<ItemBaseModel>.from(nextUpQueue)..reorderInPlace(oldIndex, newIndex);
    return copyWith(nextUpQueue: updated);
  }

  PlaybackQueueState removeSectionItem(AudioQueueSection section, int sectionIndex) {
    if (section == AudioQueueSection.nextUp) {
      if (sectionIndex < 0 || sectionIndex >= nextUpQueue.length) return this;
      return copyWith(nextUpQueue: List.from(nextUpQueue)..removeAt(sectionIndex));
    }
    if (sectionIndex < 0 || sectionIndex >= queue.length) return this;
    return removeItemById(queue[sectionIndex].id);
  }

  int? nextUpStartInDisplay(String? currentPlayingId) {
    final count = nextUpCountInDisplay(currentPlayingId);
    if (count == null || count == 0) return null;
    return 1;
  }

  int? nextUpCountInDisplay(String? currentPlayingId) {
    final remainingNextUpCount = _remainingNextUpQueue().length;
    return remainingNextUpCount == 0 ? null : remainingNextUpCount;
  }

  List<ItemBaseModel> queueForDisplay(String? currentPlayingId, {required bool wrapAround}) {
    if (queue.isEmpty && nextUpQueue.isEmpty) return const [];

    ItemBaseModel? currentItem;
    List<ItemBaseModel> remainingNextUp;
    int queueIdx = -1;

    if (currentPlayingId != null) {
      if (playingFromNextUp && nextUpQueue.isNotEmpty) {
        currentItem = nextUpQueue.first;
        remainingNextUp = _remainingNextUpQueue();
      } else {
        queueIdx = queue.indexWhere((e) => e.id == currentPlayingId);
        currentItem = queueIdx >= 0 ? queue[queueIdx] : null;
        remainingNextUp = nextUpQueue;
      }
    } else {
      remainingNextUp = nextUpQueue;
    }

    final queueAfter = queueIdx >= 0 ? queue.sublist(queueIdx + 1) : _queueAfterAnchor(currentPlayingId);
    final queueBefore = wrapAround && queueIdx > 0 ? queue.sublist(0, queueIdx) : const <ItemBaseModel>[];

    return [
      if (currentItem != null) currentItem,
      ...remainingNextUp,
      ...queueAfter,
      ...queueBefore,
    ];
  }

  List<ItemBaseModel> _queueAfterAnchor(String? currentPlayingId) {
    if (currentPlayingId == null) return queue;
    return _queueAfterMainAnchor();
  }

  PlaybackQueueState copyWith({
    List<ItemBaseModel>? queue,
    List<ItemBaseModel>? originalQueue,
    List<ItemBaseModel>? nextUpQueue,
    bool? shuffleEnabled,
    AudioRepeatMode? repeatMode,
    String? mainQueueCurrentId,
    bool? playingFromNextUp,
  }) {
    return PlaybackQueueState(
      queue: queue ?? this.queue,
      originalQueue: originalQueue ?? this.originalQueue,
      nextUpQueue: nextUpQueue ?? this.nextUpQueue,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      repeatMode: repeatMode ?? this.repeatMode,
      mainQueueCurrentId: mainQueueCurrentId ?? this.mainQueueCurrentId,
      playingFromNextUp: playingFromNextUp ?? this.playingFromNextUp,
    );
  }
}
