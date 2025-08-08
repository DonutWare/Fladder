import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/screens/settings/widgets/key_listener.dart';

part 'hotkeys_model.freezed.dart';
part 'hotkeys_model.g.dart';

enum HotKeys {
  playPause,
  seekForward,
  seekBack,
  mute,
  volumeUp,
  volumeDown,
  nextVideo,
  prevVideo,
  nextChapter,
  prevChapter,
  fullScreen,
  skipMediaSegment,
}

@Freezed(toJson: true, fromJson: true)
class KeyCombination with _$KeyCombination {
  const KeyCombination._();

  factory KeyCombination({
    @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
    @LogicalKeyboardSerializer() required LogicalKeyboardKey key,
  }) = _KeyCombination;

  factory KeyCombination.fromJson(Map<String, dynamic> json) => _$KeyCombinationFromJson(json);

  @override
  bool operator ==(covariant other) {
    return other is KeyCombination && other.key.keyId == key.keyId && other.modifier?.keyId == modifier?.keyId;
  }

  @override
  int get hashCode => key.hashCode ^ modifier.hashCode;

  String get label => [modifier?.label, key.label].nonNulls.join(" + ");
}

class LogicalKeyboardSerializer extends JsonConverter<LogicalKeyboardKey, String> {
  const LogicalKeyboardSerializer();

  @override
  LogicalKeyboardKey fromJson(String json) {
    return LogicalKeyboardKey.findKeyByKeyId(int.parse(jsonDecode(json))) ?? LogicalKeyboardKey.abort;
  }

  @override
  String toJson(LogicalKeyboardKey object) {
    return jsonEncode(object.keyId.toString());
  }
}

@Freezed(toJson: true, fromJson: true, copyWith: true)
class HotKeysModel with _$HotKeysModel {
  const HotKeysModel._();

  factory HotKeysModel({
    @Default(Duration(seconds: 10)) Duration forwardStep,
    @Default(Duration(seconds: 30)) Duration backwardStep,
    @Default({}) Map<HotKeys, KeyCombination?> shortCuts,
  }) = _HotKeysModel;

  factory HotKeysModel.fromJson(Map<String, dynamic> json) => _$HotKeysModelFromJson(json);

  Map<HotKeys, KeyCombination> get currentShortcuts =>
      defaultHotKeys.map((key, value) => MapEntry(key, shortCuts[key] ?? value));
}

Map<HotKeys, KeyCombination> get defaultHotKeys => {
      for (var hotKey in HotKeys.values)
        hotKey: switch (hotKey) {
          HotKeys.playPause => KeyCombination(key: LogicalKeyboardKey.space),
          HotKeys.seekForward => KeyCombination(key: LogicalKeyboardKey.arrowRight),
          HotKeys.seekBack => KeyCombination(key: LogicalKeyboardKey.arrowLeft),
          HotKeys.mute => KeyCombination(key: LogicalKeyboardKey.keyM),
          HotKeys.volumeUp => KeyCombination(key: LogicalKeyboardKey.arrowUp),
          HotKeys.volumeDown => KeyCombination(key: LogicalKeyboardKey.arrowDown),
          HotKeys.prevVideo => KeyCombination(key: LogicalKeyboardKey.keyP, modifier: LogicalKeyboardKey.shift),
          HotKeys.nextVideo => KeyCombination(key: LogicalKeyboardKey.keyN, modifier: LogicalKeyboardKey.shift),
          HotKeys.nextChapter => KeyCombination(key: LogicalKeyboardKey.pageUp),
          HotKeys.prevChapter => KeyCombination(key: LogicalKeyboardKey.pageDown),
          HotKeys.fullScreen => KeyCombination(key: LogicalKeyboardKey.keyF),
          HotKeys.skipMediaSegment => KeyCombination(key: LogicalKeyboardKey.keyS),
        },
    };
