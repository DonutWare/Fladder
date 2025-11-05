import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/subtitle_action_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

final subtitleOffsetProvider = StateNotifierProvider<SubtitleOffsetNotifier, double>((ref) {
  return SubtitleOffsetNotifier(ref);
});

class SubtitleOffsetNotifier extends StateNotifier<double> {
  SubtitleOffsetNotifier(this.ref) : super(0.0);

  final Ref ref;

  @override
  set state(double value) {
    super.state = value;
    ref.read(sharedUtilityProvider).subtitleOffset = value;
  }

  void setOffset(double value) {
    state = value;
    _applyOffsetToPlayer(value);
  }

  void adjustOffset(double delta) {
    final newValue = (state + delta).clamp(-30.0, 30.0);
    state = newValue;
    _applyOffsetToPlayer(newValue);
  }

  void resetOffset() {
    state = 0.0;
    _applyOffsetToPlayer(0.0);
  }

  void _applyOffsetToPlayer(double offset) {
    final player = ref.read(videoPlayerProvider);
    
    if (player.player?.supportsSubtitleOffset == true) {
      player.adjustSubtitleOffset(offset);
    } else {
      ref.read(subtitleActionProvider.notifier).showAction(
        SubtitleAction.notSupported,
        'Subtitle offset not supported',
      );
    }
  }
}