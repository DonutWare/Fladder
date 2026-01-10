// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syncplay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isSyncPlayActiveHash() => r'bf9cda97aa9130fed8fc6558481c02f10f815f99';

/// Provider to check if currently in a SyncPlay session
///
/// Copied from [isSyncPlayActive].
@ProviderFor(isSyncPlayActive)
final isSyncPlayActiveProvider = AutoDisposeProvider<bool>.internal(
  isSyncPlayActive,
  name: r'isSyncPlayActiveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSyncPlayActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsSyncPlayActiveRef = AutoDisposeProviderRef<bool>;
String _$syncPlayGroupNameHash() => r'f73f243808920efbfbfa467d1ba1234fec622283';

/// Provider for current SyncPlay group name
///
/// Copied from [syncPlayGroupName].
@ProviderFor(syncPlayGroupName)
final syncPlayGroupNameProvider = AutoDisposeProvider<String?>.internal(
  syncPlayGroupName,
  name: r'syncPlayGroupNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncPlayGroupNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncPlayGroupNameRef = AutoDisposeProviderRef<String?>;
String _$syncPlayGroupStateHash() =>
    r'dff5dba3297066e06ff5ed1b9b273ee19bc27878';

/// Provider for SyncPlay group state
///
/// Copied from [syncPlayGroupState].
@ProviderFor(syncPlayGroupState)
final syncPlayGroupStateProvider =
    AutoDisposeProvider<SyncPlayGroupState>.internal(
  syncPlayGroupState,
  name: r'syncPlayGroupStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncPlayGroupStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncPlayGroupStateRef = AutoDisposeProviderRef<SyncPlayGroupState>;
String _$syncPlayHash() => r'7f5fd80fef94a1c6c36050b3895b51a764116d50';

/// Provider for SyncPlay controller instance
///
/// Copied from [SyncPlay].
@ProviderFor(SyncPlay)
final syncPlayProvider = NotifierProvider<SyncPlay, SyncPlayState>.internal(
  SyncPlay.new,
  name: r'syncPlayProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncPlay = Notifier<SyncPlayState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
