import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_window_utils/window_manipulator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smtc_windows/smtc_windows.dart' if (dart.library.js_interop) 'package:fladder/stubs/web/smtc_web.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';
import 'package:fladder/logic/application_menu.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/src/application_menu.g.dart';
import 'package:fladder/util/macos_window_helpers.dart';
import 'package:fladder/util/native_window.dart';
import 'package:fladder/util/protocol_registration.dart';
import 'package:fladder/util/window_helper.dart';
import 'package:fladder/wrappers/multi_window_media_session.dart';

class DesktopAppWrapper extends BaseAppWrapper {
  const DesktopAppWrapper({super.key, required super.builder});

  @override
  ConsumerState<DesktopAppWrapper> createState() => _DesktopAppWrapperState();
}

class _DesktopAppWrapperState extends BaseAppWrapperState<DesktopAppWrapper> {
  ListenerId? _windowListener;

  @override
  bool get enableAppLinks => !ref.read(argumentsStateProvider).newWindow;

  @override
  Future<void> onAppLinkReceived() async {
    final window = currentWindow;
    if (window == null) return;
    if (window.isMinimized) window.restore();
    window.show();
    window.focus();
  }

  @override
  Future<void> platformInit() async {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await SMTCWindows.initialize();
      if (enableAppLinks) unawaited(ensureWindowsProtocolRegistered());
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await WindowManipulator.initialize(enableWindowDelegate: true);
    }

    ApplicationMenu.setUp(ApplicationMenuImp());

    await MultiWindowMediaSession.instance.init(isHub: !ref.read(argumentsStateProvider).newWindow);

    _windowListener = currentWindow?.addListener(_onWindowEvent);

    final packageInfo = await PackageInfo.fromPlatform();
    final clientSettings = ref.read(clientSettingsProvider);
    final startupArguments = ref.read(argumentsStateProvider);
    setupFladderWindowChrome(
      startupArguments,
      clientSettings,
      packageInfo,
    );
    await toggleMacTrafficLights(currentWindow?.isFullScreen ?? false);
  }

  @override
  void dispose() {
    if (_windowListener != null) currentWindow?.removeListener(_windowListener!);
    super.dispose();
  }

  void _onWindowEvent(WindowEvent event) {
    switch (event) {
      case WindowCloseRequestedEvent():
        ref.read(videoPlayerProvider).stop();
        ref.read(clientSettingsProvider.notifier).closeDirectory();
      case WindowResizedEvent(:final newSize):
        ref.read(clientSettingsProvider.notifier).setWindowSize(newSize.toSize());
      case WindowMovedEvent(:final newPosition):
        ref.read(clientSettingsProvider.notifier).setWindowPosition(newPosition.toOffset());
      case WindowEnteredFullScreenEvent():
        ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: true));
        unawaited(toggleMacTrafficLights(true));
      case WindowExitedFullScreenEvent():
        unawaited(toggleMacTrafficLights(false));
        ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: false));
      default:
        break;
    }
  }
}
