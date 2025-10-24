import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';

/// TouchBar manager for macOS devices
/// Provides media controls and progress display on the TouchBar
class TouchBarManager {
  static const MethodChannel _channel = MethodChannel('fladder.touchbar');
  static TouchBarManager? _instance;
  
  TouchBarManager._();
  
  static TouchBarManager get instance {
    _instance ??= TouchBarManager._();
    return _instance!;
  }
  
  /// Whether TouchBar is available on this device
  bool get isAvailable => Platform.isMacOS;
  
  /// Initialize TouchBar with method channel callbacks
  Future<void> initialize() async {
    if (!isAvailable) return;
    
    try {
      // Set up method channel to handle TouchBar callbacks
      _channel.setMethodCallHandler(_handleMethodCall);
      
      // Initialize TouchBar on native side
      await _channel.invokeMethod('initialize');
    } catch (e) {
      // TouchBar not supported or initialization failed
      print('TouchBar initialization failed: $e');
    }
  }
  
  /// Handle method calls from native TouchBar
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onPlayPause':
        // Handle play/pause button tap from TouchBar
        if (_onPlayPause != null) {
          await _onPlayPause!();
        }
        break;
      case 'onSeek':
        // Handle seek action from TouchBar progress slider
        final position = call.arguments as double;
        if (_onSeek != null) {
          await _onSeek!(Duration(milliseconds: (position * 1000).round()));
        }
        break;

    }
  }
  
  /// Callback functions for TouchBar actions
  Future<void> Function()? _onPlayPause;
  Future<void> Function(Duration position)? _onSeek;
  
  /// Set callback functions for TouchBar actions
  void setCallbacks({
    Future<void> Function()? onPlayPause,
    Future<void> Function(Duration position)? onSeek,
  }) {
    _onPlayPause = onPlayPause;
    _onSeek = onSeek;
  }
  
  /// Update TouchBar with current playback state
  Future<void> updatePlaybackState({
    required bool isPlaying,
    required Duration position,
    required Duration duration,
    String? title,
    String? artist,
    String? logoUrl,
  }) async {
    if (!isAvailable) return;
    
    try {
      await _channel.invokeMethod('updatePlaybackState', {
        'isPlaying': isPlaying,
        'position': position.inSeconds.toDouble(),
        'duration': duration.inSeconds.toDouble(),
        'title': title ?? '',
        'artist': artist ?? '',
        'logoUrl': logoUrl ?? '',
        'hasQueue': false,
      });
    } catch (e) {
      // Silently fail if TouchBar is not available
      print('TouchBar update failed: $e');
    }
  }
  
  /// Update TouchBar progress without full state update
  Future<void> updateProgress({
    required Duration position,
    required Duration duration,
  }) async {
    if (!isAvailable) return;
    
    try {
      await _channel.invokeMethod('updateProgress', {
        'position': position.inSeconds.toDouble(),
        'duration': duration.inSeconds.toDouble(),
      });
    } catch (e) {
      // Silently fail if TouchBar is not available
    }
  }
  
  /// Show or hide TouchBar media controls
  Future<void> setVisible(bool visible) async {
    if (!isAvailable) return;
    
    try {
      await _channel.invokeMethod('setVisible', {'visible': visible});
    } catch (e) {
      print('TouchBar visibility update failed: $e');
    }
  }
  
  /// Clear TouchBar and reset to default
  Future<void> clear() async {
    if (!isAvailable) return;
    
    try {
      await _channel.invokeMethod('clear');
    } catch (e) {
      // Silently fail
    }
  }
  
  /// Dispose TouchBar manager
  void dispose() {
    _onPlayPause = null;
    _onSeek = null;
  }
}

/// Provider for TouchBar manager
final touchBarManagerProvider = Provider<TouchBarManager>((ref) {
  return TouchBarManager.instance;
});

/// Helper extension to update TouchBar from playback models
extension TouchBarUpdateExtension on TouchBarManager {
  /// Update TouchBar from MediaPlaybackModel and PlaybackModel
  Future<void> updateFromPlaybackModels({
    required MediaPlaybackModel mediaPlayback,
    PlaybackModel? playbackModel,
  }) async {
    if (!isAvailable) return;
    
    final item = playbackModel?.item;
    final simpleItem = item?.toSimpleItem(null);
    final title = simpleItem?.title ?? '';
    final artist = simpleItem?.subTitle ?? '';
    final logoUrl = simpleItem?.logoUrl;
    
    await updatePlaybackState(
      isPlaying: mediaPlayback.playing,
      position: mediaPlayback.position,
      duration: mediaPlayback.duration,
      title: title,
      artist: artist,
      logoUrl: logoUrl,
    );
  }
}
