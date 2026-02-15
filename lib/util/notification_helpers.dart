import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';

MapEntry<String, String?> notificationTitleBodyForItem(ItemBaseModel it, AppLocalizations? l10n) {
  final unknown = l10n?.unknown ?? 'Unknown';
  final newEpisodes = l10n?.notificationNewEpisodes ?? 'New episodes added';

  if (it is EpisodeModel) {
    final title = it.seriesName ?? it.name;
    final sub = l10n != null ? it.subTextShort(l10n) : null;
    final body =
        '${sub ?? (it.subText ?? '')}${(sub?.isNotEmpty ?? false) ? ' - ' : ''}${it.name.isNotEmpty ? it.name : unknown}';
    return MapEntry(title, body);
  }

  if (it.type == FladderItemType.movie) {
    final year = it.overview.yearAired;
    final title = (year != null && year > 0) ? '${it.name} ($year)' : it.name;
    return MapEntry(title, null);
  }

  if (it.type == FladderItemType.series) {
    return MapEntry(it.name, newEpisodes);
  }

  return MapEntry(it.name.isNotEmpty ? it.name : unknown, null);
}

String buildDetailsDeepLink(String id) => 'fladder:///details?id=${Uri.encodeComponent(id)}';

List<LastSeenModel> replaceOrAppendLastSeen(List<LastSeenModel> servers, LastSeenModel saved) {
  final exists = servers.any((s) => s.userId == saved.userId);
  if (exists) return servers.map((s) => s.userId == saved.userId ? saved : s).toList();
  return [...servers, saved];
}

String buildLatestItemsUrl(String baseUrl, String userId, int limit) {
  final trimmed = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
  return '$trimmed/Users/$userId/Items/Latest?Limit=$limit&EnableUserData=false&EnableImages=false&ImageTypeLimit=0&Fields=OriginalTitle,DateCreated,DateLastMediaAdded';
}
