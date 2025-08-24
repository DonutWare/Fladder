// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_combinations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KeyCombination _$KeyCombinationFromJson(Map<String, dynamic> json) =>
    _KeyCombination(
      key: _$JsonConverterFromJson<String, LogicalKeyboardKey>(
          json['key'], const LogicalKeyboardSerializer().fromJson),
      modifier: _$JsonConverterFromJson<String, LogicalKeyboardKey>(
          json['modifier'], const LogicalKeyboardSerializer().fromJson),
      altKey: _$JsonConverterFromJson<String, LogicalKeyboardKey>(
          json['altKey'], const LogicalKeyboardSerializer().fromJson),
      altModifier: _$JsonConverterFromJson<String, LogicalKeyboardKey>(
          json['altModifier'], const LogicalKeyboardSerializer().fromJson),
    );

Map<String, dynamic> _$KeyCombinationToJson(_KeyCombination instance) =>
    <String, dynamic>{
      'key': _$JsonConverterToJson<String, LogicalKeyboardKey>(
          instance.key, const LogicalKeyboardSerializer().toJson),
      'modifier': _$JsonConverterToJson<String, LogicalKeyboardKey>(
          instance.modifier, const LogicalKeyboardSerializer().toJson),
      'altKey': _$JsonConverterToJson<String, LogicalKeyboardKey>(
          instance.altKey, const LogicalKeyboardSerializer().toJson),
      'altModifier': _$JsonConverterToJson<String, LogicalKeyboardKey>(
          instance.altModifier, const LogicalKeyboardSerializer().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
