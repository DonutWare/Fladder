// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_info_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionInfoModel _$SessionInfoModelFromJson(Map<String, dynamic> json) =>
    _SessionInfoModel(
      playbackModel: json['playbackModel'] as String?,
      transCodeInfo: json['transCodeInfo'] == null
          ? null
          : TranscodingInfo.fromJson(
              json['transCodeInfo'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SessionInfoModelToJson(_SessionInfoModel instance) =>
    <String, dynamic>{
      'playbackModel': instance.playbackModel,
      'transCodeInfo': instance.transCodeInfo,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SessionInfo)
final sessionInfoProvider = SessionInfoProvider._();

final class SessionInfoProvider
    extends $NotifierProvider<SessionInfo, SessionInfoModel> {
  SessionInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionInfoHash();

  @$internal
  @override
  SessionInfo create() => SessionInfo();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionInfoModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionInfoModel>(value),
    );
  }
}

String _$sessionInfoHash() => r'930c82b5a0bc97d983f816388d1b436477a73bec';

abstract class _$SessionInfo extends $Notifier<SessionInfoModel> {
  SessionInfoModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SessionInfoModel, SessionInfoModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SessionInfoModel, SessionInfoModel>,
              SessionInfoModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
