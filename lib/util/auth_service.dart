// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/util/localization_helper.dart';

class AuthService {
  static Future<bool> authenticateUser(BuildContext context, AccountModel user) async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isAuthenticated = false;
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    if (isBiometricSupported) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason:
              context.localized.scanYourFingerprintToAuthenticate("(${user.name} - ${user.credentials.serverName})"),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Fladder',
              biometricHint: context.localized.scanBiometricHint,
            ),
            IOSAuthMessages(
              cancelButton: context.localized.cancel,
            )
          ],
        );
      } on PlatformException catch (_) {}
    }
    return isAuthenticated;
  }
}
