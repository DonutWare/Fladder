// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:material_ui/material_ui.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/util/localization_helper.dart';

class AuthService {
  static Future<bool> authenticateUser(
    BuildContext context,
    AccountModel user, {
    bool stickyAuth = true,
    bool sensitiveTransaction = false,
  }) async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isAuthenticated = false;
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();

    if (isBiometricSupported) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason:
              context.localized.authenticateWithBiometrics("(${user.name} - ${user.credentials.serverName})"),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Fladder',
              signInHint: context.localized.scanBiometricHint,
            ),
            IOSAuthMessages(
              cancelButton: context.localized.cancel,
            )
          ],
          persistAcrossBackgrounding: stickyAuth,
          sensitiveTransaction: sensitiveTransaction,
        );
      } on LocalAuthException catch (e) {
        debugPrint('Error during authentication: $e');
      }
    } else {
      log('Biometric authentication is not supported on this device.');
      return false;
    }
    return isAuthenticated;
  }
}
