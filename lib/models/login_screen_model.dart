import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/credentials_model.dart';

part 'login_screen_model.freezed.dart';

enum LoginScreenType {
  users,
  login,
  code,
}

@Freezed(copyWith: true)
abstract class LoginScreenModel with _$LoginScreenModel {
  factory LoginScreenModel({
    @Default([]) List<AccountModel> accounts,
    @Default(LoginScreenType.users) LoginScreenType screen,
    ServerLoginModel? serverLoginModel,
    String? errorMessage,
    @Default(false) bool hasBaseUrl,
    @Default(false) bool loading,
    String? tempSeerrUrl,
    String? tempSeerrSessionCookie,
  }) = _LoginScreenModel;
}

@Freezed(copyWith: true)
abstract class ServerLoginModel with _$ServerLoginModel {
  factory ServerLoginModel({
    required CredentialsModel tempCredentials,
    @Default([]) List<AccountModel> accounts,
    String? serverMessage,
    @Default(false) bool hasQuickConnect,
  }) = _ServerLoginModel;
}
