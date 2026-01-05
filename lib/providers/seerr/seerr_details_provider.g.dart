// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$seerrDetailsHash() => r'5d32aaebe04d6322974626858e92c8b1a3149517';

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

abstract class _$SeerrDetails
    extends BuildlessAutoDisposeNotifier<SeerrDetailsModel> {
  late final int tmdbId;
  late final SeerrMediaType mediaType;
  late final SeerrDashboardPosterModel? poster;

  SeerrDetailsModel build({
    required int tmdbId,
    required SeerrMediaType mediaType,
    SeerrDashboardPosterModel? poster,
  });
}

/// See also [SeerrDetails].
@ProviderFor(SeerrDetails)
const seerrDetailsProvider = SeerrDetailsFamily();

/// See also [SeerrDetails].
class SeerrDetailsFamily extends Family<SeerrDetailsModel> {
  /// See also [SeerrDetails].
  const SeerrDetailsFamily();

  /// See also [SeerrDetails].
  SeerrDetailsProvider call({
    required int tmdbId,
    required SeerrMediaType mediaType,
    SeerrDashboardPosterModel? poster,
  }) {
    return SeerrDetailsProvider(
      tmdbId: tmdbId,
      mediaType: mediaType,
      poster: poster,
    );
  }

  @override
  SeerrDetailsProvider getProviderOverride(
    covariant SeerrDetailsProvider provider,
  ) {
    return call(
      tmdbId: provider.tmdbId,
      mediaType: provider.mediaType,
      poster: provider.poster,
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
  String? get name => r'seerrDetailsProvider';
}

/// See also [SeerrDetails].
class SeerrDetailsProvider
    extends AutoDisposeNotifierProviderImpl<SeerrDetails, SeerrDetailsModel> {
  /// See also [SeerrDetails].
  SeerrDetailsProvider({
    required int tmdbId,
    required SeerrMediaType mediaType,
    SeerrDashboardPosterModel? poster,
  }) : this._internal(
          () => SeerrDetails()
            ..tmdbId = tmdbId
            ..mediaType = mediaType
            ..poster = poster,
          from: seerrDetailsProvider,
          name: r'seerrDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$seerrDetailsHash,
          dependencies: SeerrDetailsFamily._dependencies,
          allTransitiveDependencies:
              SeerrDetailsFamily._allTransitiveDependencies,
          tmdbId: tmdbId,
          mediaType: mediaType,
          poster: poster,
        );

  SeerrDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tmdbId,
    required this.mediaType,
    required this.poster,
  }) : super.internal();

  final int tmdbId;
  final SeerrMediaType mediaType;
  final SeerrDashboardPosterModel? poster;

  @override
  SeerrDetailsModel runNotifierBuild(
    covariant SeerrDetails notifier,
  ) {
    return notifier.build(
      tmdbId: tmdbId,
      mediaType: mediaType,
      poster: poster,
    );
  }

  @override
  Override overrideWith(SeerrDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: SeerrDetailsProvider._internal(
        () => create()
          ..tmdbId = tmdbId
          ..mediaType = mediaType
          ..poster = poster,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tmdbId: tmdbId,
        mediaType: mediaType,
        poster: poster,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SeerrDetails, SeerrDetailsModel>
      createElement() {
    return _SeerrDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeerrDetailsProvider &&
        other.tmdbId == tmdbId &&
        other.mediaType == mediaType &&
        other.poster == poster;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tmdbId.hashCode);
    hash = _SystemHash.combine(hash, mediaType.hashCode);
    hash = _SystemHash.combine(hash, poster.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SeerrDetailsRef on AutoDisposeNotifierProviderRef<SeerrDetailsModel> {
  /// The parameter `tmdbId` of this provider.
  int get tmdbId;

  /// The parameter `mediaType` of this provider.
  SeerrMediaType get mediaType;

  /// The parameter `poster` of this provider.
  SeerrDashboardPosterModel? get poster;
}

class _SeerrDetailsProviderElement
    extends AutoDisposeNotifierProviderElement<SeerrDetails, SeerrDetailsModel>
    with SeerrDetailsRef {
  _SeerrDetailsProviderElement(super.provider);

  @override
  int get tmdbId => (origin as SeerrDetailsProvider).tmdbId;
  @override
  SeerrMediaType get mediaType => (origin as SeerrDetailsProvider).mediaType;
  @override
  SeerrDashboardPosterModel? get poster =>
      (origin as SeerrDetailsProvider).poster;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
