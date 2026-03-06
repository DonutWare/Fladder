class FladderConfig {
  static FladderConfig _instance = FladderConfig._();
  FladderConfig._();

  static String? get baseUrl => _instance._baseUrl;
  static set baseUrl(String? value) => _instance._baseUrl = value;
  String? _baseUrl;

  static String? get seerrBaseUrl => _instance._seerrBaseUrl;
  static set seerrBaseUrl(String? value) => _instance._seerrBaseUrl = value;
  String? _seerrBaseUrl;

  static Map<String, String>? get seerrHeader => _instance._seerrHeader;
  static set seerrHeader(Map<String, String>? value) => _instance._seerrHeader = value;
  Map<String, String>? _seerrHeader;

  static void fromJson(Map<String, dynamic> json) => _instance = FladderConfig._fromJson(json);

  factory FladderConfig._fromJson(Map<String, dynamic> json) {
    final config = FladderConfig._();
    final newUrl = json['baseUrl'] as String?;
    final newSeerrUrl = json['seerrBaseUrl'] as String?;
    final newSeerrHeader = json['seerrHeader'];

    config._baseUrl = newUrl?.isEmpty == true ? null : newUrl;
    config._seerrBaseUrl = newSeerrUrl?.isEmpty == true ? null : newSeerrUrl;
    if (newSeerrHeader is Map<String, String>) {
      final parsed = newSeerrHeader.map((key, value) => MapEntry(key, value));
      config._seerrHeader = parsed.isEmpty ? null : parsed;
    }

    return config;
  }
}
