import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/src/local_network_permission_pigeon.g.dart';
import 'package:fladder/util/localization_helper.dart';

enum LocalNetworkPermissionStatus {
  granted,
  denied,
}

class LocalNetworkPermissionDeniedException implements Exception {}

Future<bool> _supportsLocalNetworkPermission() async {
  if (kIsWeb || !Platform.isAndroid) return false;

  try {
    final sdkInt = await LocalNetworkPermissionPigeon().getAndroidSdkInt();
    return sdkInt >= 37;
  } catch (e) {
    debugPrint('Error checking Android SDK version: $e');
    return false;
  }
}

Future<LocalNetworkPermissionStatus> requestLocalNetworkPermission() async {
  if (!await _supportsLocalNetworkPermission()) {
    return LocalNetworkPermissionStatus.granted;
  }

  final status = await Permission.accessLocalNetwork.status;
  if (status.isGranted) return LocalNetworkPermissionStatus.granted;

  final requestedStatus = await Permission.accessLocalNetwork.request();
  return requestedStatus.isGranted ? LocalNetworkPermissionStatus.granted : LocalNetworkPermissionStatus.denied;
}

Future<LocalNetworkPermissionStatus> checkLocalNetworkPermission() async {
  if (!await _supportsLocalNetworkPermission()) {
    return LocalNetworkPermissionStatus.granted;
  }

  final status = await Permission.accessLocalNetwork.status;
  return status.isGranted ? LocalNetworkPermissionStatus.granted : LocalNetworkPermissionStatus.denied;
}

void showLocalNetworkPermissionDenied(BuildContext? context) {
  final localized = context?.localized;
  FladderSnack.show(
    localized?.localNetworkPermissionDenied ?? 'Local network access is required. Enable it in system settings.',
    context: context,
    actionLabel: localized?.openSettings ?? 'Open Settings',
    onActionPressed: () async {
      await openLocalNetworkPermissionSettings();
    },
    permanent: true,
    showCloseButton: true,
  );
}

Future<LocalNetworkPermissionStatus> openLocalNetworkPermissionSettings() async {
  if (!await _supportsLocalNetworkPermission()) {
    return LocalNetworkPermissionStatus.granted;
  }

  final resumed = Completer<void>();
  final lifecycleListener = AppLifecycleListener(
    onResume: () {
      if (!resumed.isCompleted) resumed.complete();
    },
  );

  try {
    final opened = await openAppSettings();
    if (!opened) return checkLocalNetworkPermission();
    await resumed.future;
    return checkLocalNetworkPermission();
  } finally {
    lifecycleListener.dispose();
  }
}

bool isLocalNetworkUrl(String url) {
  final normalizedUrl = url.contains('://') ? url : 'http://$url';
  final host = Uri.tryParse(normalizedUrl)?.host.toLowerCase();
  if (host == null || host.isEmpty) return false;

  if (host == 'localhost' || host.endsWith('.local')) return true;

  final ipv4Parts = host.split('.').map(int.tryParse).toList();
  if (ipv4Parts.length == 4 && ipv4Parts.every((part) => part != null && part >= 0 && part <= 255)) {
    final first = ipv4Parts[0]!;
    final second = ipv4Parts[1]!;
    return first == 10 ||
        first == 127 ||
        (first == 169 && second == 254) ||
        (first == 172 && second >= 16 && second <= 31) ||
        (first == 192 && second == 168);
  }

  return host == '::1' || host.startsWith('fe80:') || host.startsWith('fc') || host.startsWith('fd');
}
