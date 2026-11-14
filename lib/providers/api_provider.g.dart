// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JellyApi)
final jellyApiProvider = JellyApiProvider._();

final class JellyApiProvider extends $NotifierProvider<JellyApi, JellyService> {
  JellyApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jellyApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jellyApiHash();

  @$internal
  @override
  JellyApi create() => JellyApi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JellyService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JellyService>(value),
    );
  }
}

String _$jellyApiHash() => r'29bdab968791c8f9311cb07aa7a315e746068b6c';

abstract class _$JellyApi extends $Notifier<JellyService> {
  JellyService build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<JellyService, JellyService>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<JellyService, JellyService>,
              JellyService,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
