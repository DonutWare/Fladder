import 'dart:async';

import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_retriever/screen_retriever.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/util/native_window.dart';

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
        lastResolution = DisplayManager.instance.getPrimary()?.size.toSize();
        _timer = Timer.periodic(const Duration(seconds: 2), (timer) => checkResolution());
      }
    });
  }

  Future<void> checkResolution() async {
    if (!mounted) return;
    final newResolution = DisplayManager.instance.getPrimary()?.size.toSize();
    if (lastResolution != newResolution) {
      lastResolution = newResolution;
      shouldSetResolution();
    }
  }

  Future<void> shouldSetResolution() async {
    if (lastResolution != null) {
      final window = currentWindow;
      if (window == null) return;
      if (window.isFullScreen) {
        window.isFullScreen = false;
      }
      window.isFullScreen = true;
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
