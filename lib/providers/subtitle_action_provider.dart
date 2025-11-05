import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SubtitleAction {
  toggle,
  nextTrack,
  prevTrack,
  offsetIncrease,
  offsetDecrease,
  notSupported,
}

class SubtitleActionState {
  final SubtitleAction action;
  final String message;
  final DateTime timestamp;

  const SubtitleActionState({
    required this.action,
    required this.message,
    required this.timestamp,
  });

  SubtitleActionState copyWith({
    SubtitleAction? action,
    String? message,
    DateTime? timestamp,
  }) {
    return SubtitleActionState(
      action: action ?? this.action,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class SubtitleActionNotifier extends StateNotifier<SubtitleActionState?> {
  SubtitleActionNotifier() : super(null);

  void showAction(SubtitleAction action, String message) {
    state = SubtitleActionState(
      action: action,
      message: message,
      timestamp: DateTime.now(),
    );
  }

  void showNotSupported(String playerBackend) {
    state = SubtitleActionState(
      action: SubtitleAction.notSupported,
      message: 'Offset not supported by $playerBackend',
      timestamp: DateTime.now(),
    );
  }

  void clear() {
    state = null;
  }
}

final subtitleActionProvider = StateNotifierProvider<SubtitleActionNotifier, SubtitleActionState?>((ref) {
  return SubtitleActionNotifier();
});