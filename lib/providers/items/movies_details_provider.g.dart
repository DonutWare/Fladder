// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$movieDetailsHash() => r'872ea61464ef8493c7e6c559c526377f1c8f6a6d';

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

abstract class _$MovieDetails
    extends BuildlessAutoDisposeNotifier<MovieModel?> {
  late final String arg;

  MovieModel? build(
    String arg,
  );
}

/// See also [MovieDetails].
@ProviderFor(MovieDetails)
const movieDetailsProvider = MovieDetailsFamily();

/// See also [MovieDetails].
class MovieDetailsFamily extends Family<MovieModel?> {
  /// See also [MovieDetails].
  const MovieDetailsFamily();

  /// See also [MovieDetails].
  MovieDetailsProvider call(
    String arg,
  ) {
    return MovieDetailsProvider(
      arg,
    );
  }

  @override
  MovieDetailsProvider getProviderOverride(
    covariant MovieDetailsProvider provider,
  ) {
    return call(
      provider.arg,
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
  String? get name => r'movieDetailsProvider';
}

/// See also [MovieDetails].
class MovieDetailsProvider
    extends AutoDisposeNotifierProviderImpl<MovieDetails, MovieModel?> {
  /// See also [MovieDetails].
  MovieDetailsProvider(
    String arg,
  ) : this._internal(
          () => MovieDetails()..arg = arg,
          from: movieDetailsProvider,
          name: r'movieDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$movieDetailsHash,
          dependencies: MovieDetailsFamily._dependencies,
          allTransitiveDependencies:
              MovieDetailsFamily._allTransitiveDependencies,
          arg: arg,
        );

  MovieDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final String arg;

  @override
  MovieModel? runNotifierBuild(
    covariant MovieDetails notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(MovieDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: MovieDetailsProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MovieDetails, MovieModel?>
      createElement() {
    return _MovieDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MovieDetailsProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MovieDetailsRef on AutoDisposeNotifierProviderRef<MovieModel?> {
  /// The parameter `arg` of this provider.
  String get arg;
}

class _MovieDetailsProviderElement
    extends AutoDisposeNotifierProviderElement<MovieDetails, MovieModel?>
    with MovieDetailsRef {
  _MovieDetailsProviderElement(super.provider);

  @override
  String get arg => (origin as MovieDetailsProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
