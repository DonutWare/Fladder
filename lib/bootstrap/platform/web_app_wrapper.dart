import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';

class WebAppWrapper extends BaseAppWrapper {
  const WebAppWrapper({super.key, required super.builder});

  @override
  ConsumerState<WebAppWrapper> createState() => _WebAppWrapperState();
}

class _WebAppWrapperState extends BaseAppWrapperState<WebAppWrapper> {
  @override
  bool get enableNotifications => false;

  @override
  bool get enableAppLinks => false;

  @override
  Future<void> platformInit() async {
    await BrowserContextMenu.disableContextMenu();
  }
}
