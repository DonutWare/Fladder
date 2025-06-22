// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'item_shared_models.dart';

class UserDataMapper extends ClassMapperBase<UserData> {
  UserDataMapper._();

  static UserDataMapper? _instance;
  static UserDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserData';

  static bool _$isFavourite(UserData v) => v.isFavourite;
  static const Field<UserData, bool> _f$isFavourite =
      Field('isFavourite', _$isFavourite, opt: true, def: false);
  static int _$playCount(UserData v) => v.playCount;
  static const Field<UserData, int> _f$playCount =
      Field('playCount', _$playCount, opt: true, def: 0);
  static int? _$unPlayedItemCount(UserData v) => v.unPlayedItemCount;
  static const Field<UserData, int> _f$unPlayedItemCount =
      Field('unPlayedItemCount', _$unPlayedItemCount, opt: true);
  static int _$playbackPositionTicks(UserData v) => v.playbackPositionTicks;
  static const Field<UserData, int> _f$playbackPositionTicks = Field(
      'playbackPositionTicks', _$playbackPositionTicks,
      opt: true, def: 0);
  static double _$progress(UserData v) => v.progress;
  static const Field<UserData, double> _f$progress =
      Field('progress', _$progress, opt: true, def: 0);
  static DateTime? _$lastPlayed(UserData v) => v.lastPlayed;
  static const Field<UserData, DateTime> _f$lastPlayed =
      Field('lastPlayed', _$lastPlayed, opt: true);
  static bool _$played(UserData v) => v.played;
  static const Field<UserData, bool> _f$played =
      Field('played', _$played, opt: true, def: false);

  @override
  final MappableFields<UserData> fields = const {
    #isFavourite: _f$isFavourite,
    #playCount: _f$playCount,
    #unPlayedItemCount: _f$unPlayedItemCount,
    #playbackPositionTicks: _f$playbackPositionTicks,
    #progress: _f$progress,
    #lastPlayed: _f$lastPlayed,
    #played: _f$played,
  };
  @override
  final bool ignoreNull = true;

  static UserData _instantiate(DecodingData data) {
    return UserData(
        isFavourite: data.dec(_f$isFavourite),
        playCount: data.dec(_f$playCount),
        unPlayedItemCount: data.dec(_f$unPlayedItemCount),
        playbackPositionTicks: data.dec(_f$playbackPositionTicks),
        progress: data.dec(_f$progress),
        lastPlayed: data.dec(_f$lastPlayed),
        played: data.dec(_f$played));
  }

  @override
  final Function instantiate = _instantiate;

  static UserData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserData>(map);
  }

  static UserData fromJson(String json) {
    return ensureInitialized().decodeJson<UserData>(json);
  }
}

mixin UserDataMappable {
  String toJson() {
    return UserDataMapper.ensureInitialized()
        .encodeJson<UserData>(this as UserData);
  }

  Map<String, dynamic> toMap() {
    return UserDataMapper.ensureInitialized()
        .encodeMap<UserData>(this as UserData);
  }

  UserDataCopyWith<UserData, UserData, UserData> get copyWith =>
      _UserDataCopyWithImpl(this as UserData, $identity, $identity);
}

extension UserDataValueCopy<$R, $Out> on ObjectCopyWith<$R, UserData, $Out> {
  UserDataCopyWith<$R, UserData, $Out> get $asUserData =>
      $base.as((v, t, t2) => _UserDataCopyWithImpl(v, t, t2));
}

abstract class UserDataCopyWith<$R, $In extends UserData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {bool? isFavourite,
      int? playCount,
      int? unPlayedItemCount,
      int? playbackPositionTicks,
      double? progress,
      DateTime? lastPlayed,
      bool? played});
  UserDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserData, $Out>
    implements UserDataCopyWith<$R, UserData, $Out> {
  _UserDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserData> $mapper =
      UserDataMapper.ensureInitialized();
  @override
  $R call(
          {bool? isFavourite,
          int? playCount,
          Object? unPlayedItemCount = $none,
          int? playbackPositionTicks,
          double? progress,
          Object? lastPlayed = $none,
          bool? played}) =>
      $apply(FieldCopyWithData({
        if (isFavourite != null) #isFavourite: isFavourite,
        if (playCount != null) #playCount: playCount,
        if (unPlayedItemCount != $none) #unPlayedItemCount: unPlayedItemCount,
        if (playbackPositionTicks != null)
          #playbackPositionTicks: playbackPositionTicks,
        if (progress != null) #progress: progress,
        if (lastPlayed != $none) #lastPlayed: lastPlayed,
        if (played != null) #played: played
      }));
  @override
  UserData $make(CopyWithData data) => UserData(
      isFavourite: data.get(#isFavourite, or: $value.isFavourite),
      playCount: data.get(#playCount, or: $value.playCount),
      unPlayedItemCount:
          data.get(#unPlayedItemCount, or: $value.unPlayedItemCount),
      playbackPositionTicks:
          data.get(#playbackPositionTicks, or: $value.playbackPositionTicks),
      progress: data.get(#progress, or: $value.progress),
      lastPlayed: data.get(#lastPlayed, or: $value.lastPlayed),
      played: data.get(#played, or: $value.played));

  @override
  UserDataCopyWith<$R2, UserData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserDataCopyWithImpl($value, $cast, t);
}
