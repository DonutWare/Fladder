import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fladder/providers/subtitle_action_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

final subtitleOffsetProvider = StateNotifierProvider<SubtitleOffsetNotifier, double>((ref) {
  return SubtitleOffsetNotifier(ref);
});

class SubtitleOffsetNotifier extends StateNotifier<double> {
  SubtitleOffsetNotifier(this.ref) : super(0.0);

  final Ref ref;



  bool setOffset(double value) {
    state = value;
    return _applyOffsetToPlayer(value);
  }

  bool adjustOffset(double delta) {
    final newValue = (state + delta).clamp(-30.0, 30.0);
    state = newValue;
    return _applyOffsetToPlayer(newValue);
  }

  bool resetOffset() {
    state = 0.0;
    return _applyOffsetToPlayer(0.0);
  }

  bool _applyOffsetToPlayer(double offset) {
    final player = ref.read(videoPlayerProvider);
    
    if (player.supportsSubtitleOffset) {
      player.adjustSubtitleOffset(offset);
      return true;
    } else {
      return false;
    }
  }
}