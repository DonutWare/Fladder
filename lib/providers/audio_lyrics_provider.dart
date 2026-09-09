import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

final audioLyricsProvider = StateNotifierProvider<AudioLyricsNotifier, AudioLyricsState>(
  (ref) => AudioLyricsNotifier(ref),
);

class AudioLyricsState {
  final String? itemId;
  final List<SyncedLyricLine> rawLines;
  final Duration? trackDuration;
  final int activeLineIndex;
  final bool loading;
  final bool autoFollow;

  const AudioLyricsState({
    this.itemId,
    this.rawLines = const <SyncedLyricLine>[],
    this.trackDuration,
    this.activeLineIndex = -1,
    this.loading = false,
    this.autoFollow = true,
  });

  List<SyncedLyricLine> get lines {
    return AudioLyricsTimelineBuilder.injectInstrumentalGaps(
      rawLines,
      trackDuration: trackDuration,
    );
  }

  bool get hasLyrics => rawLines.isNotEmpty;

  AudioLyricsState copyWith({
    String? itemId,
    List<SyncedLyricLine>? rawLines,
    Duration? trackDuration,
    int? activeLineIndex,
    bool? loading,
    bool? autoFollow,
  }) {
    return AudioLyricsState(
      itemId: itemId ?? this.itemId,
      rawLines: rawLines ?? this.rawLines,
      trackDuration: trackDuration ?? this.trackDuration,
      activeLineIndex: activeLineIndex ?? this.activeLineIndex,
      loading: loading ?? this.loading,
      autoFollow: autoFollow ?? this.autoFollow,
    );
  }

  @override
  String toString() {
    return 'AudioLyricsState(itemId: $itemId, lines: ${lines.length}, activeLineIndex: $activeLineIndex, loading: $loading, autoFollow: $autoFollow)';
  }
}

class SyncedLyricLine {
  final String text;
  final Duration start;
  final bool isInstrumentalGap;

  const SyncedLyricLine({
    required this.text,
    required this.start,
    this.isInstrumentalGap = false,
  });
}

class AudioLyricsTimelineBuilder {
  static const Duration instrumentalGapThreshold = Duration(seconds: 10);

  static bool isSyncedLyricPayload(LyricDto? body) {
    if (body == null) {
      return false;
    }

    if (body.metadata?.isSynced == true) {
      return true;
    }

    final rawLines = body.lyrics ?? const <LyricLine>[];
    return rawLines.any((line) => (line.start ?? 0) > 0 && (line.text ?? '').trim().isNotEmpty);
  }

  static List<SyncedLyricLine> parseSyncedLines(LyricDto? body) {
    if (!isSyncedLyricPayload(body)) {
      return const <SyncedLyricLine>[];
    }

    return _parseLines(
      body?.lyrics ?? const <LyricLine>[],
      offsetMs: body?.metadata?.offset ?? 0,
    );
  }

  static List<SyncedLyricLine> buildTimeline(
    LyricDto? body, {
    Duration? trackDuration,
  }) {
    final parsed = parseSyncedLines(body);
    return injectInstrumentalGaps(
      parsed,
      trackDuration: trackDuration,
    );
  }

  static List<SyncedLyricLine> _parseLines(
    List<LyricLine> lines, {
    required int offsetMs,
  }) {
    final parsed = lines
        .map(
          (line) => SyncedLyricLine(
            text: (line.text ?? '').trim(),
            start: _parseLyricStart(line.start, offsetMs),
          ),
        )
        .where((line) => line.text.isNotEmpty)
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    return parsed;
  }

  static Duration _parseLyricStart(int? value, int offsetMs) {
    if (value == null || value <= 0) {
      return Duration.zero;
    }

    final base = value > 10000000 ? Duration(microseconds: value ~/ 10) : Duration(milliseconds: value);
    final adjusted = base + Duration(milliseconds: offsetMs);
    return adjusted.isNegative ? Duration.zero : adjusted;
  }

  static List<SyncedLyricLine> injectInstrumentalGaps(
    List<SyncedLyricLine> lyrics, {
    Duration? trackDuration,
  }) {
    if (lyrics.isEmpty) {
      return const <SyncedLyricLine>[];
    }

    final sourceLyrics = lyrics.where((line) => !line.isInstrumentalGap).toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    if (sourceLyrics.isEmpty) {
      return const <SyncedLyricLine>[];
    }

    final timeline = <SyncedLyricLine>[];
    final first = sourceLyrics.first;

    if (first.start > instrumentalGapThreshold) {
      _addGapMarkers(
        timeline,
        from: Duration.zero,
        to: first.start,
        includeStart: true,
      );
    }

    for (var i = 0; i < sourceLyrics.length; i++) {
      final current = sourceLyrics[i];
      timeline.add(current);

      if (i + 1 >= sourceLyrics.length) {
        break;
      }

      final next = sourceLyrics[i + 1];
      _addGapMarkers(
        timeline,
        from: current.start,
        to: next.start,
      );
    }

    final lastLyric = sourceLyrics.last;
    if (trackDuration != null) {
      _addGapMarkers(
        timeline,
        from: lastLyric.start,
        to: trackDuration,
      );
    }

    timeline.sort((a, b) => a.start.compareTo(b.start));
    return timeline;
  }

