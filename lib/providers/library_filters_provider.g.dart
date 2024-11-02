// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_filters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryFiltersHash() => r'fd98699d8d7c1db6daefa6e53d5d90f989a8f776';

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

abstract class _$LibraryFilters
    extends BuildlessAutoDisposeNotifier<List<LibraryFiltersModel>> {
  late final List<String> ids;

  List<LibraryFiltersModel> build(
    List<String> ids,
  );
}

/// See also [LibraryFilters].
@ProviderFor(LibraryFilters)
const libraryFiltersProvider = LibraryFiltersFamily();

/// See also [LibraryFilters].
class LibraryFiltersFamily extends Family<List<LibraryFiltersModel>> {
  /// See also [LibraryFilters].
  const LibraryFiltersFamily();

  /// See also [LibraryFilters].
  LibraryFiltersProvider call(
    List<String> ids,
  ) {
    return LibraryFiltersProvider(
      ids,
    );
  }

  @override
  LibraryFiltersProvider getProviderOverride(
    covariant LibraryFiltersProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'libraryFiltersProvider';
}

/// See also [LibraryFilters].
class LibraryFiltersProvider extends AutoDisposeNotifierProviderImpl<
    LibraryFilters, List<LibraryFiltersModel>> {
  /// See also [LibraryFilters].
  LibraryFiltersProvider(
    List<String> ids,
  ) : this._internal(
          () => LibraryFilters()..ids = ids,
          from: libraryFiltersProvider,
          name: r'libraryFiltersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$libraryFiltersHash,
          dependencies: LibraryFiltersFamily._dependencies,
          allTransitiveDependencies:
              LibraryFiltersFamily._allTransitiveDependencies,
          ids: ids,
        );

  LibraryFiltersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
  }) : super.internal();

  final List<String> ids;

  @override
  List<LibraryFiltersModel> runNotifierBuild(
    covariant LibraryFilters notifier,
  ) {
    return notifier.build(
      ids,
    );
  }

  @override
  Override overrideWith(LibraryFilters Function() create) {
    return ProviderOverride(
      origin: this,
      override: LibraryFiltersProvider._internal(
        () => create()..ids = ids,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LibraryFilters, List<LibraryFiltersModel>>
      createElement() {
    return _LibraryFiltersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryFiltersProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LibraryFiltersRef
    on AutoDisposeNotifierProviderRef<List<LibraryFiltersModel>> {
  /// The parameter `ids` of this provider.
  List<String> get ids;
}

class _LibraryFiltersProviderElement extends AutoDisposeNotifierProviderElement<
    LibraryFilters, List<LibraryFiltersModel>> with LibraryFiltersRef {
  _LibraryFiltersProviderElement(super.provider);

  @override
  List<String> get ids => (origin as LibraryFiltersProvider).ids;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
