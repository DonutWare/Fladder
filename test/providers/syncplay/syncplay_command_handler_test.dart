import 'dart:async';

import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_command_handler.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// Zero-offset clock whose readiness the test controls.
class _FakeClock implements SyncPlayClock {
  _FakeClock({required this.ready});

  bool ready;

  @override
  bool get isReady => ready;

  @override
  Duration get ping => Duration.zero;

  @override
  DateTime remoteDateToLocal(DateTime serverTime) => serverTime;

  @override
  DateTime localDateToRemote(DateTime localTime) => localTime;
}

Map<String, dynamic> _command(
  String command, {
  required DateTime when,
  int positionTicks = 0,
  String playlistItemId = 'plist-1',
}) {
  return <String, dynamic>{
    'Command': command,
    'When': when.toIso8601String(),
    'PositionTicks': positionTicks,
    'PlaylistItemId': playlistItemId,
  };
}

Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  group('recording while not following', () {
    test('recordCommand keeps the position bookkeeping without touching the player', () async {
      var pauseCalls = 0;
      int? writtenTicks;
      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (updater) => writtenTicks = updater(SyncPlayState()).positionTicks,
      )..onPause = () async {
          pauseCalls++;
        };
      final when = DateTime.now().toUtc();

      handler.recordCommand(_command('Pause', when: when, positionTicks: 42000));
      await _settle();

      expect(pauseCalls, 0);
      expect(writtenTicks, 42000);
      expect(handler.lastCommand?.command, SyncPlayCommand.pause);
      expect(handler.lastCommand?.positionTicks, 42000);
      expect(handler.lastCommand?.when, when.toIso8601String());
      expect(handler.hasPendingCommand, isFalse);
    });
  });

  group('execution ownership', () {
    test('hasPendingCommand stays true while the player callback runs', () async {
      final playStarted = Completer<void>();
      final release = Completer<void>();
      final handler = SyncPlayCommandHandler(
        timeSync: () => _FakeClock(ready: true),
        onStateUpdate: (_) {},
      )
        ..onPlay = () async {
          playStarted.complete();
          await release.future;
        }
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false);

      handler.handleCommand(
        _command('Unpause', when: DateTime.now().toUtc().subtract(const Duration(milliseconds: 100))),
        SyncPlayState(isInGroup: true, playlistItemId: 'plist-1'),
      );
      await playStarted.future;

      expect(handler.hasPendingCommand, isTrue, reason: 'a running command owns the player');
      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isFalse);

      release.complete();
      await _settle();
      expect(handler.hasPendingCommand, isFalse);
    });
  });

  group('playlist item guard', () {
    test('command for another playlist item is ignored', () async {
      var pauseCalls = 0;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {
          pauseCalls++;
        }
        ..getPositionTicks = (() => 0);

      handler.handleCommand(
        _command('Pause', when: DateTime.now().toUtc(), playlistItemId: 'plist-1'),
        SyncPlayState(isInGroup: true, playlistItemId: 'plist-2'),
      );
      await _settle();

      expect(pauseCalls, 0);
    });

    test('Stop is applied even when the playlist item differs', () async {
      var stopCalls = 0;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onStop = () async {
          stopCalls++;
        };

      handler.handleCommand(
        _command('Stop', when: DateTime.now().toUtc(), playlistItemId: ''),
        SyncPlayState(isInGroup: true, playlistItemId: 'plist-2'),
      );
      await _settle();

      expect(stopCalls, 1);
    });

    test('command does not overwrite the current playlist item in state', () async {
      String? writtenPlaylistItemId = 'unchanged';
      final handler = SyncPlayCommandHandler(
        timeSync: () => null,
        onStateUpdate: (updater) {
          writtenPlaylistItemId = updater(SyncPlayState(playlistItemId: 'unchanged')).playlistItemId;
        },
      )
        ..onPause = () async {}
        ..getPositionTicks = (() => 0);

      handler.handleCommand(_command('Pause', when: DateTime.now().toUtc()), SyncPlayState());
      await _settle();

      expect(writtenPlaylistItemId, 'unchanged');
    });
  });

  group('duplicate command correction', () {
    test('duplicate Pause re-applies when the player is playing again', () async {
      var pauseCalls = 0;
      var playing = true;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {
          pauseCalls++;
          playing = false;
        }
        ..onSeek = (_) async {}
        ..isPlaying = (() => playing)
        ..getPositionTicks = (() => 0);
      final cmd = _command('Pause', when: DateTime.now().toUtc().subtract(const Duration(seconds: 1)));

      handler.handleCommand(cmd, SyncPlayState());
      await _settle();
      playing = true; // user resumed locally
      handler.handleCommand(cmd, SyncPlayState());
      await _settle();

      expect(pauseCalls, 2);
    });

    test('duplicate Pause is ignored when already paused at the right position', () async {
      var pauseCalls = 0;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {
          pauseCalls++;
        }
        ..onSeek = (_) async {}
        ..isPlaying = (() => false)
        ..getPositionTicks = (() => ticksPerSecond * 10);
      final cmd = _command(
        'Pause',
        when: DateTime.now().toUtc().subtract(const Duration(seconds: 1)),
        positionTicks: ticksPerSecond * 10,
      );

      handler.handleCommand(cmd, SyncPlayState());
      await _settle();
      handler.handleCommand(cmd, SyncPlayState());
      await _settle();

      expect(pauseCalls, 1);
    });

    test('duplicate Seek re-seeks with jitter when off position', () async {
      final seeks = <int>[];
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {}
        ..onSeek = (ticks) async {
          seeks.add(ticks);
        }
        ..onReportReady = ({required bool isPlaying, required int positionTicks}) async {}
        ..isPlaying = (() => false)
        ..getPositionTicks = (() => 0);
      final target = ticksPerSecond * 30;
      final cmd = _command(
        'Seek',
        when: DateTime.now().toUtc().subtract(const Duration(seconds: 1)),
        positionTicks: target,
      );

      handler.handleCommand(cmd, SyncPlayState());
      await _settle();
      handler.handleCommand(cmd, SyncPlayState());
      await _settle();

      expect(seeks.length, 2);
      expect(seeks.first, target);
      expect((seeks.last - target).abs(), lessThanOrEqualTo(millisecondsToTicks(50)));
    });

    test('duplicate Seek at the right position only reports ready', () async {
      final seeks = <int>[];
      var readyCalls = 0;
      final target = ticksPerSecond * 30;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {}
        ..onSeek = (ticks) async {
          seeks.add(ticks);
        }
        ..onReportReady = ({required bool isPlaying, required int positionTicks}) async {
          readyCalls++;
        }
        ..isPlaying = (() => false)
        ..getPositionTicks = (() => target);
      final cmd = _command(
        'Seek',
        when: DateTime.now().toUtc().subtract(const Duration(seconds: 1)),
        positionTicks: target,
      );

      handler.handleCommand(cmd, SyncPlayState());
      await _settle();
      handler.handleCommand(cmd, SyncPlayState());
      await _settle();

      expect(seeks.length, 1);
      expect(readyCalls, 2, reason: 'first from the Seek itself, second from the duplicate check');
    });

    test('duplicate whose time is still in the future is left to the timer', () async {
      var playCalls = 0;
      final clock = _FakeClock(ready: true);
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onPlay = () async {
          playCalls++;
        }
        ..onSeek = (_) async {}
        ..isPlaying = (() => false)
        ..getPositionTicks = (() => 0);
      final cmd = _command('Unpause', when: DateTime.now().toUtc().add(const Duration(milliseconds: 500)));

      handler.handleCommand(cmd, SyncPlayState());
      handler.handleCommand(cmd, SyncPlayState());
      await _settle();
      expect(playCalls, 0);
      expect(handler.hasPendingCommand, isTrue);

      handler.cancelPendingCommands();
    });
  });

  group('recovery gate', () {
    test('shouldRecoverPlayback is false while an Unpause is still scheduled', () {
      final clock = _FakeClock(ready: true);
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onPlay = () async {}
        ..onSeek = (_) async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false);

      handler.handleCommand(
        _command('Unpause', when: DateTime.now().toUtc().add(const Duration(milliseconds: 800))),
        SyncPlayState(),
      );

      expect(handler.hasPendingCommand, isTrue);
      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isFalse);
      handler.cancelPendingCommands();
    });

    test('shouldRecoverPlayback is true once the Unpause time has passed and the player is paused', () async {
      final clock = _FakeClock(ready: true);
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onPlay = () async {}
        ..onSeek = (_) async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false);

      handler.handleCommand(
        _command('Unpause', when: DateTime.now().toUtc().subtract(const Duration(seconds: 2))),
        SyncPlayState(),
      );
      await _settle();

      expect(handler.hasPendingCommand, isFalse);
      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isTrue);
    });

    test('shouldRecoverPlayback is false after a Pause', () async {
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false);

      handler.handleCommand(_command('Pause', when: DateTime.now().toUtc()), SyncPlayState());
      await _settle();

      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isFalse);
    });

    test('shouldRecoverPlayback is true after a Seek once nothing is pending', () async {
      // The Unpause that follows a Seek can be lost or dropped by the
      // player; the group saying Playing is then the only signal left.
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {}
        ..onSeek = (_) async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false)
        ..isBuffering = (() => false);

      handler.handleCommand(_command('Seek', when: DateTime.now().toUtc(), positionTicks: 5000), SyncPlayState());
      await _settle();

      expect(handler.hasPendingCommand, isFalse);
      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isTrue);
    });

    test('shouldRecoverPlayback is true with no command context and a paused player', () {
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..isPlaying = (() => false)
        ..isBuffering = (() => false);

      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isTrue);
    });

    test('shouldRecoverPlayback is false while the player is buffering', () {
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..isPlaying = (() => false)
        ..isBuffering = (() => true);

      expect(handler.shouldRecoverPlayback(DateTime.now().toUtc()), isFalse);
    });
  });

  group('clock gate', () {
    test('a queued command is applied with the unsynced clock once the fallback expires', () async {
      var seekCalls = 0;
      final clock = _FakeClock(ready: false);
      final handler = SyncPlayCommandHandler(
        timeSync: () => clock,
        onStateUpdate: (_) {},
        clockFallback: const Duration(milliseconds: 100),
      )
        ..onSeek = (_) async {
          seekCalls++;
        }
        ..onPause = () async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false)
        ..isBuffering = (() => false);

      handler.handleCommand(
        _command('Seek', when: DateTime.now().toUtc().subtract(const Duration(seconds: 1)), positionTicks: 9000),
        SyncPlayState(isInGroup: true, playlistItemId: 'plist-1'),
      );
      await _settle();
      expect(seekCalls, 0);
      expect(handler.hasQueuedCommand, isTrue);

      await Future<void>.delayed(const Duration(milliseconds: 250));
      expect(seekCalls, 1, reason: 'a broken time sync must not freeze the group');
      expect(handler.hasQueuedCommand, isFalse);
    });

    test('flushQueuedCommand(force) applies the queued command before the clock is ready', () async {
      var playCalls = 0;
      final clock = _FakeClock(ready: false);
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onPlay = () async {
          playCalls++;
        }
        ..onSeek = (_) async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false)
        ..isBuffering = (() => false);

      handler.handleCommand(
        _command('Unpause', when: DateTime.now().toUtc().subtract(const Duration(milliseconds: 100))),
        SyncPlayState(isInGroup: true, playlistItemId: 'plist-1'),
      );
      expect(handler.hasQueuedCommand, isTrue);

      handler.flushQueuedCommand(force: true);
      await _settle();
      expect(playCalls, 1);
      expect(handler.hasQueuedCommand, isFalse);
    });

    test('a resend of the queued command is re-queued, not treated as a correction', () async {
      var seekCalls = 0;
      final clock = _FakeClock(ready: false);
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onSeek = (_) async {
          seekCalls++;
        }
        ..onPause = () async {}
        ..getPositionTicks = (() => 0)
        ..isPlaying = (() => false)
        ..isBuffering = (() => false);
      final when = DateTime.now().toUtc().subtract(const Duration(seconds: 1));
      final state = SyncPlayState(isInGroup: true, playlistItemId: 'plist-1');

      handler.handleCommand(_command('Seek', when: when, positionTicks: 9000), state);
      handler.handleCommand(_command('Seek', when: when, positionTicks: 9000), state);
      await _settle();
      expect(seekCalls, 0, reason: 'nothing may run before the first clock measurement');
      expect(handler.hasQueuedCommand, isTrue);

      clock.ready = true;
      handler.flushQueuedCommand();
      await _settle();
      expect(seekCalls, 1);
    });

    test('commands queue until the clock is ready and run on flush', () async {
      final clock = _FakeClock(ready: false);
      var playCalls = 0;
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onPlay = () async {
          playCalls++;
        }
        ..onSeek = (_) async {}
        ..getPositionTicks = (() => 0);

      handler.handleCommand(_command('Unpause', when: DateTime.now().toUtc()), SyncPlayState());
      await _settle();
      expect(playCalls, 0);
      expect(handler.hasQueuedCommand, isTrue);

      clock.ready = true;
      handler.flushQueuedCommand();
      await _settle();
      expect(playCalls, 1);
      expect(handler.hasQueuedCommand, isFalse);
    });

    test('only the latest command is kept while waiting for the clock', () async {
      final clock = _FakeClock(ready: false);
      final calls = <String>[];
      final handler = SyncPlayCommandHandler(timeSync: () => clock, onStateUpdate: (_) {})
        ..onPlay = () async {
          calls.add('play');
        }
        ..onPause = () async {
          calls.add('pause');
        }
        ..onSeek = (_) async {}
        ..getPositionTicks = (() => 0);

      handler.handleCommand(_command('Unpause', when: DateTime.now().toUtc()), SyncPlayState());
      handler.handleCommand(
        _command('Pause', when: DateTime.now().toUtc().add(const Duration(milliseconds: 1))),
        SyncPlayState(),
      );
      clock.ready = true;
      handler.flushQueuedCommand();
      await _settle();

      expect(calls, ['pause']);
    });
  });

  group('execution', () {
    test('Seek reports ready as paused at the requested position', () async {
      bool? reportedPlaying;
      int? reportedTicks;
      final target = ticksPerSecond * 42;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {}
        ..onSeek = (_) async {}
        ..onReportReady = ({required bool isPlaying, required int positionTicks}) async {
          reportedPlaying = isPlaying;
          reportedTicks = positionTicks;
        }
        ..isBuffering = (() => false)
        ..getPositionTicks = (() => target - millisecondsToTicks(300));

      handler.handleCommand(
        _command('Seek', when: DateTime.now().toUtc(), positionTicks: target),
        SyncPlayState(),
      );
      await _settle();

      expect(reportedPlaying, isFalse);
      expect(reportedTicks, target);
    });

    test('Pause does not seek inside the 500 ms tolerance', () async {
      var seekCalls = 0;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onPause = () async {}
        ..onSeek = (_) async {
          seekCalls++;
        }
        ..getPositionTicks = (() => millisecondsToTicks(400));

      handler.handleCommand(_command('Pause', when: DateTime.now().toUtc()), SyncPlayState());
      await _settle();

      expect(seekCalls, 0);
    });

    test('Stop runs the stop callback', () async {
      var stopCalls = 0;
      var pauseCalls = 0;
      final handler = SyncPlayCommandHandler(timeSync: () => null, onStateUpdate: (_) {})
        ..onStop = () async {
          stopCalls++;
        }
        ..onPause = () async {
          pauseCalls++;
        };

      handler.handleCommand(_command('Stop', when: DateTime.now().toUtc(), playlistItemId: ''), SyncPlayState());
      await _settle();

      expect(stopCalls, 1);
      expect(pauseCalls, 0);
    });
  });
}
