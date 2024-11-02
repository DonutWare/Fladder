// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    required String name,
    required String id,
    required String avatar,
    required DateTime lastUsed,
    @Default(Authentication.autoLogin) Authentication authMethod,
    @Default("") String localPin,
    required CredentialsModel credentials,
    @Default([]) List<String> latestItemsExcludes,
    @Default([]) List<String> searchQueryHistory,
    @Default(false) bool quickConnectState,
    @Default([]) List<LibraryFiltersModel> savedFilters,
    @JsonKey(includeFromJson: false, includeToJson: false) UserPolicy? policy,
    @JsonKey(includeFromJson: false, includeToJson: false) ServerConfiguration? serverConfiguration,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  String get server {
    return credentials.server;
  }

  bool get canDownload {
    return (policy?.enableContentDownloading ?? false) && !kIsWeb;
  }

  //Check if it's the same account on the same server
  bool sameIdentity(AccountModel other) {
    if (identical(this, other)) return true;
    return other.id == id && other.credentials.serverId == credentials.serverId;
  }
}

enum Authentication {
  autoLogin(0),
  biometrics(1),
  passcode(2),
  none(3);

  const Authentication(this.value);
  final int value;

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
        return IconsaxBold.arrow_bottom;
      case Authentication.autoLogin:
        return IconsaxOutline.login_1;
      case Authentication.biometrics:
        return IconsaxOutline.finger_scan;
      case Authentication.passcode:
        return IconsaxOutline.password_check;
    }
  }

  static Authentication fromMap(int value) {
    return Authentication.values[value];
  }

  int toMap() {
    return value;
  }
}
