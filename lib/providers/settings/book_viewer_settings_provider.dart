import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/util/debouncer.dart';

enum ReadDirection {
  leftToRight,
  rightToLeft;

  String toMap() => name;
  static ReadDirection fromMap(String? map) {
    return ReadDirection.values.firstWhereOrNull((element) => element.name == map) ?? ReadDirection.leftToRight;
  }
}

enum InitZoomState {
  contained,
  covered;

  String toMap() => name;

  static InitZoomState fromMap(String? map) {
    return InitZoomState.values.firstWhereOrNull((element) => element.name == map) ?? InitZoomState.contained;
  }
}

enum GestureCache {
  contained,
  covered;

  String toMap() => name;

  static InitZoomState fromMap(String? map) {
    return InitZoomState.values.firstWhereOrNull((element) => element.name == map) ?? InitZoomState.contained;
  }
}

class BookViewerSettingsModel {
  final double? screenBrightness;
  final ReadDirection readDirection;
  final InitZoomState initZoomState;
  final bool cachePageZoom;
  final bool keepPageZoom;
  final bool disableScrollOnZoom;

  BookViewerSettingsModel({
    this.screenBrightness,
    this.readDirection = ReadDirection.leftToRight,
    this.initZoomState = InitZoomState.contained,
    this.cachePageZoom = false,
    this.keepPageZoom = true,
    this.disableScrollOnZoom = false,
  });

  BookViewerSettingsModel copyWith({
    ValueGetter<double?>? screenBrightness,
    ReadDirection? readDirection,
    InitZoomState? initZoomState,
    bool? cachePageZoom,
    bool? keepPageZoom,
    bool? disableScrollOnZoom,
  }) {
    return BookViewerSettingsModel(
      screenBrightness: screenBrightness != null ? screenBrightness.call() : this.screenBrightness,
      readDirection: readDirection ?? this.readDirection,
      initZoomState: initZoomState ?? this.initZoomState,
      cachePageZoom: cachePageZoom ?? this.cachePageZoom,
      keepPageZoom: keepPageZoom ?? this.keepPageZoom,
      disableScrollOnZoom: disableScrollOnZoom ?? this.disableScrollOnZoom,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'screenBrightness': screenBrightness,
      'readDirection': readDirection.toMap(),
      'initZoomState': initZoomState.toMap(),
      'cachePageZoom': cachePageZoom,
      'keepPageZoom': keepPageZoom,
      'disableScrollOnZoom': disableScrollOnZoom,
    };
  }

  factory BookViewerSettingsModel.fromMap(Map<String, dynamic> map) {
    return BookViewerSettingsModel(
      screenBrightness: map['screenBrightness']?.toDouble(),
      readDirection: ReadDirection.fromMap(map['readDirection']),
      initZoomState: InitZoomState.fromMap(map['initZoomState']),
      cachePageZoom: map['cachePageZoom'] ?? false,
      keepPageZoom: map['keepPageZoom'] ?? true,
      disableScrollOnZoom: map['disableScrollOnZoom'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookViewerSettingsModel.fromJson(String source) => BookViewerSettingsModel.fromMap(json.decode(source));
}

final bookViewerSettingsProvider = StateNotifierProvider<BookViewerSettingsNotifier, BookViewerSettingsModel>((ref) {
  return BookViewerSettingsNotifier(ref);
});

class BookViewerSettingsNotifier extends StateNotifier<BookViewerSettingsModel> {
  BookViewerSettingsNotifier(this.ref) : super(BookViewerSettingsModel());

  final Ref ref;

  final Debouncer _debouncer = Debouncer(const Duration(seconds: 1));

  @override
  set state(BookViewerSettingsModel value) {
    _debouncer.run(() => ref.read(sharedUtilityProvider).bookViewSettings = value);
    super.state = value;
  }

  void setScreenBrightness(double? value) async {
    state = state.copyWith(
      screenBrightness: () => value,
    );
    if (state.screenBrightness != null) {
      ScreenBrightness().setApplicationScreenBrightness(state.screenBrightness!);
    } else {
      ScreenBrightness().resetApplicationScreenBrightness();
    }
  }

  void setSavedBrightness() {
    if (state.screenBrightness != null) {
      ScreenBrightness().setApplicationScreenBrightness(state.screenBrightness!);
    }
  }

  void update(BookViewerSettingsModel Function(BookViewerSettingsModel state) outgoing) => state = outgoing(state);
}
