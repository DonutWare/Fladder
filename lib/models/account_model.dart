// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@Freezed(copyWith: true)
abstract class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    required String name,
    required String id,
    required String avatar,
    required DateTime lastUsed,
    @Default(Authentication.autoLogin) Authentication authMethod,
    @Default("") String localPin,
    @CredentialsConverter() required CredentialsModel credentials,
    @Default([]) List<String> latestItemsExcludes,
    @Default([]) List<String> searchQueryHistory,
    @Default(false) bool quickConnectState,
    @Default([]) List<LibraryFiltersModel> libraryFilters,
    @JsonKey(includeFromJson: false, includeToJson: false) UserPolicy? policy,
    @JsonKey(includeFromJson: false, includeToJson: false) ServerConfiguration? serverConfiguration,
    @JsonKey(includeFromJson: false, includeToJson: false) UserConfiguration? userConfiguration,
    @JsonKey(includeFromJson: false, includeToJson: false) bool? hasPassword,
    @JsonKey(includeFromJson: false, includeToJson: false) bool? hasConfiguredPassword,
    UserSettings? userSettings,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  bool get canDownload => (policy?.enableContentDownloading ?? false);

  //Check if it's the same account on the same server
  bool sameIdentity(AccountModel other) {
    if (identical(this, other)) return true;
    return other.id == id && other.credentials.serverId == credentials.serverId;
  }
}

//Converter to convert old json to new json formats
class CredentialsConverter implements JsonConverter<CredentialsModel, Object?> {
  const CredentialsConverter();

  @override
  CredentialsModel fromJson(Object? json) {
    if (json is String) {
      return CredentialsModel.fromJsonString(json);
    }
    if (json is Map<String, dynamic>) {
      return CredentialsModel.fromJson(json);
    }
    throw ArgumentError('Invalid credentials JSON: $json');
  }

  @override
  Object? toJson(CredentialsModel object) {
    return object.toJson();
  }
}

@Freezed(copyWith: true)
abstract class UserSettings with _$UserSettings {
  factory UserSettings({
    @Default(Duration(seconds: 30)) Duration skipForwardDuration,
    @Default(Duration(seconds: 10)) Duration skipBackDuration,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
}

enum Authentication {
  autoLogin(0),
  biometrics(1),
  passcode(2),
  none(3);

  const Authentication(this.value);
  final int value;

  static Set<Authentication> get secureOptions => Authentication.values.where((element) => element.shouldLock).toSet();

  bool get shouldLock => switch (this) {
        Authentication.autoLogin => false,
        Authentication.biometrics => true,
        Authentication.passcode => true,
        Authentication.none => false,
      };

  bool available(BuildContext context) {
    switch (this) {
      case Authentication.none:
      case Authentication.autoLogin:
      case Authentication.passcode:
        return true;
      case Authentication.biometrics:
        return !AdaptiveLayout.of(context).isDesktop;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case Authentication.none:
        return context.localized.none;
      case Authentication.autoLogin:
        return context.localized.appLockAutoLogin;
      case Authentication.biometrics:
        return context.localized.appLockBiometrics;
      case Authentication.passcode:
        return context.localized.appLockPasscode;
    }
  }

  IconData get icon {
    switch (this) {
      case Authentication.none:
        return IconsaxPlusBold.arrow_bottom;
      case Authentication.autoLogin:
        return IconsaxPlusLinear.login_1;
      case Authentication.biometrics:
        return IconsaxPlusLinear.finger_scan;
      case Authentication.passcode:
        return IconsaxPlusLinear.password_check;
    }
  }

  static Authentication fromMap(int value) {
    return Authentication.values[value];
  }

  int toMap() {
    return value;
  }
}
