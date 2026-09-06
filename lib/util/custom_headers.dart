/// Mirror of the custom headers configured for the server that is currently in
/// use.
///
/// API calls read their headers from the active credentials, but cached
/// images and the media players fire their requests outside of Riverpod's
/// reach. Those consumers read the active headers from here instead;
/// [update] keeps this in sync with the credentials of the active connection.
///
/// Headers are only handed out for URLs pointing at a known server host. Third
/// party artwork (TMDB for example) travels through the same image cache and
/// must never carry the user's credentials.
class ServerCustomHeaders {
  ServerCustomHeaders._();

  static Map<String, String> _headers = const {};
  static Set<String> _hosts = const {};

  /// Replaces the mirrored headers with [headers], applied to the hosts of
  /// [serverUrls]. Entries that are not parseable URLs are ignored.
  static void update({
    required Map<String, String> headers,
    required Iterable<String?> serverUrls,
  }) {
    if (headers.isEmpty) {
      _headers = const {};
      _hosts = const {};
      return;
    }

    final hosts = <String>{};
    for (final url in serverUrls) {
      final host = _hostOf(url);
      if (host != null) hosts.add(host);
    }

    _headers = Map.unmodifiable(headers);
    _hosts = Set.unmodifiable(hosts);
  }

  static void clear() => update(headers: const {}, serverUrls: const []);

  /// Headers to attach to a request for [url]; empty when [url] does not point
  /// at the active server.
  static Map<String, String> forUrl(String? url) {
    if (_headers.isEmpty || url == null || url.isEmpty) return const {};
    return forUri(Uri.tryParse(url));
  }

  /// Headers to attach to a request for [uri]; empty when [uri] does not point
  /// at the active server.
  static Map<String, String> forUri(Uri? uri) {
    if (_headers.isEmpty || uri == null) return const {};
    return _hosts.contains(uri.host.toLowerCase()) ? _headers : const {};
  }

  static String? _hostOf(String? url) {
    final trimmed = url?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    final host = Uri.tryParse(trimmed)?.host.toLowerCase();
    return host == null || host.isEmpty ? null : host;
  }
}

/// Reads a persisted custom header map back into a `Map<String, String>`,
/// dropping anything that is not a usable header name.
Map<String, String> parseCustomHeaders(Object? value) {
  if (value is! Map) return const {};
  final headers = <String, String>{};
  for (final entry in value.entries) {
    final name = entry.key?.toString().trim() ?? '';
    if (name.isEmpty) continue;
    headers[name] = entry.value?.toString() ?? '';
  }
  return headers;
}
