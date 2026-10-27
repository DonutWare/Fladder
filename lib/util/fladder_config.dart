class FladderConfig {
  static FladderConfig _instance = FladderConfig._();
  FladderConfig._();

  static String? get baseUrl => _instance._baseUrl;
  static set baseUrl(String? value) => _instance._baseUrl = value;
  String? _baseUrl;

  static String? get seerrBaseUrl => _instance._seerrBaseUrl;
  static set seerrBaseUrl(String? value) => _instance._seerrBaseUrl = value;
  String? _seerrBaseUrl;

  static String? get seerrProxyPath => _instance._seerrProxyPath;
  static set seerrProxyPath(String? value) => _instance._seerrProxyPath = value;
  String? _seerrProxyPath;

  static void fromJson(Map<String, dynamic> json) => _instance = FladderConfig._fromJson(json);

  factory FladderConfig._fromJson(Map<String, dynamic> json) {
    final config = FladderConfig._();
    config._baseUrl = _nonEmpty(json['baseUrl'] as String?);
    config._seerrBaseUrl = _nonEmpty(json['seerrBaseUrl'] as String?);
    config._seerrProxyPath = _nonEmpty(json['seerrProxyPath'] as String?);
    return config;
  }

  static String? _nonEmpty(String? s) => s?.isEmpty == true ? null : s;
}
