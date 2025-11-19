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
}
