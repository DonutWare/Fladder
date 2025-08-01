import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/shared_provider.dart';

class PhotoViewSettingsModel {
  final bool repeat;
  final bool mute;
  final bool autoPlay;
  final bool theaterMode;
  final Duration timer;
  PhotoViewSettingsModel({
    this.repeat = true,
    this.mute = false,
    this.autoPlay = false,
    this.theaterMode = false,
    this.timer = const Duration(seconds: 15),
  });

  PhotoViewSettingsModel copyWith({
    bool? repeat,
    bool? mute,
    bool? autoPlay,
    bool? theaterMode,
    Duration? timer,
  }) {
    return PhotoViewSettingsModel(
      repeat: repeat ?? this.repeat,
      mute: mute ?? this.mute,
      autoPlay: autoPlay ?? this.autoPlay,
      theaterMode: theaterMode ?? this.theaterMode,
      timer: timer ?? this.timer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'repeat': repeat,
      'mute': mute,
      'autoPlay': autoPlay,
      'theaterMode': theaterMode,
      'timer': timer.inMilliseconds,
    };
  }

  factory PhotoViewSettingsModel.fromMap(Map<String, dynamic> map) {
    return PhotoViewSettingsModel(
      repeat: map['repeat'] ?? false,
      mute: map['mute'] ?? false,
      autoPlay: map['autoPlay'] ?? false,
      theaterMode: map['theaterMode'] ?? false,
      timer: map['timer'] != null ? Duration(milliseconds: map['timer'] as int) : const Duration(seconds: 15),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoViewSettingsModel.fromJson(String source) => PhotoViewSettingsModel.fromMap(json.decode(source));
}

final photoViewSettingsProvider = StateNotifierProvider<PhotoViewSettingsNotifier, PhotoViewSettingsModel>((ref) {
  return PhotoViewSettingsNotifier(ref);
});

class PhotoViewSettingsNotifier extends StateNotifier<PhotoViewSettingsModel> {
  PhotoViewSettingsNotifier(this.ref) : super(PhotoViewSettingsModel());

  final Ref ref;

  @override
  set state(PhotoViewSettingsModel value) {
    super.state = value;
    ref.read(sharedUtilityProvider).photoViewSettings = value;
  }

  PhotoViewSettingsModel update(PhotoViewSettingsModel Function(PhotoViewSettingsModel state) cb) => state = cb(state);
}
