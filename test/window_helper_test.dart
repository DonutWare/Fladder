import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/util/window_helper.dart';

void main() {
  test('native startup bounds are not treated as external placement', () {
    expect(hasExternalWindowsPlacement(windowsNativeStartupBounds), isFalse);
  });

  test('detects placement by an external window manager', () {
    expect(hasExternalWindowsPlacement(const Rect.fromLTWH(-7, 0, 2574, 1393)), isTrue);
  });

  test('minor native rounding differences are tolerated', () {
    expect(hasExternalWindowsPlacement(const Rect.fromLTWH(10, 10, 1281, 721)), isFalse);
  });

  test('stored bounds restore only while the native startup placement remains', () {
    expect(
      shouldRestoreStoredWindowsBounds(
        currentBounds: windowsNativeStartupBounds,
        isFullScreen: false,
        isMaximized: false,
      ),
      isTrue,
    );
    expect(
      shouldRestoreStoredWindowsBounds(
        currentBounds: const Rect.fromLTWH(-7, 0, 2574, 1393),
        isFullScreen: false,
        isMaximized: false,
      ),
      isFalse,
    );
    expect(
      shouldRestoreStoredWindowsBounds(
        currentBounds: windowsNativeStartupBounds,
        isFullScreen: false,
        isMaximized: true,
      ),
      isFalse,
    );
    expect(
      shouldRestoreStoredWindowsBounds(
        currentBounds: windowsNativeStartupBounds,
        isFullScreen: true,
        isMaximized: false,
      ),
      isFalse,
    );
  });

  test('window bounds persist only after startup and outside maximized modes', () {
    expect(shouldPersistWindowBounds(startupSettled: false, isFullScreen: false, isMaximized: false), isFalse);
    expect(shouldPersistWindowBounds(startupSettled: true, isFullScreen: false, isMaximized: false), isTrue);
    expect(shouldPersistWindowBounds(startupSettled: true, isFullScreen: false, isMaximized: true), isFalse);
    expect(shouldPersistWindowBounds(startupSettled: true, isFullScreen: true, isMaximized: false), isFalse);
  });
}
