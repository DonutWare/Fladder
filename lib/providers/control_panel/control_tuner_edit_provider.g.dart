// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_tuner_edit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlTunerEdit)
final controlTunerEditProvider = ControlTunerEditFamily._();

final class ControlTunerEditProvider
    extends $NotifierProvider<ControlTunerEdit, ControlTunerEditModel> {
  ControlTunerEditProvider._({
    required ControlTunerEditFamily super.from,
    required TunerHostInfo? super.argument,
  }) : super(
         retry: null,
         name: r'controlTunerEditProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$controlTunerEditHash();

  @override
  String toString() {
    return r'controlTunerEditProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ControlTunerEdit create() => ControlTunerEdit();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlTunerEditModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlTunerEditModel>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ControlTunerEditProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$controlTunerEditHash() => r'2ae1e131b8c35ec20845af1b874be60f879ad47a';

final class ControlTunerEditFamily extends $Family
    with
        $ClassFamilyOverride<
          ControlTunerEdit,
          ControlTunerEditModel,
          ControlTunerEditModel,
          ControlTunerEditModel,
          TunerHostInfo?
        > {
  ControlTunerEditFamily._()
    : super(
        retry: null,
        name: r'controlTunerEditProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ControlTunerEditProvider call(TunerHostInfo? initialTuner) =>
      ControlTunerEditProvider._(argument: initialTuner, from: this);

  @override
  String toString() => r'controlTunerEditProvider';
}

abstract class _$ControlTunerEdit extends $Notifier<ControlTunerEditModel> {
  late final _$args = ref.$arg as TunerHostInfo?;
  TunerHostInfo? get initialTuner => _$args;

  ControlTunerEditModel build(TunerHostInfo? initialTuner);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ControlTunerEditModel, ControlTunerEditModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlTunerEditModel, ControlTunerEditModel>,
              ControlTunerEditModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
