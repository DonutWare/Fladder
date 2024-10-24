import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/book_viewer_settings_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/providers/settings/photo_view_settings_provider.dart';
import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(ref: ref, sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.ref,
    required this.sharedPreferences,
  });

  final Ref ref;

  final SharedPreferences sharedPreferences;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<bool?> loadSettings() async {
    try {
      ref.read(clientSettingsProvider.notifier).state = clientSettings;
      ref.read(homeSettingsProvider.notifier).state = homeSettings;
      ref.read(videoPlayerSettingsProvider.notifier).state = videoPlayerSettings;
      ref.read(subtitleSettingsProvider.notifier).state = subtitleSettings;
      ref.read(bookViewerSettingsProvider.notifier).state = bookViewSettings;
      ref.read(photoViewSettingsProvider.notifier).state = photoViewSettings;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> addAccount(AccountModel account) async {
    return await saveAccounts(getAccounts()
      ..add(account.copyWith(
        lastUsed: DateTime.now(),
      )));
  }

  Future<bool?> removeAccount(AccountModel? account) async {
    if (account == null) return null;

    //Try to logout user
    await ref.read(userProvider.notifier).forceLogoutUser(account);

    //Remove from local database
    final savedAccounts = getAccounts();
    savedAccounts.removeWhere((element) {
      return element.sameIdentity(account);
    });
    return (await saveAccounts(savedAccounts));
  }

  List<AccountModel> getAccounts() {
    final savedAccounts = sharedPreferences.getStringList(_loginCredentialsKey);
    try {
      return savedAccounts != null ? savedAccounts.map((e) => AccountModel.fromJson(jsonDecode(e))).toList() : [];
    } catch (_, stacktrace) {
      log(stacktrace.toString());
      return [];
    }
  }

  AccountModel? getActiveAccount() {
    try {
      final accounts = getAccounts();
      AccountModel recentUsedAccount = accounts.reduce((lastLoggedIn, element) {
        return (element.lastUsed.compareTo(lastLoggedIn.lastUsed)) > 0 ? element : lastLoggedIn;
      });

      if (recentUsedAccount.authMethod == Authentication.autoLogin) return recentUsedAccount;
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool?> saveAccounts(List<AccountModel> accounts) async =>
      sharedPreferences.setStringList(_loginCredentialsKey, accounts.map((e) => jsonEncode(e)).toList());

  ClientSettingsModel get clientSettings {
    try {
      return ClientSettingsModel.fromJson(jsonDecode(sharedPreferences.getString(_clientSettingsKey) ?? ""));
    } catch (e) {
      log(e.toString());
      return ClientSettingsModel();
    }
  }

  set clientSettings(ClientSettingsModel settings) =>
      sharedPreferences.setString(_clientSettingsKey, jsonEncode(settings.toJson()));

  HomeSettingsModel get homeSettings {
    try {
      return HomeSettingsModel.fromJson(jsonDecode(sharedPreferences.getString(_homeSettingsKey) ?? ""));
    } catch (e) {
      log(e.toString());
      return HomeSettingsModel();
    }
  }

  set homeSettings(HomeSettingsModel settings) =>
      sharedPreferences.setString(_homeSettingsKey, jsonEncode(settings.toJson()));

  BookViewerSettingsModel get bookViewSettings {
    try {
      return BookViewerSettingsModel.fromJson(sharedPreferences.getString(_bookViewSettingsKey) ?? "");
    } catch (e) {
      log(e.toString());
      return BookViewerSettingsModel();
    }
  }

  set bookViewSettings(BookViewerSettingsModel settings) {
    sharedPreferences.setString(_bookViewSettingsKey, settings.toJson());
  }

  Future<void> updateAccountInfo(AccountModel account) async {
    final accounts = getAccounts();
    await Future.microtask(() async {
      await saveAccounts(accounts.map((e) {
        if (e.sameIdentity(account)) {
          return account.copyWith(
            lastUsed: DateTime.now(),
          );
        } else {
          return e;
        }
      }).toList());
    });
  }

  SubtitleSettingsModel get subtitleSettings {
    try {
      return SubtitleSettingsModel.fromJson(sharedPreferences.getString(_subtitleSettingsKey) ?? "");
    } catch (e) {
      log(e.toString());
      return const SubtitleSettingsModel();
    }
  }

  set subtitleSettings(SubtitleSettingsModel settings) {
    sharedPreferences.setString(_subtitleSettingsKey, settings.toJson());
  }

  VideoPlayerSettingsModel get videoPlayerSettings {
    try {
      return VideoPlayerSettingsModel.fromJson(sharedPreferences.getString(_videoPlayerSettingsKey) ?? "");
    } catch (e) {
      log(e.toString());
      return const VideoPlayerSettingsModel();
    }
  }

  set videoPlayerSettings(VideoPlayerSettingsModel settings) {
    sharedPreferences.setString(_videoPlayerSettingsKey, settings.toJson());
  }

  PhotoViewSettingsModel get photoViewSettings {
    try {
      return PhotoViewSettingsModel.fromJson(sharedPreferences.getString(_photoViewSettingsKey) ?? "");
    } catch (e) {
      log(e.toString());
      return PhotoViewSettingsModel();
    }
  }

  set photoViewSettings(PhotoViewSettingsModel settings) {
    sharedPreferences.setString(_photoViewSettingsKey, settings.toJson());
  }
}

const String _loginCredentialsKey = 'loginCredentialsKey';
const String _clientSettingsKey = 'clientSettings';
const String _homeSettingsKey = 'homeSettings';
const String _videoPlayerSettingsKey = 'videoPlayerSettings';
const String _subtitleSettingsKey = 'subtitleSettings';
const String _bookViewSettingsKey = 'bookViewSettings';
const String _photoViewSettingsKey = 'photoViewSettings';
