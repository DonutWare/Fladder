// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(showSyncButtonProvider)
final showSyncButtonProviderProvider = ShowSyncButtonProviderProvider._();

final class ShowSyncButtonProviderProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  ShowSyncButtonProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showSyncButtonProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showSyncButtonProviderHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return showSyncButtonProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showSyncButtonProviderHash() =>
    r'c09f42cd6536425bf9417da41c83e15c135d0edb';

@ProviderFor(User)
final userProvider = UserProvider._();

final class UserProvider extends $NotifierProvider<User, AccountModel?> {
  UserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userHash();

  @$internal
  @override
  User create() => User();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountModel?>(value),
    );
  }
}

String _$userHash() => r'8ef65abc833499e4a49b2e82e8686683f8077705';

abstract class _$User extends $Notifier<AccountModel?> {
  AccountModel? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AccountModel?, AccountModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AccountModel?, AccountModel?>,
              AccountModel?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
