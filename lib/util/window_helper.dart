import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/util/native_window.dart';
import 'package:fladder/util/string_extensions.dart';

void setupFladderWindowChrome(
  ArgumentsModel startupArguments,
  ClientSettingsModel clientSettings,
  PackageInfo packageInfo,
) {
  final window = currentWindow;
  if (window == null) return;
  final isFullScreen = window.isFullScreen;
  // Only skip resetting the window on macOS debug to avoid breaking full-screen during hot reloads.
  final isMacDebug = defaultTargetPlatform == TargetPlatform.macOS && kDebugMode;

  window.titleBarStyle = TitleBarStyle.hidden;
  window.isWindowControlButtonsVisible = true;
  if (!isMacDebug) {
    if (window.isFullScreen) window.isFullScreen = false;
    if (window.isMaximized) window.unmaximize();
    if (window.isMinimized) window.restore();
  }
  window.backgroundColor = Colors.transparent.toNative();
  window.isVisibleInTaskbar = true;
  window.title = packageInfo.appName.capitalize();

  if (!isMacDebug || !isFullScreen) {
    window.setSize(Size(clientSettings.size.x, clientSettings.size.y).toNative(), false);
    window.center();
    window.show();
    window.focus();
  }

  if (startupArguments.htpcMode && !isFullScreen) {
    window.isFullScreen = true;
  }
}
