import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/touchbar/touchbar_manager.dart';

/// Provider that manages TouchBar integration with video playback
final touchBarIntegrationProvider = Provider<TouchBarIntegration>((ref) {
  return TouchBarIntegration(ref);
});

class TouchBarIntegration {
  final Ref _ref;
  final TouchBarManager _touchBar = TouchBarManager.instance;
  bool _isInitialized = false;

  TouchBarIntegration(this._ref) {
    _initializeIfNeeded();
  }

  /// Initialize TouchBar integration
  Future<void> _initializeIfNeeded() async {
    if (!Platform.isMacOS || _isInitialized) return;

    await _touchBar.initialize();
    _setupCallbacks();
    _isInitialized = true;

    // Listen to playback state changes
    _ref.listen<MediaPlaybackModel>(
      mediaPlaybackProvider,
      (previous, next) {
        _updateTouchBarFromPlayback(next);
      },
    );

    // Listen to playback model changes
    _ref.listen<PlaybackModel?>(
      playBackModel,
      (previous, next) {
        final mediaPlayback = _ref.read(mediaPlaybackProvider);
        _updateTouchBarFromModels(mediaPlayback, next);
      },
    );
  }

  /// Setup TouchBar callback handlers
  void _setupCallbacks() {
    _touchBar.setCallbacks(
      onPlayPause: _handlePlayPause,
      onSeek: _handleSeek,
    );
  }

  /// Handle play/pause from TouchBar
  Future<void> _handlePlayPause() async {
    final mediaControl = _ref.read(videoPlayerProvider);
    await mediaControl.playOrPause();
  }

  /// Handle seek from TouchBar
  Future<void> _handleSeek(Duration position) async {
    final mediaControl = _ref.read(videoPlayerProvider);
    await mediaControl.seek(position);
  }



  /// Update TouchBar from playback state only
  void _updateTouchBarFromPlayback(MediaPlaybackModel mediaPlayback) {
    if (!_isInitialized) return;

    final playbackModel = _ref.read(playBackModel);
    _updateTouchBarFromModels(mediaPlayback, playbackModel);
  }

  /// Update TouchBar from both playback models
  void _updateTouchBarFromModels(MediaPlaybackModel mediaPlayback, PlaybackModel? playbackModel) {
    if (!_isInitialized) return;

    // Don't show TouchBar if no video is playing
    if (mediaPlayback.state == VideoPlayerState.disposed) {
      _touchBar.clear();
      _touchBar.setVisible(false);
      return;
    }

    // Show TouchBar when video player is active
    _touchBar.setVisible(true);

    // Update TouchBar with current state
    _touchBar.updateFromPlaybackModels(
      mediaPlayback: mediaPlayback,
      playbackModel: playbackModel,
    );
  }

  /// Manually update TouchBar progress (for frequent updates)
  void updateProgress(Duration position, Duration duration) {
    if (!_isInitialized) return;
    _touchBar.updateProgress(position: position, duration: duration);
  }

  /// Show TouchBar
  void show() {
    if (!_isInitialized) return;
    _touchBar.setVisible(true);
  }

  /// Hide TouchBar
  void hide() {
    if (!_isInitialized) return;
    _touchBar.setVisible(false);
  }

  /// Clear TouchBar and reset to default
  void clear() {
    if (!_isInitialized) return;
    _touchBar.clear();
  }

  /// Dispose resources
  void dispose() {
    _touchBar.dispose();
    _isInitialized = false;
  }
}
