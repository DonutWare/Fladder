import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';
import 'package:fladder/bootstrap/platform/desktop_platform_wrapper.dart';
import 'package:fladder/bootstrap/platform/mobile_app_wrapper.dart';
import 'package:fladder/bootstrap/platform/web_app_wrapper.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class PlatformAppWrapper extends ConsumerStatefulWidget {
  const PlatformAppWrapper({super.key, required this.builder});

  final PlatformAppBuilder builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlatformAppWrapperState();
}

class _PlatformAppWrapperState extends ConsumerState<PlatformAppWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Safety check to ensure connectivity status is up to date when the app is resumed
        ref.read(connectivityStatusProvider.notifier).checkConnectivity();
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return WebAppWrapper(builder: widget.builder);

    if (AdaptiveLayout.isDesktop(context)) return DesktopAppWrapper(builder: widget.builder);

    return MobileAppWrapper(builder: widget.builder);
  }
}
