import 'dart:developer';
import 'dart:io';

import 'package:fladder/src/local_network_access_pigeon.g.dart' as pigeon;

/// Android 16+ (Local Network Protection) requires an explicit runtime
/// permission before the app may reach hosts on the local network. Without it
/// the platform drops the traffic silently, so a local server URL simply never
/// connects.
class LocalNetworkAccess {
  static final _api = pigeon.LocalNetworkAccessPigeon();

  /// Guards against re-prompting on every connectivity check.
  static bool _requestedThisSession = false;

  static Future<bool> isPermissionRequired() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _api.isPermissionRequired();
    } catch (e, st) {
      log('isPermissionRequired failed: $e', error: e, stackTrace: st);
      return false;
    }
  }

  static Future<bool> hasAccess() async {
    if (!Platform.isAndroid) return true;
    try {
      return await _api.hasLocalNetworkAccess();
    } catch (e, st) {
      log('hasLocalNetworkAccess failed: $e', error: e, stackTrace: st);
      // Assume access rather than surfacing a warning we can't act on.
      return true;
    }
  }

  static Future<bool> ensureAccess() async {
    if (!Platform.isAndroid) return true;
    if (await hasAccess()) return true;
    if (_requestedThisSession) return false;
    _requestedThisSession = true;
    try {
      return await _api.requestLocalNetworkAccess();
    } catch (e, st) {
      log('requestLocalNetworkAccess failed: $e', error: e, stackTrace: st);
      return false;
    }
  }

  /// The only route back once the user has denied the permission.
  static Future<void> openAppSettings() async {
    if (!Platform.isAndroid) return;
    try {
      await _api.openAppSettings();
    } catch (e, st) {
      log('openAppSettings failed: $e', error: e, stackTrace: st);
    }
  }
}
