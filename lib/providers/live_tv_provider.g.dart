// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_tv_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveTv)
final liveTvProvider = LiveTvProvider._();

final class LiveTvProvider extends $NotifierProvider<LiveTv, LiveTvModel> {
  LiveTvProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveTvProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveTvHash();

  @$internal
  @override
  LiveTv create() => LiveTv();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveTvModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveTvModel>(value),
    );
  }
}

String _$liveTvHash() => r'06fb75eeafd5f2d1bc860c2da7b7ca493a58d743';

abstract class _$LiveTv extends $Notifier<LiveTvModel> {
  LiveTvModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LiveTvModel, LiveTvModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LiveTvModel, LiveTvModel>,
              LiveTvModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
