import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_combinations.freezed.dart';
part 'key_combinations.g.dart';

@Freezed(toJson: true, fromJson: true, copyWith: true)
abstract class KeyCombination with _$KeyCombination {
  const KeyCombination._();

  factory KeyCombination({
    @LogicalKeyboardSerializer() LogicalKeyboardKey? key,
    @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
    @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
    @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier,
  }) = _KeyCombination;

  factory KeyCombination.fromJson(Map<String, dynamic> json) => _$KeyCombinationFromJson(json);

  @override
  bool operator ==(covariant other) {
    return other is KeyCombination &&
        other.key?.keyId == key?.keyId &&
        other.modifier?.keyId == modifier?.keyId &&
        other.altKey?.keyId == altKey?.keyId &&
        other.altModifier?.keyId == altModifier?.keyId;
  }

  bool containsSameSet(KeyCombination other) {
    return ((key?.keyId == other.key?.keyId) && modifierMatches(modifier, other.modifier)) ||
        ((altKey?.keyId == other.key?.keyId) && modifierMatches(altModifier, other.modifier));
  }

  @override
  int get hashCode => key.hashCode ^ modifier.hashCode ^ altKey.hashCode ^ altModifier.hashCode;

  String get label => [modifier?.label, key?.label].nonNulls.join(" + ");
  String get altLabel => [altModifier?.label, altKey?.label].nonNulls.join(" + ");

  KeyCombination? get altSet => altKey != null
      ? copyWith(
          key: altKey!,
          modifier: altModifier,
        )
      : null;

  KeyCombination setKeys(
    LogicalKeyboardKey? key, {
    LogicalKeyboardKey? modifier,
    bool alt = false,
  }) {
    return alt
        ? copyWith(
            altKey: key,
            altModifier: modifier,
          )
        : copyWith(
            key: key ?? altKey,
            modifier: key == null ? altModifier : modifier,
            altKey: key == null ? null : altKey,
            altModifier: key == null ? null : altModifier,
          );
  }

  static final Set<LogicalKeyboardKey> shiftKeys = {
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.shiftLeft,
    LogicalKeyboardKey.shiftRight,
  };

  static final altKeys = {
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.altRight,
    LogicalKeyboardKey.altLeft,
  };

  static final ctrlKeys = {
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.controlLeft,
    LogicalKeyboardKey.controlRight,
  };

  static final superKeys = {
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.metaLeft,
    LogicalKeyboardKey.metaRight,
    LogicalKeyboardKey.superKey,
  };

  static final modifierKeys = {
    ...shiftKeys,
    ...altKeys,
    ...ctrlKeys,
    ...superKeys,
  };

  static bool modifierMatches(LogicalKeyboardKey? pressedModifier, LogicalKeyboardKey? configuredModifier) {
    if (pressedModifier == configuredModifier) return true;
    if (pressedModifier == null || configuredModifier == null) return false;

    // Keep left/right distinction for Shift/Alt/Ctrl, but normalize macOS Command/Super variants.
    return superKeys.contains(pressedModifier) && superKeys.contains(configuredModifier);
  }
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

extension LogicalKeyExtension on LogicalKeyboardKey {
  String get label {
    return switch (this) {
      LogicalKeyboardKey.space => "Space",

      // macOS-style modifier symbols
      LogicalKeyboardKey.meta ||
      LogicalKeyboardKey.metaLeft ||
      LogicalKeyboardKey.metaRight ||
      LogicalKeyboardKey.superKey =>
        defaultTargetPlatform == TargetPlatform.macOS ? "⌘" : "Super",
      LogicalKeyboardKey.alt ||
      LogicalKeyboardKey.altLeft ||
      LogicalKeyboardKey.altRight =>
        defaultTargetPlatform == TargetPlatform.macOS ? "⌥" : "Alt",
      LogicalKeyboardKey.control ||
      LogicalKeyboardKey.controlLeft ||
      LogicalKeyboardKey.controlRight =>
        defaultTargetPlatform == TargetPlatform.macOS ? "⌃" : "Ctrl",
      LogicalKeyboardKey.shift || LogicalKeyboardKey.shiftLeft || LogicalKeyboardKey.shiftRight => "Shift ⇧",
      LogicalKeyboardKey.arrowUp => "↑",
      LogicalKeyboardKey.arrowDown => "↓",
      LogicalKeyboardKey.arrowLeft => "←",
      LogicalKeyboardKey.arrowRight => "→",
      _ => keyLabel.isNotEmpty ? keyLabel : (debugName ?? ""),
    };
  }
}

extension KeyMapExtension<T> on Map<T, KeyCombination> {
  Map<T, KeyCombination> setOrRemove(MapEntry<T, KeyCombination> newEntry, Map<T, KeyCombination> defaultShortCuts) {
    if (newEntry.value == defaultShortCuts[newEntry.key]) {
      final currentShortcuts = Map.fromEntries(entries);
      return (currentShortcuts..remove(newEntry.key));
    } else {
      final currentShortcuts = Map.fromEntries(entries);
      currentShortcuts.update(
        newEntry.key,
        (value) => newEntry.value,
        ifAbsent: () => newEntry.value,
      );
      return currentShortcuts;
    }
  }
}
