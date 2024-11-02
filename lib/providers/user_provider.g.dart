// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$showSyncButtonProviderHash() =>
    r'3468d7309f3859f7b60b1bd317e306e1f5f00555';

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

typedef ShowSyncButtonProviderRef = AutoDisposeProviderRef<bool>;
String _$userHash() => r'418b3d4ade830479db9f48c7793ac5b646778b82';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
