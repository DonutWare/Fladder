import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';

class MobileAppWrapper extends BaseAppWrapper {
  const MobileAppWrapper({super.key, required super.builder});

  @override
  ConsumerState<MobileAppWrapper> createState() => _MobileAppWrapperState();
}

class _MobileAppWrapperState extends BaseAppWrapperState<MobileAppWrapper> {
  @override
  Future<void> platformInit() async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    } catch (e) {
      if (kDebugMode) print('Mobile platform init warning: $e');
    }
  }
}
