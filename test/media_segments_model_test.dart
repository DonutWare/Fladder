import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/models/items/media_segments_model.dart';

void main() {
  final intro = MediaSegment(
    type: MediaSegmentType.intro,
    start: Duration.zero,
    end: const Duration(seconds: 33, milliseconds: 617),
  );

  test('a segment includes its start and excludes its end', () {
    expect(intro.inRange(Duration.zero), isTrue);
    expect(intro.inRange(const Duration(seconds: 33, milliseconds: 616)), isTrue);
    expect(intro.inRange(intro.end), isFalse);
  });

  test('skipping to the end of a segment leaves it', () {
    final segments = MediaSegmentsModel(segments: [intro]);
    expect(segments.atPosition(const Duration(seconds: 10)), intro);
    expect(segments.atPosition(intro.end), isNull);
  });

  test('back-to-back segments hand over at the boundary', () {
    final recap = MediaSegment(type: MediaSegmentType.recap, start: Duration.zero, end: const Duration(seconds: 20));
    final next = MediaSegment(
      type: MediaSegmentType.intro,
      start: const Duration(seconds: 20),
      end: const Duration(seconds: 50),
    );
    final segments = MediaSegmentsModel(segments: [recap, next]);
    expect(segments.atPosition(const Duration(seconds: 20)), next);
  });
}
