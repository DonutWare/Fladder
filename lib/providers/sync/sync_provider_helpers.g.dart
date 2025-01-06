// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_provider_helpers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncChildrenHash() => r'f6fdb1aa36d6655976baa5fbe0d8a6b812d7e95b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SyncChildren
    extends BuildlessAutoDisposeNotifier<List<SyncedItem>> {
  late final SyncedItem arg;

  List<SyncedItem> build(
    SyncedItem arg,
  );
}

/// See also [SyncChildren].
@ProviderFor(SyncChildren)
const syncChildrenProvider = SyncChildrenFamily();

/// See also [SyncChildren].
class SyncChildrenFamily extends Family<List<SyncedItem>> {
  /// See also [SyncChildren].
  const SyncChildrenFamily();

  /// See also [SyncChildren].
  SyncChildrenProvider call(
    SyncedItem arg,
  ) {
    return SyncChildrenProvider(
      arg,
    );
  }

  @override
  SyncChildrenProvider getProviderOverride(
    covariant SyncChildrenProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'syncChildrenProvider';
}

/// See also [SyncChildren].
class SyncChildrenProvider
    extends AutoDisposeNotifierProviderImpl<SyncChildren, List<SyncedItem>> {
  /// See also [SyncChildren].
  SyncChildrenProvider(
    SyncedItem arg,
  ) : this._internal(
          () => SyncChildren()..arg = arg,
          from: syncChildrenProvider,
          name: r'syncChildrenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncChildrenHash,
          dependencies: SyncChildrenFamily._dependencies,
          allTransitiveDependencies:
              SyncChildrenFamily._allTransitiveDependencies,
          arg: arg,
        );

  SyncChildrenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final SyncedItem arg;

  @override
  List<SyncedItem> runNotifierBuild(
    covariant SyncChildren notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(SyncChildren Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncChildrenProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SyncChildren, List<SyncedItem>>
      createElement() {
    return _SyncChildrenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncChildrenProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncChildrenRef on AutoDisposeNotifierProviderRef<List<SyncedItem>> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;
}

class _SyncChildrenProviderElement
    extends AutoDisposeNotifierProviderElement<SyncChildren, List<SyncedItem>>
    with SyncChildrenRef {
  _SyncChildrenProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncChildrenProvider).arg;
}

String _$syncDownloadStatusHash() =>
    r'5a0f8537a977c52e6083bd84265631ea5d160637';

abstract class _$SyncDownloadStatus
    extends BuildlessAutoDisposeNotifier<DownloadStream?> {
  late final SyncedItem arg;

  DownloadStream? build(
    SyncedItem arg,
  );
}

/// See also [SyncDownloadStatus].
@ProviderFor(SyncDownloadStatus)
const syncDownloadStatusProvider = SyncDownloadStatusFamily();

/// See also [SyncDownloadStatus].
class SyncDownloadStatusFamily extends Family<DownloadStream?> {
  /// See also [SyncDownloadStatus].
  const SyncDownloadStatusFamily();

  /// See also [SyncDownloadStatus].
  SyncDownloadStatusProvider call(
    SyncedItem arg,
  ) {
    return SyncDownloadStatusProvider(
      arg,
    );
  }

  @override
  SyncDownloadStatusProvider getProviderOverride(
    covariant SyncDownloadStatusProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'syncDownloadStatusProvider';
}

/// See also [SyncDownloadStatus].
class SyncDownloadStatusProvider extends AutoDisposeNotifierProviderImpl<
    SyncDownloadStatus, DownloadStream?> {
  /// See also [SyncDownloadStatus].
  SyncDownloadStatusProvider(
    SyncedItem arg,
  ) : this._internal(
          () => SyncDownloadStatus()..arg = arg,
          from: syncDownloadStatusProvider,
          name: r'syncDownloadStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncDownloadStatusHash,
          dependencies: SyncDownloadStatusFamily._dependencies,
          allTransitiveDependencies:
              SyncDownloadStatusFamily._allTransitiveDependencies,
          arg: arg,
        );

  SyncDownloadStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final SyncedItem arg;

  @override
  DownloadStream? runNotifierBuild(
    covariant SyncDownloadStatus notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(SyncDownloadStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncDownloadStatusProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SyncDownloadStatus, DownloadStream?>
      createElement() {
    return _SyncDownloadStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncDownloadStatusProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncDownloadStatusRef on AutoDisposeNotifierProviderRef<DownloadStream?> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;
}

class _SyncDownloadStatusProviderElement
    extends AutoDisposeNotifierProviderElement<SyncDownloadStatus,
        DownloadStream?> with SyncDownloadStatusRef {
  _SyncDownloadStatusProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncDownloadStatusProvider).arg;
}

String _$syncStatusesHash() => r'f05ee53368d1de130714bba09132e08aba15bc44';

abstract class _$SyncStatuses
    extends BuildlessAutoDisposeAsyncNotifier<SyncStatus> {
  late final SyncedItem arg;

  FutureOr<SyncStatus> build(
    SyncedItem arg,
  );
}

/// See also [SyncStatuses].
@ProviderFor(SyncStatuses)
const syncStatusesProvider = SyncStatusesFamily();

/// See also [SyncStatuses].
class SyncStatusesFamily extends Family<AsyncValue<SyncStatus>> {
  /// See also [SyncStatuses].
  const SyncStatusesFamily();

  /// See also [SyncStatuses].
  SyncStatusesProvider call(
    SyncedItem arg,
  ) {
    return SyncStatusesProvider(
      arg,
    );
  }

  @override
  SyncStatusesProvider getProviderOverride(
    covariant SyncStatusesProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'syncStatusesProvider';
}

/// See also [SyncStatuses].
class SyncStatusesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SyncStatuses, SyncStatus> {
  /// See also [SyncStatuses].
  SyncStatusesProvider(
    SyncedItem arg,
  ) : this._internal(
          () => SyncStatuses()..arg = arg,
          from: syncStatusesProvider,
          name: r'syncStatusesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncStatusesHash,
          dependencies: SyncStatusesFamily._dependencies,
          allTransitiveDependencies:
              SyncStatusesFamily._allTransitiveDependencies,
          arg: arg,
        );

  SyncStatusesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final SyncedItem arg;

  @override
  FutureOr<SyncStatus> runNotifierBuild(
    covariant SyncStatuses notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(SyncStatuses Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncStatusesProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SyncStatuses, SyncStatus>
      createElement() {
    return _SyncStatusesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncStatusesProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncStatusesRef on AutoDisposeAsyncNotifierProviderRef<SyncStatus> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;
}

class _SyncStatusesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SyncStatuses, SyncStatus>
    with SyncStatusesRef {
  _SyncStatusesProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncStatusesProvider).arg;
}

String _$syncSizeHash() => r'138702f2dd69ab28d142bab67ab4a497bb24f252';

abstract class _$SyncSize extends BuildlessAutoDisposeNotifier<int?> {
  late final SyncedItem arg;

  int? build(
    SyncedItem arg,
  );
}

/// See also [SyncSize].
@ProviderFor(SyncSize)
const syncSizeProvider = SyncSizeFamily();

/// See also [SyncSize].
class SyncSizeFamily extends Family<int?> {
  /// See also [SyncSize].
  const SyncSizeFamily();

  /// See also [SyncSize].
  SyncSizeProvider call(
    SyncedItem arg,
  ) {
    return SyncSizeProvider(
      arg,
    );
  }

  @override
  SyncSizeProvider getProviderOverride(
    covariant SyncSizeProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'syncSizeProvider';
}

/// See also [SyncSize].
class SyncSizeProvider extends AutoDisposeNotifierProviderImpl<SyncSize, int?> {
  /// See also [SyncSize].
  SyncSizeProvider(
    SyncedItem arg,
  ) : this._internal(
          () => SyncSize()..arg = arg,
          from: syncSizeProvider,
          name: r'syncSizeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncSizeHash,
          dependencies: SyncSizeFamily._dependencies,
          allTransitiveDependencies: SyncSizeFamily._allTransitiveDependencies,
          arg: arg,
        );

  SyncSizeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final SyncedItem arg;

  @override
  int? runNotifierBuild(
    covariant SyncSize notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(SyncSize Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncSizeProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SyncSize, int?> createElement() {
    return _SyncSizeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncSizeProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncSizeRef on AutoDisposeNotifierProviderRef<int?> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;
}

class _SyncSizeProviderElement
    extends AutoDisposeNotifierProviderElement<SyncSize, int?>
    with SyncSizeRef {
  _SyncSizeProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncSizeProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
