// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotkeys_model.dart';

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

_$HotKeysModelImpl _$$HotKeysModelImplFromJson(Map<String, dynamic> json) =>
    _$HotKeysModelImpl(
      shortCuts: (json['shortCuts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                $enumDecode(_$HotKeysEnumMap, k),
                e == null
                    ? null
                    : KeyCombination.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$HotKeysModelImplToJson(_$HotKeysModelImpl instance) =>
    <String, dynamic>{
      'shortCuts':
          instance.shortCuts.map((k, e) => MapEntry(_$HotKeysEnumMap[k]!, e)),
    };

const _$HotKeysEnumMap = {
  HotKeys.playPause: 'playPause',
  HotKeys.seekForward: 'seekForward',
  HotKeys.seekBack: 'seekBack',
  HotKeys.mute: 'mute',
  HotKeys.volumeUp: 'volumeUp',
  HotKeys.volumeDown: 'volumeDown',
  HotKeys.nextVideo: 'nextVideo',
  HotKeys.prevVideo: 'prevVideo',
  HotKeys.nextChapter: 'nextChapter',
  HotKeys.prevChapter: 'prevChapter',
  HotKeys.fullScreen: 'fullScreen',
  HotKeys.skipMediaSegment: 'skipMediaSegment',
};
