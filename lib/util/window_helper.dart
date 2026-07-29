import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/util/string_extensions.dart';

const windowsStartupBackgroundColor = Color(0xFF101114);
const windowsNativeStartupBounds = Rect.fromLTWH(10, 10, 1280, 720);
const windowsPostNativeShowDelay = Duration(milliseconds: 600);
const windowsExternalPlacementSettleDelay = Duration(milliseconds: 750);
const windowsWindowPlacementPersistenceDelay = Duration(milliseconds: 2500);

@visibleForTesting
Color fladderStartupBackgroundColor(TargetPlatform platform) =>
    platform == TargetPlatform.windows ? windowsStartupBackgroundColor : Colors.transparent;

@visibleForTesting
bool shouldUseWaitUntilReadyToShow(
  TargetPlatform platform, {
  required bool debugMode,
}) {
  if (platform == TargetPlatform.windows) return false;
  if (platform == TargetPlatform.macOS && debugMode) return false;
  return true;
}

@visibleForTesting
bool shouldSetTaskbarVisibilityDuringStartup(TargetPlatform platform) => platform != TargetPlatform.windows;

@visibleForTesting
bool shouldApplyStoredWindowBounds({
  required bool isFullScreen,
  required bool isMaximized,
}) =>
    !isFullScreen && !isMaximized;

bool shouldPersistWindowBounds({
  required bool startupSettled,
  required bool isFullScreen,
  required bool isMaximized,
}) =>
    startupSettled &&
    shouldApplyStoredWindowBounds(
      isFullScreen: isFullScreen,
      isMaximized: isMaximized,
    );

@visibleForTesting
bool hasExternalWindowsPlacement(Rect bounds, {double tolerance = 2}) =>
    (bounds.left - windowsNativeStartupBounds.left).abs() > tolerance ||
    (bounds.top - windowsNativeStartupBounds.top).abs() > tolerance ||
    (bounds.width - windowsNativeStartupBounds.width).abs() > tolerance ||
    (bounds.height - windowsNativeStartupBounds.height).abs() > tolerance;

extension WindowHelperSetup on WindowManager {
  Future<void> _settleWindowsAfterNativeShow({
    required bool restoreStoredBounds,
    required Size storedSize,
  }) async {
    await Future<void>.delayed(windowsPostNativeShowDelay);
    await windowManager.focus();

    if (restoreStoredBounds) {
      await _restoreWindowsBoundsAfterExternalManagers(storedSize);
    }
  }

  Future<void> _restoreWindowsBoundsAfterExternalManagers(
    Size storedSize,
  ) async {
    await Future<void>.delayed(windowsExternalPlacementSettleDelay);

    final isCurrentlyFullScreen = await windowManager.isFullScreen();
    final isCurrentlyMaximized = await windowManager.isMaximized();
    final currentBounds = await windowManager.getBounds();
    final externallyPositioned = hasExternalWindowsPlacement(currentBounds);

    if (!shouldApplyStoredWindowBounds(
          isFullScreen: isCurrentlyFullScreen,
          isMaximized: isCurrentlyMaximized,
        ) ||
        externallyPositioned) {
      return;
    }

    await windowManager.setSize(storedSize);
    await windowManager.center();
  }

  Future<void> setupFladderWindowChrome(
    ArgumentsModel startupArguments,
    ClientSettingsModel clientSettings,
    PackageInfo packageInfo,
  ) async {
    final isFullScreen = await windowManager.isFullScreen();
    final isMacDebug = defaultTargetPlatform == TargetPlatform.macOS && kDebugMode;
    final shouldResizeAndShow = !isMacDebug || !isFullScreen;

    final options = WindowOptions(
      backgroundColor: fladderStartupBackgroundColor(defaultTargetPlatform),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      title: packageInfo.appName.capitalize(),
    );

    // Apply window chrome consistently; only skip waitUntilReadyToShow on macOS debug to avoid breaking full-screen during hot reloads.
    Future<void> applyWindowState() async {
      final isCurrentlyFullScreen = await windowManager.isFullScreen();
      final isCurrentlyMaximized = await windowManager.isMaximized();
      final applyStoredBounds = shouldApplyStoredWindowBounds(
        isFullScreen: isCurrentlyFullScreen,
        isMaximized: isCurrentlyMaximized,
      );
      final isWindows = defaultTargetPlatform == TargetPlatform.windows;

      if (shouldResizeAndShow && isWindows) {
        // The native runner owns the first show on Windows. Let external
        // window managers place the visible window before considering saved
        // bounds, so Fladder does not immediately undo their placement.
        unawaited(
          _settleWindowsAfterNativeShow(
            restoreStoredBounds: applyStoredBounds,
            storedSize: Size(clientSettings.size.x, clientSettings.size.y),
          ),
        );
      } else if (shouldResizeAndShow && applyStoredBounds) {
        await windowManager.setSize(
          Size(clientSettings.size.x, clientSettings.size.y),
        );
        await windowManager.center();
        await windowManager.show();
        await windowManager.focus();
      }

      if (startupArguments.htpcMode && !isCurrentlyFullScreen) {
        await windowManager.setFullScreen(true);
      }
    }

    if (!shouldUseWaitUntilReadyToShow(
      defaultTargetPlatform,
      debugMode: kDebugMode,
    )) {
      await windowManager.setBackgroundColor(options.backgroundColor!);
      // setSkipTaskbar(false) initializes taskbar COM inside window_manager
      // and can block the Windows platform channel during startup. A newly
      // created runner window is already taskbar-visible.
      if (shouldSetTaskbarVisibilityDuringStartup(defaultTargetPlatform)) {
        await windowManager.setSkipTaskbar(options.skipTaskbar ?? false);
      }
      await windowManager.setTitleBarStyle(options.titleBarStyle!);
      await windowManager.setTitle(
        options.title ?? packageInfo.appName.capitalize(),
      );
      await applyWindowState();
    } else {
      await windowManager.waitUntilReadyToShow(options, applyWindowState);
    }
  }
}
