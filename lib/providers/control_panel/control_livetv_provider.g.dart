// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_livetv_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlLiveTv)
final controlLiveTvProvider = ControlLiveTvProvider._();

final class ControlLiveTvProvider
    extends $NotifierProvider<ControlLiveTv, ControlLiveTvModel> {
  ControlLiveTvProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlLiveTvProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlLiveTvHash();

  @$internal
  @override
  ControlLiveTv create() => ControlLiveTv();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlLiveTvModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlLiveTvModel>(value),
    );
  }
}

String _$controlLiveTvHash() => r'bb40d4b6bcbb2a18bf6041bf4b73f2ccd94d8e9b';

abstract class _$ControlLiveTv extends $Notifier<ControlLiveTvModel> {
  ControlLiveTvModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ControlLiveTvModel, ControlLiveTvModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlLiveTvModel, ControlLiveTvModel>,
              ControlLiveTvModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
