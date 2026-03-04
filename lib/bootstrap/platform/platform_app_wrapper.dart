import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';
import 'package:fladder/bootstrap/platform/desktop_platform_wrapper.dart';
import 'package:fladder/bootstrap/platform/mobile_app_wrapper.dart';
import 'package:fladder/bootstrap/platform/web_app_wrapper.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class PlatformAppWrapper extends ConsumerWidget {
  const PlatformAppWrapper({super.key, required this.builder});

  final PlatformAppBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) return WebAppWrapper(builder: builder);

    if (AdaptiveLayout.isDesktop(context)) return DesktopAppWrapper(builder: builder);

    return MobileAppWrapper(builder: builder);
  }
}
