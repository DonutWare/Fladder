// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SeerrDetails)
final seerrDetailsProvider = SeerrDetailsFamily._();

final class SeerrDetailsProvider
    extends $NotifierProvider<SeerrDetails, SeerrDetailsModel> {
  SeerrDetailsProvider._({
    required SeerrDetailsFamily super.from,
    required ({
      int tmdbId,
      SeerrMediaType mediaType,
      SeerrDashboardPosterModel? poster,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'seerrDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$seerrDetailsHash();

  @override
  String toString() {
    return r'seerrDetailsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SeerrDetails create() => SeerrDetails();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeerrDetailsModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeerrDetailsModel>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SeerrDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$seerrDetailsHash() => r'155d620fed5592fd86d9f9b8158ff3afb678b322';

final class SeerrDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          SeerrDetails,
          SeerrDetailsModel,
          SeerrDetailsModel,
          SeerrDetailsModel,
          ({
            int tmdbId,
            SeerrMediaType mediaType,
            SeerrDashboardPosterModel? poster,
          })
        > {
  SeerrDetailsFamily._()
    : super(
        retry: null,
        name: r'seerrDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SeerrDetailsProvider call({
    required int tmdbId,
    required SeerrMediaType mediaType,
    SeerrDashboardPosterModel? poster,
  }) => SeerrDetailsProvider._(
    argument: (tmdbId: tmdbId, mediaType: mediaType, poster: poster),
    from: this,
  );

  @override
  String toString() => r'seerrDetailsProvider';
}

abstract class _$SeerrDetails extends $Notifier<SeerrDetailsModel> {
  late final _$args =
      ref.$arg
          as ({
            int tmdbId,
            SeerrMediaType mediaType,
            SeerrDashboardPosterModel? poster,
          });
  int get tmdbId => _$args.tmdbId;
  SeerrMediaType get mediaType => _$args.mediaType;
  SeerrDashboardPosterModel? get poster => _$args.poster;

  SeerrDetailsModel build({
    required int tmdbId,
    required SeerrMediaType mediaType,
    SeerrDashboardPosterModel? poster,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SeerrDetailsModel, SeerrDetailsModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SeerrDetailsModel, SeerrDetailsModel>,
              SeerrDetailsModel,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(
        tmdbId: _$args.tmdbId,
        mediaType: _$args.mediaType,
        poster: _$args.poster,
      ),
    );
  }
}
