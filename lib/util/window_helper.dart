import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/util/string_extensions.dart';

const windowsNativeStartupBounds = Rect.fromLTWH(10, 10, 1280, 720);
const windowsExternalPlacementSettleDelay = Duration(milliseconds: 750);
const windowsWindowPlacementPersistenceDelay = Duration(milliseconds: 2500);

@visibleForTesting
bool hasExternalWindowsPlacement(Rect bounds, {double tolerance = 2}) =>
    (bounds.left - windowsNativeStartupBounds.left).abs() > tolerance ||
    (bounds.top - windowsNativeStartupBounds.top).abs() > tolerance ||
    (bounds.width - windowsNativeStartupBounds.width).abs() > tolerance ||
    (bounds.height - windowsNativeStartupBounds.height).abs() > tolerance;

@visibleForTesting
bool shouldRestoreStoredWindowsBounds({
  required Rect currentBounds,
  required bool isFullScreen,
  required bool isMaximized,
}) =>
    !isFullScreen && !isMaximized && !hasExternalWindowsPlacement(currentBounds);

bool shouldPersistWindowBounds({required bool startupSettled, required bool isFullScreen, required bool isMaximized}) =>
    startupSettled && !isFullScreen && !isMaximized;

extension WindowHelperSetup on WindowManager {
  Future<void> _applyWindowsWindowStateAfterSettle({
    required ArgumentsModel startupArguments,
    required ClientSettingsModel clientSettings,
    required PackageInfo packageInfo,
  }) async {
    await Future<void>.delayed(windowsExternalPlacementSettleDelay);

    final isCurrentlyFullScreen = await windowManager.isFullScreen();
    final isCurrentlyMaximized = await windowManager.isMaximized();
    final currentBounds = await windowManager.getBounds();
    final shouldRestoreBounds = shouldRestoreStoredWindowsBounds(
      currentBounds: currentBounds,
      isFullScreen: isCurrentlyFullScreen,
      isMaximized: isCurrentlyMaximized,
    );

    // These calls are deliberately deferred until Flutter's first frame and
    // external window placement have both had time to complete. A new Windows
    // window is taskbar-visible by default, so setSkipTaskbar(false) is not
    // needed here.
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setTitle(packageInfo.appName.capitalize());

    if (startupArguments.htpcMode && !isCurrentlyFullScreen) {
      await windowManager.setFullScreen(true);
      return;
    }

    if (shouldRestoreBounds) {
      await windowManager.setSize(Size(clientSettings.size.x, clientSettings.size.y));
      await windowManager.center();
    }
  }

  Future<void> setupFladderWindowChrome(
    ArgumentsModel startupArguments,
    ClientSettingsModel clientSettings,
    PackageInfo packageInfo,
  ) async {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      unawaited(
        _applyWindowsWindowStateAfterSettle(
          startupArguments: startupArguments,
          clientSettings: clientSettings,
          packageInfo: packageInfo,
        ),
      );
      return;
    }

    final isFullScreen = await windowManager.isFullScreen();
    final isMacDebug = defaultTargetPlatform == TargetPlatform.macOS && kDebugMode;
    final shouldResizeAndShow = !isMacDebug || !isFullScreen;

    final options = WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      title: packageInfo.appName.capitalize(),
    );

    // Apply window chrome consistently; only skip waitUntilReadyToShow on macOS debug to avoid breaking full-screen during hot reloads.
    Future<void> applyWindowState() async {
      if (shouldResizeAndShow) {
        await windowManager.setSize(Size(clientSettings.size.x, clientSettings.size.y));
        await windowManager.center();
        await windowManager.show();
        await windowManager.focus();
      }

      if (startupArguments.htpcMode && !isFullScreen) {
        await windowManager.setFullScreen(true);
      }
    }

    if (isMacDebug) {
      await windowManager.setBackgroundColor(options.backgroundColor!);
      await windowManager.setSkipTaskbar(options.skipTaskbar ?? false);
      await windowManager.setTitleBarStyle(options.titleBarStyle!);
      await windowManager.setTitle(options.title ?? packageInfo.appName.capitalize());
      await applyWindowState();
    } else {
      await windowManager.waitUntilReadyToShow(options, applyWindowState);
    }
  }
}
