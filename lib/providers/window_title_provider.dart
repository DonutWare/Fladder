import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:window_manager/window_manager.dart';

/// Manages the context-aware window title.
final windowTitleProvider = StateNotifierProvider<WindowTitleNotifier, String>((ref) {
  return WindowTitleNotifier(ref);
});

class WindowTitleNotifier extends StateNotifier<String> {
  final Ref ref;
  WindowTitleNotifier(this.ref) : super('Fladder') {
    // Listen to player state changes to handle minimized <-> maximized transitions
    ref.listen(mediaPlaybackProvider.select((v) => v.state), (_, __) => _update());
  }

  final Map<Object, String> _titles = {};
  final List<Object> _stackKeys = [];
  String? _playTitle;

  void updateTitle(Object key, String title) {
    _stackKeys.remove(key);
    _stackKeys.add(key);
    _titles[key] = title;
    _update();
  }

  void removeTitle(Object key) {
    final removed = _stackKeys.remove(key);
    _titles.remove(key);
    if (removed) {
      _update();
    }
  }

  void clearStack() {
    _stackKeys.clear();
    _titles.clear();
    _update();
  }

  void setPlayTitle(String? title) {
    _playTitle = title;
    _update();
  }

  void _update() {
    final nav = _stackKeys.isNotEmpty ? _titles[_stackKeys.last] : null;
    final playerState = ref.read(mediaPlaybackProvider).state;

    final isPlayerActive = playerState != VideoPlayerState.disposed;
    final isPlayerMinimized = playerState == VideoPlayerState.minimized;

    // Use playTitle if player is active and expanded/fullscreen.
    // If player is minimized or inactive, prefer navigation title.
    final title = (isPlayerActive && !isPlayerMinimized) ? (_playTitle ?? nav) : (nav ?? _playTitle);

    final newState = kIsWeb ? (title != null ? 'Fladder • $title' : 'Fladder') : (title ?? 'Fladder');

    if (state == newState) return;

    Future.microtask(() {
      state = newState;
    });

    if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
      windowManager.setTitle(newState);
    }
  }
}
