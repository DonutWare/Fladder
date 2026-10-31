import 'package:fladder/providers/syncplay/buffering_report_debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

// Real timers with a short threshold: fake_async is not a direct dependency of the app.
const _threshold = Duration(milliseconds: 200);

Future<void> _wait(int milliseconds) => Future<void>.delayed(Duration(milliseconds: milliseconds));

BufferingReportDebouncer _debouncer(List<String> calls, {Duration threshold = _threshold}) {
  return BufferingReportDebouncer(
    threshold: threshold,
    onBuffering: () => calls.add('buffering'),
    onReady: () => calls.add('ready'),
  );
}

void main() {
  group('BufferingReportDebouncer', () {
    test('a stall shorter than the threshold is never reported', () async {
      final calls = <String>[];
      final debouncer = _debouncer(calls);

      debouncer.update(true);
      await _wait(20);
      debouncer.update(false);
      await _wait(320);

      expect(calls, isEmpty);
      expect(debouncer.isPending, isFalse);
      debouncer.dispose();
    });

    test('a stall held past the threshold is reported once and closed once', () async {
      final calls = <String>[];
      final debouncer = _debouncer(calls);

      debouncer.update(true);
      debouncer.update(true); // duplicate frames must not restart the timer
      await _wait(320);
      expect(calls, ['buffering']);
      expect(debouncer.isReported, isTrue);

      debouncer.update(false);
      debouncer.update(false);
      expect(calls, ['buffering', 'ready']);
      expect(debouncer.isReported, isFalse);
      debouncer.dispose();
    });

    test('duplicate true frames do not extend the threshold', () async {
      final calls = <String>[];
      final debouncer = _debouncer(calls);

      debouncer.update(true);
      await _wait(120);
      debouncer.update(true);
      await _wait(120);

      expect(calls, ['buffering'], reason: 'the first frame started the timer; the second must not restart it');
      debouncer.dispose();
    });

    test('reset drops a pending stall and a reported one silently', () async {
      final calls = <String>[];
      final debouncer = _debouncer(calls);

      debouncer.update(true);
      debouncer.reset();
      await _wait(320);
      expect(calls, isEmpty);

      debouncer.update(true);
      await _wait(320);
      debouncer.reset();
      debouncer.update(false);
      expect(calls, ['buffering']);
      debouncer.dispose();
    });

    test('a ready frame with nothing reported is silent', () async {
      final calls = <String>[];
      final debouncer = _debouncer(calls);

      debouncer.update(false);
      debouncer.update(false);

      expect(calls, isEmpty);
      debouncer.dispose();
    });
  });
}
