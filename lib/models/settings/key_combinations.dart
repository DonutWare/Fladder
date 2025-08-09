import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_combinations.freezed.dart';
part 'key_combinations.g.dart';

@Freezed(toJson: true, fromJson: true, copyWith: true)
class KeyCombination with _$KeyCombination {
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
    return (key == other.key && modifier == other.modifier) || (altKey == other.key && altModifier == other.modifier);
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

  static final modifierKeys = {
    ...shiftKeys,
    ...altKeys,
    ...ctrlKeys,
  };
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
    return switch (this) { LogicalKeyboardKey.space => "Space", _ => keyLabel };
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
