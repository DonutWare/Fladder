import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/util/continue_row_merge.dart';

typedef _Item = ({String id, String? seriesId, DateTime? lastPlayed});

void main() {
  final newer = DateTime.utc(2026, 9, 4);
  final middle = DateTime.utc(2026, 9, 3);
  final older = DateTime.utc(2026, 9, 2);

  _Item item(String id, {String? seriesId, DateTime? lastPlayed}) =>
      (id: id, seriesId: seriesId, lastPlayed: lastPlayed);

  List<String> merge({List<_Item> nextUp = const [], List<_Item> resume = const []}) => mergeContinueRow(
        nextUp: nextUp,
        resume: resume,
        idOf: (item) => item.id,
        seriesIdOf: (item) => item.seriesId,
        lastPlayedOf: (item) => item.lastPlayed,
      ).map((item) => item.id).toList();

  test('keeps a series that only occurs in Next Up', () {
    expect(merge(nextUp: [item('next', seriesId: 'series')]), ['next']);
  });

  test('prefers the Next Up item over resume entries from the same series or with the same id', () {
    expect(
      merge(
        nextUp: [item('next', seriesId: 'series', lastPlayed: newer)],
        resume: [
          item('resume', seriesId: 'series', lastPlayed: newer),
          item('next', seriesId: 'other-series', lastPlayed: older),
        ],
      ),
      ['next'],
    );
  });

  test('inserts a movie between two dated Next Up anchors', () {
    expect(
      merge(
        nextUp: [
          item('new-series', seriesId: 'new-series', lastPlayed: newer),
          item('undated-series', seriesId: 'undated-series'),
          item('old-series', seriesId: 'old-series', lastPlayed: older),
        ],
        resume: [item('movie', lastPlayed: middle)],
      ),
      ['new-series', 'undated-series', 'movie', 'old-series'],
    );
  });

  test('inserts a movie newer than every anchor at the front', () {
    expect(
      merge(
        nextUp: [item('series', seriesId: 'series', lastPlayed: middle)],
        resume: [item('movie', lastPlayed: newer)],
      ),
      ['movie', 'series'],
    );
  });

  test('keeps one resume episode whose series has no Next Up item', () {
    expect(
      merge(
        nextUp: [item('series', seriesId: 'series', lastPlayed: older)],
        resume: [
          item('missing-next-up', seriesId: 'missing-series', lastPlayed: newer),
          item('older-resume', seriesId: 'missing-series', lastPlayed: middle),
        ],
      ),
      ['missing-next-up', 'series'],
    );
  });

  test('returns an empty list for empty inputs', () {
    expect(merge(), isEmpty);
  });
}
