import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

/// PlaybackInfo may filter or reorder the item's original media sources.
MediaSourceInfo? selectPlaybackMediaSource(
  List<MediaSourceInfo>? sources,
  String? selectedId,
) {
  if (sources == null || sources.isEmpty) return null;
  if (selectedId == null || selectedId.isEmpty) return sources.first;

  for (final source in sources) {
    if (source.id?.toLowerCase() == selectedId.toLowerCase()) return source;
  }
  return null;
}
