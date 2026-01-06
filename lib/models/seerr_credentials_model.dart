// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'seerr_credentials_model.freezed.dart';
part 'seerr_credentials_model.g.dart';

@Freezed(copyWith: true)
abstract class SeerrCredentialsModel with _$SeerrCredentialsModel {
  const SeerrCredentialsModel._();

  const factory SeerrCredentialsModel({
    @Default("") String serverUrl,
    @Default("") String apiKey,
    @Default("") String sessionCookie,
  }) = _SeerrCredentialsModel;

  bool get isConfigured {
    return serverUrl.isNotEmpty && (apiKey.isNotEmpty || sessionCookie.isNotEmpty);
  }

  factory SeerrCredentialsModel.fromJson(Map<String, dynamic> json) => _$SeerrCredentialsModelFromJson(json);
}
