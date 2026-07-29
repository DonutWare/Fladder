import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/util/window_helper.dart';

void main() {
  test('Windows startup uses an opaque background', () {
    final color = fladderStartupBackgroundColor(TargetPlatform.windows);

    expect(color, windowsStartupBackgroundColor);
    expect(color.a, 1.0);
  });

  test('Windows bypasses waitUntilReadyToShow', () {
    expect(
      shouldUseWaitUntilReadyToShow(TargetPlatform.windows, debugMode: false),
      isFalse,
    );
  });

  test('Windows keeps native taskbar visibility during startup', () {
    expect(
      shouldSetTaskbarVisibilityDuringStartup(TargetPlatform.windows),
      isFalse,
    );
    expect(
      shouldSetTaskbarVisibilityDuringStartup(TargetPlatform.macOS),
      isTrue,
    );
  });

  test('stored bounds do not override maximized or fullscreen windows', () {
    expect(
      shouldApplyStoredWindowBounds(isFullScreen: false, isMaximized: true),
      isFalse,
    );
    expect(
      shouldApplyStoredWindowBounds(isFullScreen: true, isMaximized: false),
      isFalse,
    );
    expect(
      shouldApplyStoredWindowBounds(isFullScreen: false, isMaximized: false),
      isTrue,
    );
  });

  test('window bounds are persisted only after startup settles', () {
    expect(
      shouldPersistWindowBounds(
        startupSettled: false,
        isFullScreen: false,
        isMaximized: false,
      ),
      isFalse,
    );
    expect(
      shouldPersistWindowBounds(
        startupSettled: true,
        isFullScreen: false,
        isMaximized: false,
      ),
      isTrue,
    );
    expect(
      shouldPersistWindowBounds(
        startupSettled: true,
        isFullScreen: false,
        isMaximized: true,
      ),
      isFalse,
    );
  });

  test('detects normal-window placement by an external window manager', () {
    expect(hasExternalWindowsPlacement(windowsNativeStartupBounds), isFalse);
    expect(
      hasExternalWindowsPlacement(const Rect.fromLTWH(-7, 0, 2574, 1393)),
      isTrue,
    );
    expect(
      hasExternalWindowsPlacement(const Rect.fromLTWH(10, 10, 1281, 721)),
      isFalse,
    );
  });

  test('other release desktop platforms retain ready-to-show behavior', () {
    expect(
      shouldUseWaitUntilReadyToShow(TargetPlatform.linux, debugMode: false),
      isTrue,
    );
    expect(
      shouldUseWaitUntilReadyToShow(TargetPlatform.macOS, debugMode: false),
      isTrue,
    );
  });
}
