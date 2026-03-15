import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

/// Manages the context-aware window title.
final windowTitleProvider = StateNotifierProvider<WindowTitleNotifier, String>((ref) {
  return WindowTitleNotifier();
});

class WindowTitleNotifier extends StateNotifier<String> {
  WindowTitleNotifier() : super('Fladder');

  final List<String> _navStack = [];
  String? _playTitle;

  void pushNavTitle(String title) {
    _navStack.add(title);
    _update();
  }

  void popNavTitle(String title) {
    _navStack.remove(title);
    _update();
  }

  void replaceNavTitle(String oldTitle, String newTitle) {
    final index = _navStack.lastIndexOf(oldTitle);
    if (index != -1) {
      _navStack[index] = newTitle;
    } else {
      _navStack.add(newTitle);
    }
    _update();
  }

  void clearStack() {
    _navStack.clear();
    _update();
  }

  void setPlayTitle(String? title) {
    _playTitle = title;
    _update();
  }

  void _update() {
    final nav = _navStack.isNotEmpty ? _navStack.last : null;
    final title = _playTitle ?? nav;

    if (kIsWeb) {
      state = title != null ? 'Fladder • $title' : 'Fladder';
    } else {
      state = title ?? 'Fladder';
    }

    if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
      windowManager.setTitle(state);
    }
  }
}