  static void _addGapMarkers(
    List<SyncedLyricLine> timeline, {
    required Duration from,
    required Duration to,
    bool includeStart = false,
  }) {
    final gap = to - from;
    if (gap <= instrumentalGapThreshold) {
      return;
    }

    if (includeStart) {
      timeline.add(
        const SyncedLyricLine(
          text: '',
          start: Duration.zero,
          isInstrumentalGap: true,
        ),
      );
      return;
    }

    timeline.add(
      SyncedLyricLine(
        text: '',
        start: from + instrumentalGapThreshold,
        isInstrumentalGap: true,
      ),
    );
  }
}

class AudioLyricsNotifier extends StateNotifier<AudioLyricsState> {
  AudioLyricsNotifier(this.ref) : super(const AudioLyricsState());

  final Ref ref;

  final Map<String, List<SyncedLyricLine>> _cache = <String, List<SyncedLyricLine>>{};

  Future<void> loadForTrack(String? itemId) async {
    if (itemId == null || itemId.isEmpty) {
      state = const AudioLyricsState();
      return;
    }

    if (state.itemId == itemId && (state.loading || state.lines.isNotEmpty)) {
      return;
    }

    final cachedLines = _cache[itemId];
    final trackDuration = ref.read(playBackModel)?.item.overview.runTime;
    if (cachedLines != null) {
      final timeline = AudioLyricsTimelineBuilder.injectInstrumentalGaps(
        cachedLines,
        trackDuration: trackDuration,
      );
      final activeIndex = _findActiveIndex(
        ref.read(mediaPlaybackProvider).position,
        timeline,
      );
      state = AudioLyricsState(
        itemId: itemId,
        rawLines: cachedLines,
        trackDuration: trackDuration,
        activeLineIndex: activeIndex,
        loading: false,
        autoFollow: true,
      );
      return;
    }

    state = AudioLyricsState(
      itemId: itemId,
      rawLines: const <SyncedLyricLine>[],
      trackDuration: trackDuration,
      activeLineIndex: -1,
      loading: true,
      autoFollow: true,
    );

    final response = await ref.read(jellyApiProvider).audioItemIdLyricsGet(itemId: itemId);
    final body = response.body;
    final rawLines = AudioLyricsTimelineBuilder.parseSyncedLines(body);
    final timeline = AudioLyricsTimelineBuilder.injectInstrumentalGaps(rawLines, trackDuration: trackDuration);

    if (timeline.isEmpty) {
      state = AudioLyricsState(
        itemId: itemId,
        rawLines: const <SyncedLyricLine>[],
        trackDuration: trackDuration,
        activeLineIndex: -1,
        loading: false,
        autoFollow: true,
      );
      return;
    }

    _cache[itemId] = rawLines;
    final activeIndex = _findActiveIndex(ref.read(mediaPlaybackProvider).position, timeline);

    state = AudioLyricsState(
      itemId: itemId,
      rawLines: rawLines,
      trackDuration: trackDuration,
      activeLineIndex: activeIndex,
      loading: false,
      autoFollow: true,
    );
  }

  void updatePosition(Duration position) {
    if (!state.hasLyrics) {
      return;
    }

    final nextActive = _findActiveIndex(position, state.lines);
    if (nextActive == state.activeLineIndex) {
      return;
    }

    state = state.copyWith(activeLineIndex: nextActive);
  }

  void detachSync() {
    if (!state.autoFollow) {
      return;
    }

    state = state.copyWith(autoFollow: false);
  }

  void returnToSync() {
    if (state.autoFollow) {
      return;
    }

    state = state.copyWith(autoFollow: true);
  }

  void clear() {
    state = const AudioLyricsState();
  }

  Future<void> seekToLine(SyncedLyricLine line) async {
    await ref.read(videoPlayerProvider).seek(line.start);
    updatePosition(line.start);
  }

  int _findActiveIndex(Duration position, List<SyncedLyricLine> lines) {
    if (lines.isEmpty) {
      return -1;
    }

    if (position < lines.first.start) {
      return -1;
    }

    var active = 0;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].start <= position) {
        active = i;
      } else {
        break;
      }
    }
    return active;
  }
}
