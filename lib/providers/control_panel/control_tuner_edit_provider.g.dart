// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_tuner_edit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$controlTunerEditHash() => r'47ce244d1dac1eda518a8797f4318c35d07e9656';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ControlTunerEdit
    extends BuildlessAutoDisposeNotifier<ControlTunerEditModel> {
  late final TunerHostInfo? initialTuner;

  ControlTunerEditModel build(
    TunerHostInfo? initialTuner,
  );
}

/// See also [ControlTunerEdit].
@ProviderFor(ControlTunerEdit)
const controlTunerEditProvider = ControlTunerEditFamily();

/// See also [ControlTunerEdit].
class ControlTunerEditFamily extends Family<ControlTunerEditModel> {
  /// See also [ControlTunerEdit].
  const ControlTunerEditFamily();

  /// See also [ControlTunerEdit].
  ControlTunerEditProvider call(
    TunerHostInfo? initialTuner,
  ) {
    return ControlTunerEditProvider(
      initialTuner,
    );
  }

  @override
  ControlTunerEditProvider getProviderOverride(
    covariant ControlTunerEditProvider provider,
  ) {
    return call(
      provider.initialTuner,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'controlTunerEditProvider';
}

/// See also [ControlTunerEdit].
class ControlTunerEditProvider extends AutoDisposeNotifierProviderImpl<
    ControlTunerEdit, ControlTunerEditModel> {
  /// See also [ControlTunerEdit].
  ControlTunerEditProvider(
    TunerHostInfo? initialTuner,
  ) : this._internal(
          () => ControlTunerEdit()..initialTuner = initialTuner,
          from: controlTunerEditProvider,
          name: r'controlTunerEditProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$controlTunerEditHash,
          dependencies: ControlTunerEditFamily._dependencies,
          allTransitiveDependencies:
              ControlTunerEditFamily._allTransitiveDependencies,
          initialTuner: initialTuner,
        );

  ControlTunerEditProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialTuner,
  }) : super.internal();

  final TunerHostInfo? initialTuner;

  @override
  ControlTunerEditModel runNotifierBuild(
    covariant ControlTunerEdit notifier,
  ) {
    return notifier.build(
      initialTuner,
    );
  }

  @override
  Override overrideWith(ControlTunerEdit Function() create) {
    return ProviderOverride(
      origin: this,
      override: ControlTunerEditProvider._internal(
        () => create()..initialTuner = initialTuner,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialTuner: initialTuner,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ControlTunerEdit, ControlTunerEditModel>
      createElement() {
    return _ControlTunerEditProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ControlTunerEditProvider &&
        other.initialTuner == initialTuner;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialTuner.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ControlTunerEditRef
    on AutoDisposeNotifierProviderRef<ControlTunerEditModel> {
  /// The parameter `initialTuner` of this provider.
  TunerHostInfo? get initialTuner;
}

class _ControlTunerEditProviderElement
    extends AutoDisposeNotifierProviderElement<ControlTunerEdit,
        ControlTunerEditModel> with ControlTunerEditRef {
  _ControlTunerEditProviderElement(super.provider);

  @override
  TunerHostInfo? get initialTuner =>
      (origin as ControlTunerEditProvider).initialTuner;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
