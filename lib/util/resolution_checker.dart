import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/providers/arguments_provider.dart';

class ResolutionChecker extends ConsumerStatefulWidget {
  final bool isDesktop;
  final Widget child;
  const ResolutionChecker({required this.isDesktop, required this.child, super.key});

  @override
  ConsumerState<ResolutionChecker> createState() => _ResolutionCheckerState();
}

class _ResolutionCheckerState extends ConsumerState<ResolutionChecker> {
  Size? lastResolution;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isDesktop) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) => checkResolution());
    }
  }

  Future<void> checkResolution() async {
    final newResolution = (await screenRetriever.getPrimaryDisplay()).size;
    if (lastResolution != newResolution) {
      lastResolution = newResolution;
      shouldSetResolution();
    }
  }

  Future<void> shouldSetResolution() async {
    final arguments = ref.read(argumentsStateProvider);
    if (arguments.htpcMode && lastResolution != null) {
      final isFullScreen = await windowManager.isFullScreen();
      if (isFullScreen) {
        await windowManager.setFullScreen(false);
      }
      await windowManager.setFullScreen(true);
    }
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
