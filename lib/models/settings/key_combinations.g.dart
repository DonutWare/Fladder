// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_combinations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeyCombinationImpl _$$KeyCombinationImplFromJson(Map<String, dynamic> json) =>
    _$KeyCombinationImpl(
      modifier: _$JsonConverterFromJson<String, LogicalKeyboardKey>(
          json['modifier'], const LogicalKeyboardSerializer().fromJson),
      key: const LogicalKeyboardSerializer().fromJson(json['key'] as String),
    );

Map<String, dynamic> _$$KeyCombinationImplToJson(
        _$KeyCombinationImpl instance) =>
    <String, dynamic>{
      'modifier': _$JsonConverterToJson<String, LogicalKeyboardKey>(
          instance.modifier, const LogicalKeyboardSerializer().toJson),
      'key': const LogicalKeyboardSerializer().toJson(instance.key),
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
