// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SeerrUser)
final seerrUserProvider = SeerrUserProvider._();

final class SeerrUserProvider
    extends $NotifierProvider<SeerrUser, SeerrUserModel?> {
  SeerrUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seerrUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seerrUserHash();

  @$internal
  @override
  SeerrUser create() => SeerrUser();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeerrUserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeerrUserModel?>(value),
    );
  }
}

String _$seerrUserHash() => r'64a92f24beadc4c2200dedaa45baab16eceec15e';

abstract class _$SeerrUser extends $Notifier<SeerrUserModel?> {
  SeerrUserModel? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SeerrUserModel?, SeerrUserModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SeerrUserModel?, SeerrUserModel?>,
              SeerrUserModel?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
