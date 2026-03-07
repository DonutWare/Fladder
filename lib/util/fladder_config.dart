class FladderConfig {
  static FladderConfig _instance = FladderConfig._();
  FladderConfig._();

  static String? get baseUrl => _instance._baseUrl;
  static set baseUrl(String? value) => _instance._baseUrl = value;
  String? _baseUrl;

  static String? get baseUrlSeerr => _instance._baseUrlSeerr;
  static set baseUrlSeerr(String? value) => _instance._baseUrlSeerr = value;
  String? _baseUrlSeerr;

  static void fromJson(Map<String, dynamic> json) => _instance = FladderConfig._fromJson(json);

  factory FladderConfig._fromJson(Map<String, dynamic> json) {
    final config = FladderConfig._();
    final newUrl = json['baseUrl'] as String?;
    config._baseUrl = newUrl?.isEmpty == true ? null : newUrl;
    final newSeerrBaseUrl = json['baseUrlSeerr'] as String?;
    config._baseUrlSeerr = newSeerrBaseUrl?.isEmpty == true ? null : newSeerrBaseUrl;
    return config;
  }
}
