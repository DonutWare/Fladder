// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlActivity)
final controlActivityProvider = ControlActivityProvider._();

final class ControlActivityProvider
    extends $NotifierProvider<ControlActivity, List<ControlActivityModel>> {
  ControlActivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlActivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlActivityHash();

  @$internal
  @override
  ControlActivity create() => ControlActivity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ControlActivityModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ControlActivityModel>>(value),
    );
  }
}

String _$controlActivityHash() => r'08254d9b2a33e35be5ec367097fa30624a5f60c7';

abstract class _$ControlActivity extends $Notifier<List<ControlActivityModel>> {
  List<ControlActivityModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<List<ControlActivityModel>, List<ControlActivityModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<ControlActivityModel>,
                List<ControlActivityModel>
              >,
              List<ControlActivityModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
