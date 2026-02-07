// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelDetailsHash() => r'0ea922807f6d864b041ba827ad02039c709ab810';

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

abstract class _$ChannelDetails
    extends BuildlessAutoDisposeNotifier<ChannelModel?> {
  late final String id;

  ChannelModel? build(
    String id,
  );
}

/// See also [ChannelDetails].
@ProviderFor(ChannelDetails)
const channelDetailsProvider = ChannelDetailsFamily();

/// See also [ChannelDetails].
class ChannelDetailsFamily extends Family<ChannelModel?> {
  /// See also [ChannelDetails].
  const ChannelDetailsFamily();

  /// See also [ChannelDetails].
  ChannelDetailsProvider call(
    String id,
  ) {
    return ChannelDetailsProvider(
      id,
    );
  }

  @override
  ChannelDetailsProvider getProviderOverride(
    covariant ChannelDetailsProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'channelDetailsProvider';
}

/// See also [ChannelDetails].
class ChannelDetailsProvider
    extends AutoDisposeNotifierProviderImpl<ChannelDetails, ChannelModel?> {
  /// See also [ChannelDetails].
  ChannelDetailsProvider(
    String id,
  ) : this._internal(
          () => ChannelDetails()..id = id,
          from: channelDetailsProvider,
          name: r'channelDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelDetailsHash,
          dependencies: ChannelDetailsFamily._dependencies,
          allTransitiveDependencies:
              ChannelDetailsFamily._allTransitiveDependencies,
          id: id,
        );

  ChannelDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  ChannelModel? runNotifierBuild(
    covariant ChannelDetails notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ChannelDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelDetailsProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChannelDetails, ChannelModel?>
      createElement() {
    return _ChannelDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChannelDetailsRef on AutoDisposeNotifierProviderRef<ChannelModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ChannelDetailsProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelDetails, ChannelModel?>
    with ChannelDetailsRef {
  _ChannelDetailsProviderElement(super.provider);

  @override
  String get id => (origin as ChannelDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
