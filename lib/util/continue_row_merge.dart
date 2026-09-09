List<T> mergeContinueRow<T>({
  required Iterable<T> nextUp,
  required Iterable<T> resume,
  required String Function(T item) idOf,
  required String? Function(T item) seriesIdOf,
  required DateTime? Function(T item) lastPlayedOf,
}) {
  final nextUpItems = <T>[];
  final nextUpIds = <String>{};
  final seriesIds = <String>{};

  for (final item in nextUp) {
    final id = idOf(item);
    final seriesId = seriesIdOf(item);
    if (nextUpIds.contains(id) || (seriesId?.isNotEmpty == true && seriesIds.contains(seriesId))) continue;

    nextUpIds.add(id);
    if (seriesId?.isNotEmpty == true) seriesIds.add(seriesId!);
    nextUpItems.add(item);
  }

  final resumeItems = <T>[];
  final resumeIds = <String>{};
  for (final item in resume) {
    final id = idOf(item);
    final seriesId = seriesIdOf(item);
    if (nextUpIds.contains(id) ||
        resumeIds.contains(id) ||
        (seriesId?.isNotEmpty == true && seriesIds.contains(seriesId))) {
      continue;
    }

    resumeIds.add(id);
    if (seriesId?.isNotEmpty == true) seriesIds.add(seriesId!);
    resumeItems.add(item);
  }

  final result = <T>[];
  var resumeIndex = 0;
  for (final item in nextUpItems) {
    final anchor = lastPlayedOf(item);
    if (anchor != null) {
      while (resumeIndex < resumeItems.length) {
        final lastPlayed = lastPlayedOf(resumeItems[resumeIndex]);
        if (lastPlayed == null || !lastPlayed.isAfter(anchor)) break;
        result.add(resumeItems[resumeIndex++]);
      }
    }
    result.add(item);
  }

  result.addAll(resumeItems.skip(resumeIndex));
  return result;
}
