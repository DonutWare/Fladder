// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$showSyncButtonProviderHash() =>
    r'c09f42cd6536425bf9417da41c83e15c135d0edb';

/// See also [showSyncButtonProvider].
@ProviderFor(showSyncButtonProvider)
final showSyncButtonProviderProvider = AutoDisposeProvider<bool>.internal(
  showSyncButtonProvider,
  name: r'showSyncButtonProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showSyncButtonProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShowSyncButtonProviderRef = AutoDisposeProviderRef<bool>;
String _$userHash() => r'ca8db1d99bd5298042ce5d301c99c325f7358b3e';

/// See also [User].
@ProviderFor(User)
final userProvider = NotifierProvider<User, AccountModel?>.internal(
  User.new,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$User = Notifier<AccountModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
