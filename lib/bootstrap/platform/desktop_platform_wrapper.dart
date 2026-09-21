import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_window_utils/window_manipulator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smtc_windows/smtc_windows.dart' if (dart.library.html) 'package:fladder/stubs/web/smtc_web.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';
import 'package:fladder/logic/application_menu.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/src/application_menu.g.dart';
import 'package:fladder/util/macos_window_helpers.dart';
import 'package:fladder/util/window_helper.dart';

class DesktopAppWrapper extends BaseAppWrapper {
  const DesktopAppWrapper({super.key, required super.builder});

  @override
  ConsumerState<DesktopAppWrapper> createState() => _DesktopAppWrapperState();
}

class _DesktopAppWrapperState extends BaseAppWrapperState<DesktopAppWrapper> with WindowListener {
  bool _windowPlacementInitialized = false;
  bool _windowIsMaximized = false;
  bool _windowIsFullScreen = false;

  @override
  Future<void> platformInit() async {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await SMTCWindows.initialize();
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await WindowManipulator.initialize(enableWindowDelegate: true);
    }

    ApplicationMenu.setUp(ApplicationMenuImp());

    await WindowManager.instance.ensureInitialized();
    _windowPlacementInitialized = defaultTargetPlatform != TargetPlatform.windows;
    if (_windowPlacementInitialized) {
      _windowIsMaximized = await windowManager.isMaximized();
      _windowIsFullScreen = await windowManager.isFullScreen();
    }
    windowManager.addListener(this);

    final packageInfo = await PackageInfo.fromPlatform();
    final clientSettings = ref.read(clientSettingsProvider);
    final startupArguments = ref.read(argumentsStateProvider);
    await windowManager.setupFladderWindowChrome(startupArguments, clientSettings, packageInfo);
    if (defaultTargetPlatform == TargetPlatform.windows) {
      unawaited(_enableWindowPlacementPersistenceAfterStartup());
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await toggleMacTrafficLights(await windowManager.isFullScreen());
    }
  }

  Future<void> _enableWindowPlacementPersistenceAfterStartup() async {
    await Future<void>.delayed(windowsWindowPlacementPersistenceDelay);
    if (!mounted) return;

    _windowIsMaximized = await windowManager.isMaximized();
    _windowIsFullScreen = await windowManager.isFullScreen();
    if (!mounted) return;
    _windowPlacementInitialized = true;
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() {
    ref.read(videoPlayerProvider).stop();
    ref.read(clientSettingsProvider.notifier).closeDirectory();
    super.onWindowClose();
  }

  bool get _canPersistWindowBounds => shouldPersistWindowBounds(
        startupSettled: _windowPlacementInitialized,
        isFullScreen: _windowIsFullScreen,
        isMaximized: _windowIsMaximized,
      );

  Future<void> _persistWindowSize() async {
    if (!_canPersistWindowBounds) return;
    final size = await windowManager.getSize();
    if (!_canPersistWindowBounds) return;
    ref.read(clientSettingsProvider.notifier).setWindowSize(size);
  }

  Future<void> _persistWindowPosition() async {
    if (!_canPersistWindowBounds) return;
    final position = await windowManager.getPosition();
    if (!_canPersistWindowBounds) return;
    ref.read(clientSettingsProvider.notifier).setWindowPosition(position);
  }

  @override
  void onWindowResize() {
    unawaited(_persistWindowSize());
    super.onWindowResize();
  }

  @override
  void onWindowResized() {
    unawaited(_persistWindowSize());
    super.onWindowResized();
  }

  @override
  void onWindowMove() {
    unawaited(_persistWindowPosition());
    super.onWindowMove();
  }

  @override
  void onWindowMoved() {
    unawaited(_persistWindowPosition());
    super.onWindowMoved();
  }

  @override
  void onWindowMaximize() {
    _windowIsMaximized = true;
    super.onWindowMaximize();
  }

  @override
  void onWindowUnmaximize() {
    _windowIsMaximized = false;
    super.onWindowUnmaximize();
  }

  @override
  void onWindowEnterFullScreen() {
    _windowIsFullScreen = true;
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: true));
    unawaited(toggleMacTrafficLights(true));
    super.onWindowEnterFullScreen();
  }

  @override
  void onWindowLeaveFullScreen() {
    _windowIsFullScreen = false;
    unawaited(toggleMacTrafficLights(false));
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: false));
    super.onWindowLeaveFullScreen();
  }
}
