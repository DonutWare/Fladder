// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_annotation_target

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:local_auth/local_auth.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/seerr_credentials_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
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
    @Default(false) bool askForAuthOnLaunch,
    @Default("") String localPin,
    @CredentialsConverter() required CredentialsModel credentials,
    SeerrCredentialsModel? seerrCredentials,
    @Default([]) List<String> latestItemsExcludes,
    @Default([]) List<String> searchQueryHistory,
    @Default(false) bool quickConnectState,
    @Default([]) List<LibraryFiltersModel> libraryFilters,
    @Default(false) bool updateNotificationsEnabled,
    @Default(false) bool seerrRequestsEnabled,
    @Default(false) bool includeHiddenViews,
    bool? incognitoMode,

    //Server values not stored in the database
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

class LibraryFiltersConverter implements JsonConverter<List<LibraryFiltersModel>, Object?> {
  const LibraryFiltersConverter();

  @override
  List<LibraryFiltersModel> fromJson(Object? json) {
    final decoded = json is String ? jsonDecode(json) : json;
    if (decoded is! List) return [];

    return decoded.whereType<Map<String, dynamic>>().map(LibraryFiltersModel.fromJson).toList();
  }

  @override
  Object toJson(List<LibraryFiltersModel> filters) => filters.map((filter) => filter.toJson()).toList();
}

class FilterSortOrderConverter implements JsonConverter<Map<FilterSortKey, List<String>>, Object?> {
  const FilterSortOrderConverter();

  @override
  Map<FilterSortKey, List<String>> fromJson(Object? json) {
    final decoded = json is String ? jsonDecode(json) : json;

    if (decoded is! Map) return {};

    return decoded.map((key, value) {
      return MapEntry(
        FilterSortKey.values.byName(key.toString()),
        (value as List).whereType<String>().toList(),
      );
    });
  }

  @override
  Object toJson(Map<FilterSortKey, List<String>> value) {
    return jsonEncode(
      value.map(
        (key, value) => MapEntry(key.name, value),
      ),
    );
  }
}

class DashboardSortingConverter implements JsonConverter<Map<DashboardSorting, bool>, Object?> {
  const DashboardSortingConverter();

  @override
  Map<DashboardSorting, bool> fromJson(Object? json) {
    final decoded = json is String ? jsonDecode(json) : json;

    if (decoded is! Map) return {};

    return decoded.map((key, value) {
      return MapEntry(
        DashboardSorting.values.byName(key.toString()),
        value == true,
      );
    });
  }

  @override
  Object toJson(Map<DashboardSorting, bool> value) {
    return jsonEncode(
      value.map(
        (key, value) => MapEntry(key.name, value),
      ),
    );
  }
}

@Freezed(copyWith: true)
abstract class UserSettings with _$UserSettings {
  const UserSettings._();

  factory UserSettings({
    @Default(Duration(seconds: 30)) Duration skipForwardDuration,
    @Default(Duration(seconds: 10)) Duration skipBackDuration,
    @LibraryFiltersConverter() @Default([]) List<LibraryFiltersModel> libraryFilters,
    @FilterSortOrderConverter() @Default({}) Map<FilterSortKey, List<String>> filterSortOrder,
    @DashboardSortingConverter() @Default({}) Map<DashboardSorting, bool> pDashboardSorting,
  }) = _UserSettings;

  Map<DashboardSorting, bool> get dashboardSorting {
    return {
      ...pDashboardSorting,
      for (final sorting in DashboardSorting.values)
        if (!pDashboardSorting.containsKey(sorting)) sorting: true,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

  List<LibraryFiltersModel> getFilterSortOrder(FilterSortKey key) {
    final keyFilters = libraryFilters.where((filter) => filter.sortKeys[key] ?? false).toList();

    final order = filterSortOrder[key] ?? [];
    if (order.isEmpty) return keyFilters;

    final orderMap = {for (int i = 0; i < order.length; i++) order[i]: i};

    keyFilters.sort((a, b) {
      final indexA = orderMap[a.id] ?? double.maxFinite.toInt();
      final indexB = orderMap[b.id] ?? double.maxFinite.toInt();
      return indexA.compareTo(indexB);
    });

    return keyFilters;
  }
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

  static Future<Set<Authentication>> available() async {
    final localAuthentication = LocalAuthentication();
    final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    final getAvailableBiometrics = await localAuthentication.getAvailableBiometrics();
    final bool hasBiometrics = canCheckBiometrics || getAvailableBiometrics.isNotEmpty;
    return {
      Authentication.autoLogin,
      if (hasBiometrics) Authentication.biometrics,
      Authentication.passcode,
      Authentication.none,
    };
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
