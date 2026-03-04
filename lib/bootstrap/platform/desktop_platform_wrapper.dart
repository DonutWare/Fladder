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
    windowManager.addListener(this);

    final packageInfo = await PackageInfo.fromPlatform();
    final clientSettings = ref.read(clientSettingsProvider);
    final startupArguments = ref.read(argumentsStateProvider);
    toggleMacTrafficLights(false);
    await windowManager.setupFladderWindowChrome(
      startupArguments,
      clientSettings,
      packageInfo,
    );
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

  @override
  void onWindowResize() async {
    final size = await windowManager.getSize();
    ref.read(clientSettingsProvider.notifier).setWindowSize(size);
    super.onWindowResize();
  }

  @override
  void onWindowResized() async {
    final size = await windowManager.getSize();
    ref.read(clientSettingsProvider.notifier).setWindowSize(size);
    super.onWindowResized();
  }

  @override
  void onWindowMove() async {
    final position = await windowManager.getPosition();
    ref.read(clientSettingsProvider.notifier).setWindowPosition(position);
    super.onWindowMove();
  }

  @override
  void onWindowMoved() async {
    final position = await windowManager.getPosition();
    ref.read(clientSettingsProvider.notifier).setWindowPosition(position);
    super.onWindowMoved();
  }

  @override
  void onWindowEnterFullScreen() {
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: true));
    toggleMacTrafficLights(true);
    super.onWindowEnterFullScreen();
  }

  @override
  void onWindowLeaveFullScreen() {
    toggleMacTrafficLights(false);
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: false));
    super.onWindowLeaveFullScreen();
  }
}
