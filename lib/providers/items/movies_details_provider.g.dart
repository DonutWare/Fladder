// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MovieDetails)
final movieDetailsProvider = MovieDetailsFamily._();

final class MovieDetailsProvider
    extends $NotifierProvider<MovieDetails, MovieModel?> {
  MovieDetailsProvider._({
    required MovieDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'movieDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$movieDetailsHash();

  @override
  String toString() {
    return r'movieDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MovieDetails create() => MovieDetails();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieModel?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MovieDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$movieDetailsHash() => r'83ddda576d78fa8652c3926a8fa18e6e81aee37a';

final class MovieDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          MovieDetails,
          MovieModel?,
          MovieModel?,
          MovieModel?,
          String
        > {
  MovieDetailsFamily._()
    : super(
        retry: null,
        name: r'movieDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MovieDetailsProvider call(String arg) =>
      MovieDetailsProvider._(argument: arg, from: this);

  @override
  String toString() => r'movieDetailsProvider';
}

abstract class _$MovieDetails extends $Notifier<MovieModel?> {
  late final _$args = ref.$arg as String;
  String get arg => _$args;

  MovieModel? build(String arg);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MovieModel?, MovieModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MovieModel?, MovieModel?>,
              MovieModel?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
