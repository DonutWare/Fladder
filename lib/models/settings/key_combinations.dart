import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/screens/settings/widgets/key_listener.dart';

part 'key_combinations.freezed.dart';
part 'key_combinations.g.dart';

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
