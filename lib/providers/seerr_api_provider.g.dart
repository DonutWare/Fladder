// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SeerrApi)
final seerrApiProvider = SeerrApiProvider._();

final class SeerrApiProvider extends $NotifierProvider<SeerrApi, SeerrService> {
  SeerrApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seerrApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seerrApiHash();

  @$internal
  @override
  SeerrApi create() => SeerrApi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeerrService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeerrService>(value),
    );
  }
}

String _$seerrApiHash() => r'fd7920b24b63244d788595ba8eef0eda0b40f6d6';

abstract class _$SeerrApi extends $Notifier<SeerrService> {
  SeerrService build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SeerrService, SeerrService>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SeerrService, SeerrService>,
              SeerrService,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
