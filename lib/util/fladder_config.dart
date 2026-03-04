class FladderConfig {
  static FladderConfig _instance = FladderConfig._();
  FladderConfig._();

  static String? get baseUrl => _instance._baseUrl;
  static set baseUrl(String? value) => _instance._baseUrl = value;
  String? _baseUrl;

  static String? get seerrUrl => _instance._seerrUrl;
  static set seerrUrl(String? value) => _instance._seerrUrl = value;
  String? _seerrUrl;

  static void fromJson(Map<String, dynamic> json) => _instance = FladderConfig._fromJson(json);

  factory FladderConfig._fromJson(Map<String, dynamic> json) {
    final config = FladderConfig._();
    final newUrl = json['baseUrl'] as String?;
    config._baseUrl = newUrl?.isEmpty == true ? null : newUrl;
    final newSeerrUrl = json['seerrUrl'] as String?;
    config._seerrUrl = newSeerrUrl?.isEmpty == true ? null : newSeerrUrl;
    return config;
  }
}
