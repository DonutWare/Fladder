import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_command_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('selectSyncCorrectionStrategy', () {
    test('selects SpeedToSync in medium drift window', () {
      final strategy = selectSyncCorrectionStrategy(
        config: const SyncCorrectionConfig(),
        state: const SyncCorrectionState(
          syncEnabled: true,
          activeStrategy: SyncCorrectionStrategy.none,
        ),
        diffMillis: 500,
        hasPlaybackRate: true,
      );

      expect(strategy, SyncCorrectionStrategy.speedToSync);
    });

    test('falls back to SkipToSync when playback rate unsupported', () {
      final strategy = selectSyncCorrectionStrategy(
        config: const SyncCorrectionConfig(),
        state: const SyncCorrectionState(
          syncEnabled: true,
          activeStrategy: SyncCorrectionStrategy.none,
        ),
        diffMillis: 500,
        hasPlaybackRate: false,
      );

      expect(strategy, SyncCorrectionStrategy.skipToSync);
    });

    test('selects SkipToSync for very large drift', () {
      final strategy = selectSyncCorrectionStrategy(
        config: const SyncCorrectionConfig(),
        state: const SyncCorrectionState(
          syncEnabled: true,
          activeStrategy: SyncCorrectionStrategy.none,
        ),
        diffMillis: 3500,
        hasPlaybackRate: true,
      );

      expect(strategy, SyncCorrectionStrategy.skipToSync);
    });
  });

  group('SyncPlayState helpers', () {
    test('hasActivePlayback false when no playing item', () {
      final state = SyncPlayState(isInGroup: true);
      expect(state.hasActivePlayback, isFalse);
    });

    test('hasActivePlayback true with playing item and non-idle state', () {
      final state = SyncPlayState(
        isInGroup: true,
        playingItemId: 'item-1',
        groupState: SyncPlayGroupState.playing,
      );
      expect(state.hasActivePlayback, isTrue);
    });

    test('hasActivePlayback false when group state is idle', () {
      final state = SyncPlayState(
        isInGroup: true,
        playingItemId: 'item-1',
      );
      expect(state.hasActivePlayback, isFalse);
    });

    test('isInLocalOnlyMode mirrors localOnlyOperationCount', () {
      expect(SyncPlayState().isInLocalOnlyMode, isFalse);
      expect(
        SyncPlayState(localOnlyOperationCount: 1).isInLocalOnlyMode,
        isTrue,
      );
      expect(
        SyncPlayState(localOnlyOperationCount: 3).isInLocalOnlyMode,
        isTrue,
      );
    });
  });

  group('SyncPlayCommandHandler', () {
    test('duplicate Pause while already paused at position is a no-op correction check', () async {
      var pauseCalls = 0;
      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (_) {},
      )
        ..onPause = () async {
          pauseCalls++;
        }
        ..getPositionTicks = () => 0;

      final now = DateTime.now().toUtc().toIso8601String();
      final commandData = <String, dynamic>{
        'Command': 'Pause',
        'When': now,
        'PositionTicks': 0,
        'PlaylistItemId': 'playlist-item-1',
      };

      handler.handleCommand(commandData, SyncPlayState());
      handler.handleCommand(commandData, SyncPlayState());

      expect(pauseCalls, 1);
    });

    test('executes Unpause as seek then play', () async {
      final order = <String>[];
      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (_) {},
      )
        ..onSeek = (ticks) async {
          order.add('seek');
        }
        ..onPlay = () async {
          order.add('play');
        }
        ..getPositionTicks = () => 0;

      final commandData = <String, dynamic>{
        'Command': 'Unpause',
        'When': DateTime.now().toUtc().toIso8601String(),
        'PositionTicks': ticksPerSecond * 2,
        'PlaylistItemId': 'playlist-item-1',
      };

      handler.handleCommand(commandData, SyncPlayState());
      await Future<void>.delayed(const Duration(milliseconds: 5));

      expect(order, ['seek', 'play']);
    });

    test('Unpause is not deduped when player is paused', () async {
      var playCalls = 0;
      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (_) {},
      )
        ..onPlay = () async {
          playCalls++;
        }
        ..onSeek = ((_) async {})
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false);

      final commandData = <String, dynamic>{
        'Command': 'Unpause',
        'When': DateTime.now().toUtc().toIso8601String(),
        'PositionTicks': 0,
        'PlaylistItemId': 'playlist-item-1',
      };

      handler.handleCommand(commandData, SyncPlayState());
      await Future<void>.delayed(const Duration(milliseconds: 5));
      handler.handleCommand(commandData, SyncPlayState());
      await Future<void>.delayed(const Duration(milliseconds: 5));

      expect(playCalls, 2);
    });

    test('Seek reports ready only when not buffering', () async {
      var readyCalls = 0;
      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (_) {},
      )
        ..onPause = () async {}
        ..onSeek = (ticks) async {}
        ..onReportReady = ({required bool isPlaying, required int positionTicks}) async {
          readyCalls++;
        }
        ..isBuffering = () => false;

      final commandData = <String, dynamic>{
        'Command': 'Seek',
        'When': DateTime.now().toUtc().toIso8601String(),
        'PositionTicks': ticksPerSecond,
        'PlaylistItemId': 'playlist-item-1',
      };

      handler.handleCommand(commandData, SyncPlayState());
      await Future<void>.delayed(const Duration(milliseconds: 5));
      expect(readyCalls, 1);

      handler.isBuffering = () => true;
      handler.handleCommand(
        {
          ...commandData,
          'When': DateTime.now().toUtc().toIso8601String(),
        },
        SyncPlayState(),
      );
      await Future<void>.delayed(const Duration(milliseconds: 5));
      expect(readyCalls, 1);
    });

    test('Unpause defers final state-clear until player stops buffering', () async {
      var buffering = true;
      var stateClearFired = false;

      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (updater) {
          // Detect the finally block's isProcessingCommand=false transition by applying the updater to a sentinel.
          final after = updater(SyncPlayState(isProcessingCommand: true));
          if (after.isProcessingCommand == false) {
            stateClearFired = true;
          }
        },
      )
        ..onSeek = (_) async {}
        ..onPlay = () async {}
        ..getPositionTicks = (() => 0)
        ..isBuffering = (() => buffering);

      final commandData = <String, dynamic>{
        'Command': 'Unpause',
        'When': DateTime.now().toUtc().toIso8601String(),
        'PositionTicks': ticksPerSecond * 2,
        'PlaylistItemId': 'playlist-item-1',
      };

      handler.handleCommand(commandData, SyncPlayState());

      // While player is buffering the finally must not have fired.
      await Future<void>.delayed(const Duration(milliseconds: 250));
      expect(
        stateClearFired,
        isFalse,
        reason: 'should not clear isProcessingCommand while player is still buffering',
      );

      // Player finishes buffering; the wait loop polls every 100 ms and
      // the finally block should fire shortly after.
      buffering = false;
      await Future<void>.delayed(const Duration(milliseconds: 250));
      expect(
        stateClearFired,
        isTrue,
        reason: 'should clear isProcessingCommand once buffering ends',
      );
    });

    test('Pause-with-seek defers final state-clear until player stops buffering', () async {
      var buffering = true;
      var stateClearFired = false;

      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (updater) {
          final after = updater(SyncPlayState(isProcessingCommand: true));
          if (after.isProcessingCommand == false) {
            stateClearFired = true;
          }
        },
      )
        ..onPause = () async {}
        ..onSeek = (_) async {}
        // Force a position correction by pretending the local player is far
        // from the requested Pause position — handler will call onSeek.
        ..getPositionTicks = (() => 0)
        ..isBuffering = (() => buffering);

      final commandData = <String, dynamic>{
        'Command': 'Pause',
        'When': DateTime.now().toUtc().toIso8601String(),
        'PositionTicks': ticksPerSecond * 5,
        'PlaylistItemId': 'playlist-item-1',
      };

      handler.handleCommand(commandData, SyncPlayState());

      // While player is buffering after the correction seek, the finally
      // block must not have fired.
      await Future<void>.delayed(const Duration(milliseconds: 250));
      expect(
        stateClearFired,
        isFalse,
        reason: 'should not clear isProcessingCommand while seek-induced buffering is active',
      );

      buffering = false;
      await Future<void>.delayed(const Duration(milliseconds: 250));
      expect(
        stateClearFired,
        isTrue,
        reason: 'should clear isProcessingCommand once buffering ends',
      );
    });
  });
}
