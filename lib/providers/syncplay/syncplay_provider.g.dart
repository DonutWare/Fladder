// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syncplay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncPlay)
final syncPlayProvider = SyncPlayProvider._();

final class SyncPlayProvider
    extends $NotifierProvider<SyncPlay, SyncPlayState> {
  SyncPlayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncPlayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncPlayHash();

  @$internal
  @override
  SyncPlay create() => SyncPlay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncPlayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncPlayState>(value),
    );
  }
}

String _$syncPlayHash() => r'ffaacb6512f6389f68d693c76ab1e656a5606928';

abstract class _$SyncPlay extends $Notifier<SyncPlayState> {
  SyncPlayState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SyncPlayState, SyncPlayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncPlayState, SyncPlayState>,
              SyncPlayState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(isSyncPlayActive)
final isSyncPlayActiveProvider = IsSyncPlayActiveProvider._();

final class IsSyncPlayActiveProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsSyncPlayActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSyncPlayActiveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSyncPlayActiveHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSyncPlayActive(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSyncPlayActiveHash() => r'bf9cda97aa9130fed8fc6558481c02f10f815f99';

@ProviderFor(syncPlayGroupName)
final syncPlayGroupNameProvider = SyncPlayGroupNameProvider._();

final class SyncPlayGroupNameProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  SyncPlayGroupNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncPlayGroupNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncPlayGroupNameHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return syncPlayGroupName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$syncPlayGroupNameHash() => r'f73f243808920efbfbfa467d1ba1234fec622283';

@ProviderFor(syncPlayGroupState)
final syncPlayGroupStateProvider = SyncPlayGroupStateProvider._();

final class SyncPlayGroupStateProvider
    extends
        $FunctionalProvider<
          SyncPlayGroupState,
          SyncPlayGroupState,
          SyncPlayGroupState
        >
    with $Provider<SyncPlayGroupState> {
  SyncPlayGroupStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncPlayGroupStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncPlayGroupStateHash();

  @$internal
  @override
  $ProviderElement<SyncPlayGroupState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncPlayGroupState create(Ref ref) {
    return syncPlayGroupState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncPlayGroupState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncPlayGroupState>(value),
    );
  }
}

String _$syncPlayGroupStateHash() =>
    r'dff5dba3297066e06ff5ed1b9b273ee19bc27878';

@ProviderFor(syncCorrectionState)
final syncCorrectionStateProvider = SyncCorrectionStateProvider._();

final class SyncCorrectionStateProvider
    extends
        $FunctionalProvider<
          SyncCorrectionState,
          SyncCorrectionState,
          SyncCorrectionState
        >
    with $Provider<SyncCorrectionState> {
  SyncCorrectionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncCorrectionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncCorrectionStateHash();

  @$internal
  @override
  $ProviderElement<SyncCorrectionState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncCorrectionState create(Ref ref) {
    return syncCorrectionState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncCorrectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncCorrectionState>(value),
    );
  }
}

String _$syncCorrectionStateHash() =>
    r'0c623c5a3e9b99b5dc09c14b50d4cbf120151af9';

@ProviderFor(syncCorrectionStrategy)
final syncCorrectionStrategyProvider = SyncCorrectionStrategyProvider._();

final class SyncCorrectionStrategyProvider
    extends
        $FunctionalProvider<
          SyncCorrectionStrategy,
          SyncCorrectionStrategy,
          SyncCorrectionStrategy
        >
    with $Provider<SyncCorrectionStrategy> {
  SyncCorrectionStrategyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncCorrectionStrategyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncCorrectionStrategyHash();

  @$internal
  @override
  $ProviderElement<SyncCorrectionStrategy> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncCorrectionStrategy create(Ref ref) {
    return syncCorrectionStrategy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncCorrectionStrategy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncCorrectionStrategy>(value),
    );
  }
}

String _$syncCorrectionStrategyHash() =>
    r'eaa4de3db8e9d9155b6f41465462f087833744e0';

/// True while a SyncPlay-driven `_startPlayback` is in flight (initial play, episode switch, rejoin).

@ProviderFor(syncPlayStartPlaybackInProgress)
final syncPlayStartPlaybackInProgressProvider =
    SyncPlayStartPlaybackInProgressProvider._();

/// True while a SyncPlay-driven `_startPlayback` is in flight (initial play, episode switch, rejoin).

final class SyncPlayStartPlaybackInProgressProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True while a SyncPlay-driven `_startPlayback` is in flight (initial play, episode switch, rejoin).
  SyncPlayStartPlaybackInProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncPlayStartPlaybackInProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncPlayStartPlaybackInProgressHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return syncPlayStartPlaybackInProgress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$syncPlayStartPlaybackInProgressHash() =>
    r'883e5426c30e568f8374656112a2de902a98f5dc';

/// True when the group has an active item the local user could resume from outside the player route.

@ProviderFor(syncPlayHasActivePlayback)
final syncPlayHasActivePlaybackProvider = SyncPlayHasActivePlaybackProvider._();

/// True when the group has an active item the local user could resume from outside the player route.

final class SyncPlayHasActivePlaybackProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True when the group has an active item the local user could resume from outside the player route.
  SyncPlayHasActivePlaybackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncPlayHasActivePlaybackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncPlayHasActivePlaybackHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return syncPlayHasActivePlayback(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$syncPlayHasActivePlaybackHash() =>
    r'007d108b36b600d13f83e6e04f7c47e3123f3a79';

@ProviderFor(SyncPlayGroups)
final syncPlayGroupsProvider = SyncPlayGroupsProvider._();

final class SyncPlayGroupsProvider
    extends $NotifierProvider<SyncPlayGroups, SyncPlayGroupsState> {
  SyncPlayGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncPlayGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncPlayGroupsHash();

  @$internal
  @override
  SyncPlayGroups create() => SyncPlayGroups();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncPlayGroupsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncPlayGroupsState>(value),
    );
  }
}

String _$syncPlayGroupsHash() => r'7f17436df1b0afb4c77cd21128e03b1ed0875939';

abstract class _$SyncPlayGroups extends $Notifier<SyncPlayGroupsState> {
  SyncPlayGroupsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SyncPlayGroupsState, SyncPlayGroupsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncPlayGroupsState, SyncPlayGroupsState>,
              SyncPlayGroupsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
