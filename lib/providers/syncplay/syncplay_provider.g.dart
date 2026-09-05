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
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$isSyncPlayActiveHash,
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
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayGroupNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncPlayGroupNameRef = AutoDisposeProviderRef<String?>;
String _$syncPlayGroupStateHash() => r'dff5dba3297066e06ff5ed1b9b273ee19bc27878';

/// Provider for SyncPlay group state
///
/// Copied from [syncPlayGroupState].
@ProviderFor(syncPlayGroupState)
final syncPlayGroupStateProvider = AutoDisposeProvider<SyncPlayGroupState>.internal(
  syncPlayGroupState,
  name: r'syncPlayGroupStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayGroupStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncPlayGroupStateRef = AutoDisposeProviderRef<SyncPlayGroupState>;
String _$syncCorrectionStateHash() => r'0c623c5a3e9b99b5dc09c14b50d4cbf120151af9';

/// Provider for SyncPlay correction runtime state (UI + diagnostics).
///
/// Copied from [syncCorrectionState].
@ProviderFor(syncCorrectionState)
final syncCorrectionStateProvider = AutoDisposeProvider<SyncCorrectionState>.internal(
  syncCorrectionState,
  name: r'syncCorrectionStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncCorrectionStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncCorrectionStateRef = AutoDisposeProviderRef<SyncCorrectionState>;
String _$syncCorrectionStrategyHash() => r'eaa4de3db8e9d9155b6f41465462f087833744e0';

/// Provider for active correction strategy.
///
/// Copied from [syncCorrectionStrategy].
@ProviderFor(syncCorrectionStrategy)
final syncCorrectionStrategyProvider = AutoDisposeProvider<SyncCorrectionStrategy>.internal(
  syncCorrectionStrategy,
  name: r'syncCorrectionStrategyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncCorrectionStrategyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncCorrectionStrategyRef = AutoDisposeProviderRef<SyncCorrectionStrategy>;
String _$syncPlayStartPlaybackInProgressHash() => r'883e5426c30e568f8374656112a2de902a98f5dc';

/// True when a SyncPlay-driven `_startPlayback` is currently in flight
/// (initial play, episode switch, rejoin). UI can use this to display
/// a loading indicator while the local player is being prepared.
///
/// Copied from [syncPlayStartPlaybackInProgress].
@ProviderFor(syncPlayStartPlaybackInProgress)
final syncPlayStartPlaybackInProgressProvider = AutoDisposeProvider<bool>.internal(
  syncPlayStartPlaybackInProgress,
  name: r'syncPlayStartPlaybackInProgressProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayStartPlaybackInProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncPlayStartPlaybackInProgressRef = AutoDisposeProviderRef<bool>;
String _$syncPlayHasActivePlaybackHash() => r'007d108b36b600d13f83e6e04f7c47e3123f3a79';

/// True when the group has an active item the local user could
/// resume from outside the player route.
///
/// Copied from [syncPlayHasActivePlayback].
@ProviderFor(syncPlayHasActivePlayback)
final syncPlayHasActivePlaybackProvider = AutoDisposeProvider<bool>.internal(
  syncPlayHasActivePlayback,
  name: r'syncPlayHasActivePlaybackProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayHasActivePlaybackHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncPlayHasActivePlaybackRef = AutoDisposeProviderRef<bool>;
String _$syncPlayHash() => r'ffaacb6512f6389f68d693c76ab1e656a5606928';

/// Provider for SyncPlay controller instance
///
/// Copied from [SyncPlay].
@ProviderFor(SyncPlay)
final syncPlayProvider = NotifierProvider<SyncPlay, SyncPlayState>.internal(
  SyncPlay.new,
  name: r'syncPlayProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncPlay = Notifier<SyncPlayState>;
String _$syncPlayGroupsHash() => r'7f17436df1b0afb4c77cd21128e03b1ed0875939';

/// Provider for the list of SyncPlay groups (load/refresh from sheet).
///
/// Copied from [SyncPlayGroups].
@ProviderFor(SyncPlayGroups)
final syncPlayGroupsProvider = AutoDisposeNotifierProvider<SyncPlayGroups, SyncPlayGroupsState>.internal(
  SyncPlayGroups.new,
  name: r'syncPlayGroupsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$syncPlayGroupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncPlayGroups = AutoDisposeNotifier<SyncPlayGroupsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
