import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:desktop_multi_window/desktop_multi_window.dart';

import 'package:fladder/src/application_menu.g.dart';

class ApplicationMenuImp extends ApplicationMenu {
  @override
  Future<void> openNewWindow() async {
    final controller = await WindowController.create(
      const WindowConfiguration(
        hiddenAtLaunch: true,
        arguments: '--newWindow',
      ),
    );

    await controller.show();
  }

  @override
  Future<void> newInstance() async {
    if (kIsWeb) return;
    if (Platform.isMacOS) {
      await Process.start('open', ['-n', '-a', Platform.resolvedExecutable]);
    } else if (Platform.isWindows) {
      await Process.start(Platform.resolvedExecutable, []);
    } else if (Platform.isLinux) {
      await Process.start(Platform.resolvedExecutable, [], mode: ProcessStartMode.detached);
    }
  }
}
