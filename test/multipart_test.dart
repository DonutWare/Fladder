import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/api_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final l10n = lookupAppLocalizations(const Locale('en'));

  final refProvider = Provider<Ref>((ref) => ref);

  ProviderContainer createContainer() {
    final container = ProviderContainer(overrides: [
      serverUrlProvider.overrideWith((ref) => 'https://example.com'),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  dto.BaseItemDto baseDto({
    String? id,
    String? name,
    enums.BaseItemKind? type,
    String? parentId,
    String? seriesId,
    int? partCount,
    int? indexNumber,
    int? parentIndexNumber,
    int? runTimeTicks,
    dto.UserItemDataDto? userData,
    List<dto.MediaSourceInfo>? mediaSources,
  }) {
    return dto.BaseItemDto(
      id: id,
      name: name,
      type: type,
      parentId: parentId,
      seriesId: seriesId,
      partCount: partCount,
      indexNumber: indexNumber,
      parentIndexNumber: parentIndexNumber,
      runTimeTicks: runTimeTicks,
      userData: userData,
      mediaSources: mediaSources,
    );
  }

  group('partCount detection', () {
    test('ItemStreamModel defaults to a single part', () {
      final model = ItemStreamModel.fromBaseDto(
        baseDto(id: 'video1', name: 'Generic video', type: enums.BaseItemKind.video),
        null,
      );

      expect(model.partCount, 1);
      expect(model.hasMultipleParts, isFalse);
    });

    test('ItemStreamModel maps the server part count', () {
      final model = ItemStreamModel.fromBaseDto(
        baseDto(id: 'video1', name: 'Generic video', type: enums.BaseItemKind.video, partCount: 3),
        null,
      );

      expect(model.partCount, 3);
      expect(model.hasMultipleParts, isTrue);
    });

    test('MovieModel maps partCount in both factory branches', () {
      final withoutRef = MovieModel.fromBaseDto(
        baseDto(id: 'movie1', name: 'Movie', type: enums.BaseItemKind.movie, partCount: 3),
        null,
      );
      expect(withoutRef.partCount, 3);
      expect(withoutRef.hasMultipleParts, isTrue);

      final ref = createContainer().read(refProvider);
      final withRef = MovieModel.fromBaseDto(
        baseDto(id: 'movie1', name: 'Movie', type: enums.BaseItemKind.movie, partCount: 2),
        ref,
      );
      expect(withRef.partCount, 2);
      expect(withRef.hasMultipleParts, isTrue);
    });

    test('single-part movies stay unchanged', () {
      final model = MovieModel.fromBaseDto(
        baseDto(id: 'movie1', name: 'Movie', type: enums.BaseItemKind.movie),
        null,
      );

      expect(model.partCount, 1);
      expect(model.hasMultipleParts, isFalse);
    });

    test('EpisodeModel maps partCount in both factory branches', () {
      final withoutRef = EpisodeModel.fromBaseDto(
        baseDto(
          id: 'episode1',
          name: 'Episode',
          type: enums.BaseItemKind.episode,
          seriesId: 'series1',
          parentIndexNumber: 1,
          indexNumber: 1,
          partCount: 2,
        ),
        null,
      );
      expect(withoutRef.partCount, 2);
      expect(withoutRef.hasMultipleParts, isTrue);

      final ref = createContainer().read(refProvider);
      final withRef = EpisodeModel.fromBaseDto(
        baseDto(
          id: 'episode1',
          name: 'Episode',
          type: enums.BaseItemKind.episode,
          seriesId: 'series1',
          parentIndexNumber: 1,
          indexNumber: 1,
          partCount: 2,
        ),
        ref,
      );
      expect(withRef.partCount, 2);
      expect(withRef.hasMultipleParts, isTrue);
    });
  });

  group('VideoPartModel', () {
    test('fromBaseDto maps part metadata and item fields', () {
      final model = VideoPartModel.fromBaseDto(
        baseDto(
          id: 'part2',
          name: 'Movie cd2',
          type: enums.BaseItemKind.video,
          parentId: 'folder1',
          runTimeTicks: const Duration(minutes: 45).inMilliseconds * 10000,
          userData: const dto.UserItemDataDto(
            playbackPositionTicks: 123,
            playedPercentage: 12.5,
          ),
        ),
        null,
        parentItemId: 'movie1',
        partNumber: 2,
        totalParts: 3,
      );

      expect(model.id, 'part2');
      expect(model.name, 'Movie cd2');
      expect(model.parentItemId, 'movie1');
      expect(model.parentId, 'folder1');
      expect(model.partNumber, 2);
      expect(model.totalParts, 3);
      expect(model.partCount, 3);
      expect(model.hasMultipleParts, isTrue);
      expect(model.overview.runTime, const Duration(minutes: 45));
      expect(model.userData.playbackPositionTicks, 123);
      expect(model.userData.progress, 12.5);
    });

    test('uses the logical parent and video item type', () {
      final model = VideoPartModel.fromBaseDto(
        baseDto(id: 'part2', name: 'Movie cd2', type: enums.BaseItemKind.video),
        null,
        parentItemId: 'movie1',
        partNumber: 2,
        totalParts: 3,
      );

      expect(model.parentBaseModel.id, 'movie1');
      expect(model.type, FladderItemType.video);
      expect(model.syncAble, isFalse);
      expect(model.title, 'Movie cd2');
    });

    test('localized labels use the part number', () {
      final model = VideoPartModel.fromBaseDto(
        baseDto(id: 'part2', name: 'Movie cd2', type: enums.BaseItemKind.video),
        null,
        parentItemId: 'movie1',
        partNumber: 2,
        totalParts: 3,
      );

      expect(model.subTextShort(l10n), 'Part 2');
      expect(model.detailedName(l10n), 'Part 2 - Movie cd2');
      expect(model.label(l10n), 'Part 2 - Movie cd2');
      expect(model.playButtonLabel(l10n), 'Play Part 2');
    });

    test('is only playable when media streams are available', () {
      final withoutStreams = VideoPartModel.fromBaseDto(
        baseDto(id: 'part2', name: 'Part 2', type: enums.BaseItemKind.video),
        null,
        parentItemId: 'movie1',
        partNumber: 2,
        totalParts: 3,
      );
      expect(withoutStreams.playAble, isFalse);

      final ref = createContainer().read(refProvider);
      final withStreams = VideoPartModel.fromBaseDto(
        baseDto(
          id: 'part2',
          name: 'Part 2',
          type: enums.BaseItemKind.video,
          mediaSources: [
            const dto.MediaSourceInfo(
              id: 'source1',
              mediaStreams: [
                dto.MediaStream(
                  type: enums.MediaStreamType.video,
                  index: 0,
                  codec: 'h264',
                ),
              ],
            ),
          ],
        ),
        ref,
        parentItemId: 'movie1',
        partNumber: 2,
        totalParts: 3,
      );
      expect(withStreams.playAble, isTrue);
    });

    test('fromDtos numbers parts starting at 2 and preserves server order', () {
      final ref = createContainer().read(refProvider);

      final parts = VideoPartModel.fromDtos(
        [
          baseDto(id: 'part2', name: 'Part 2', type: enums.BaseItemKind.video),
          baseDto(id: 'part3', name: 'Part 3', type: enums.BaseItemKind.video),
          baseDto(id: 'part4', name: 'Part 4', type: enums.BaseItemKind.video),
        ],
        ref,
        parentItemId: 'movie1',
        totalParts: 4,
      );

      expect(parts.map((part) => part.id), ['part2', 'part3', 'part4']);
      expect(parts.map((part) => part.partNumber), [2, 3, 4]);
      expect(parts.every((part) => part.totalParts == 4), isTrue);
      expect(parts.every((part) => part.partCount == 4), isTrue);
      expect(parts.every((part) => part.parentItemId == 'movie1'), isTrue);
      expect(parts.every((part) => part.hasMultipleParts), isTrue);
    });

    test('fromDtos returns an empty list for a missing response', () {
      final ref = createContainer().read(refProvider);

      final parts = VideoPartModel.fromDtos(
        null,
        ref,
        parentItemId: 'movie1',
        totalParts: 1,
      );

      expect(parts, isEmpty);
    });
  });

  group('Playback queue expansion', () {
    MovieModel movie(String id) => MovieModel.fromBaseDto(
          baseDto(id: id, name: 'Movie $id', type: enums.BaseItemKind.movie),
          null,
        );

    EpisodeModel episode(String id, int index) => EpisodeModel.fromBaseDto(
          baseDto(
            id: id,
            name: 'Episode $index',
            type: enums.BaseItemKind.episode,
            seriesId: 'series1',
            parentIndexNumber: 1,
            indexNumber: index,
          ),
          null,
        );

    VideoPartModel part(String id, String parentId, int number, int total) => VideoPartModel.fromBaseDto(
          baseDto(id: id, name: 'Part $number', type: enums.BaseItemKind.video),
          null,
          parentItemId: parentId,
          partNumber: number,
          totalParts: total,
        );

    test('inserts parts directly after a movie', () {
      final result = PlaybackModelHelper.interleaveParts(
        [movie('movie1')],
        {
          'movie1': [
            part('p2', 'movie1', 2, 3),
            part('p3', 'movie1', 3, 3),
          ],
        },
      );

      expect(result.map((item) => item.id), ['movie1', 'p2', 'p3']);
    });

    test('interleaves parts for multiple episodes', () {
      final result = PlaybackModelHelper.interleaveParts(
        [episode('ep1', 1), episode('ep2', 2)],
        {
          'ep1': [part('ep1p2', 'ep1', 2, 2)],
          'ep2': [
            part('ep2p2', 'ep2', 2, 3),
            part('ep2p3', 'ep2', 3, 3),
          ],
        },
      );

      expect(result.map((item) => item.id), ['ep1', 'ep1p2', 'ep2', 'ep2p2', 'ep2p3']);
    });

    test('is idempotent for an already expanded queue', () {
      final expanded = [
        episode('ep1', 1),
        part('ep1p2', 'ep1', 2, 2),
        episode('ep2', 2),
        part('ep2p2', 'ep2', 2, 2),
      ];

      final result = PlaybackModelHelper.interleaveParts(
        expanded,
        {
          'ep1': [part('ep1p2', 'ep1', 2, 2)],
          'ep2': [part('ep2p2', 'ep2', 2, 2)],
        },
      );

      expect(result.map((item) => item.id), ['ep1', 'ep1p2', 'ep2', 'ep2p2']);
    });

    test('does not duplicate parts already present in the queue', () {
      final existing = part('p2', 'movie1', 2, 3);
      final result = PlaybackModelHelper.interleaveParts(
        [movie('movie1'), existing],
        {
          'movie1': [existing, part('p3', 'movie1', 3, 3)],
        },
      );

      expect(result.map((item) => item.id), ['movie1', 'p2', 'p3']);
    });

    test('ignores parts whose parent is not in the queue', () {
      final result = PlaybackModelHelper.interleaveParts(
        [movie('movie1')],
        {
          'other': [part('otherp2', 'other', 2, 2)],
        },
      );

      expect(result.map((item) => item.id), ['movie1']);
    });

    test('deduplicates repeated queue entries by id', () {
      final ep1 = episode('ep1', 1);

      final result = PlaybackModelHelper.interleaveParts([ep1, ep1], const {});

      expect(result.map((item) => item.id), ['ep1']);
    });
  });
}
