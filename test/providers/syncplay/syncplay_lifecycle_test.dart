import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_message_handler.dart';
import 'package:flutter_test/flutter_test.dart';

// We deliberately avoid spinning up the full SyncPlayController here:
// it depends on a Riverpod Ref + Chopper + WebSocket. Instead we cover the
// state-flag invariants that downstream tests rely on.
//
// Lifecycle reset is verified through the controller via integration tests
// gated behind a manual test plan (see docs/syncplay-implementation.md
// "Regression scenarios"). The unit-level coverage here proves that
// SyncPlayState resets cleanly via copyWith — the controller's leaveGroup
// path uses the same pattern.

void main() {
  group('SyncPlayState lifecycle reset', () {
    test('copyWith clears all in-flight playback flags', () {
      final mid = SyncPlayState(
        isInGroup: true,
        groupId: 'g1',
        groupName: 'movie night',
        groupState: SyncPlayGroupState.playing,
        playingItemId: 'item-1',
        playlistItemId: 'plist-1',
        positionTicks: 1234,
        startPlaybackInProgress: true,
        startingPlaylistItemId: 'plist-1',
        isProcessingCommand: true,
        processingCommandType: SyncPlayCommand.unpause,
      );

      final cleared = mid.copyWith(
        isInGroup: false,
        groupId: null,
        groupName: null,
        groupState: SyncPlayGroupState.idle,
        participants: const [],
        isProcessingCommand: false,
        processingCommandType: null,
        positionTicks: 0,
        playingItemId: null,
        playlistItemId: null,
        startPlaybackInProgress: false,
        startingPlaylistItemId: null,
      );

      expect(cleared.isInGroup, isFalse);
      expect(cleared.groupId, isNull);
      expect(cleared.startPlaybackInProgress, isFalse);
      expect(cleared.startingPlaylistItemId, isNull);
      expect(cleared.processingCommandType, isNull);
      expect(cleared.playingItemId, isNull);
    });
  });

  group('SyncPlayMessageHandler Waiting state', () {
    test('Buffer reason invokes a local pause callback before reporting ready', () async {
      final readyCalls = <bool>[];
      var pauseCalls = 0;
      final handler = SyncPlayMessageHandler(
        onStateUpdate: (_) {},
        reportReady: ({bool isPlaying = true}) async {
          readyCalls.add(isPlaying);
        },
        startPlayback: (id, ticks) async {},
        isBuffering: () => false,
        getContext: () => null,
        onGroupJoined: () {},
        onGroupJoinFailed: () {},
        onLocalPauseForBuffer: () async {
          pauseCalls++;
        },
      );

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'StateUpdate',
        'Data': <String, dynamic>{
          'State': 'Waiting',
          'Reason': 'Buffer',
          'PositionTicks': 0,
        },
      }, SyncPlayState(isInGroup: true));

      await Future<void>.delayed(const Duration(milliseconds: 5));

      expect(pauseCalls, 1, reason: 'should pause locally on Buffer reason');
      expect(readyCalls, [true], reason: 'should still report ready (true) after pausing');
    });

    test('Unpause reason does not invoke local pause', () async {
      var pauseCalls = 0;
      final handler = SyncPlayMessageHandler(
        onStateUpdate: (_) {},
        reportReady: ({bool isPlaying = true}) async {},
        startPlayback: (id, ticks) async {},
        isBuffering: () => false,
        getContext: () => null,
        onGroupJoined: () {},
        onGroupJoinFailed: () {},
        onLocalPauseForBuffer: () async {
          pauseCalls++;
        },
      );

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'StateUpdate',
        'Data': <String, dynamic>{
          'State': 'Waiting',
          'Reason': 'Unpause',
          'PositionTicks': 0,
        },
      }, SyncPlayState(isInGroup: true));

      await Future<void>.delayed(const Duration(milliseconds: 5));
      expect(pauseCalls, 0);
    });
  });
}
