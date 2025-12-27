import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:flutter_tizen/flutter_tizen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/providers/arguments_provider.dart';

class ResolutionChecker extends ConsumerStatefulWidget {
  final Widget child;
  const ResolutionChecker({required this.child, super.key});

  @override
  ConsumerState<ResolutionChecker> createState() => _ResolutionCheckerState();
}

class _ResolutionCheckerState extends ConsumerState<ResolutionChecker> {
  Size? lastResolution;
  Timer? _timer;

  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      if (ref.read(argumentsStateProvider).htpcMode) {
        lastResolution = isTizen ? await getTizenResolution() : (await screenRetriever.getPrimaryDisplay()).size;
        _timer = Timer.periodic(const Duration(seconds: 2), (timer) => checkResolution());
      }
    });
  }

  Future<void> checkResolution() async {
    if (!mounted) return;
    final newResolution = isTizen ? await getTizenResolution() : (await screenRetriever.getPrimaryDisplay()).size;
    if (lastResolution != newResolution) {
      lastResolution = newResolution;
      shouldSetResolution();
    }
  }

  Future<void> shouldSetResolution() async {
    if (lastResolution != null) {
      final isFullScreen = await windowManager.isFullScreen();
      if (isFullScreen) {
        await windowManager.setFullScreen(false);
      }
      await windowManager.setFullScreen(true);
    }
  }

  Future<Size> getTizenResolution() async {
    final DeviceInfoPluginTizen deviceInfoPlugin = DeviceInfoPluginTizen();
    final tizenInfo = await deviceInfoPlugin.tizenInfo;
    return Size(tizenInfo.screenWidth.toDouble(), tizenInfo.screenHeight.toDouble());
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
