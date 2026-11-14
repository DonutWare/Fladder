import 'package:flutter_riverpod/legacy.dart';

final pendingItemsProvider = StateNotifierProvider<PendingItemsNotifier, Set<String>>((ref) {
  return PendingItemsNotifier();
});

class PendingItemsNotifier extends StateNotifier<Set<String>> {
  PendingItemsNotifier() : super({});

  final Map<String, int> _counts = {};

  void add(String id) {
    _counts[id] = (_counts[id] ?? 0) + 1;
    if (!state.contains(id)) state = {...state, id};
  }

  void remove(String id) {
    final count = (_counts[id] ?? 0) - 1;
    if (count > 0) {
      _counts[id] = count;
      return;
    }
    _counts.remove(id);
    if (state.contains(id)) state = {...state}..remove(id);
  }
}
