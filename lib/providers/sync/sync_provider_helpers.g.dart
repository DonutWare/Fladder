// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_provider_helpers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncChildrenHash() => r'c5a90d630d49f59ad4fbaacb5154f1205799f5ab';

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
  late final SyncedItem root;

  List<SyncedItem> build(
    SyncedItem root,
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
    SyncedItem root,
  ) {
    return SyncChildrenProvider(
      root,
    );
  }

  @override
  SyncChildrenProvider getProviderOverride(
    covariant SyncChildrenProvider provider,
  ) {
    return call(
      provider.root,
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
    SyncedItem root,
  ) : this._internal(
          () => SyncChildren()..root = root,
          from: syncChildrenProvider,
          name: r'syncChildrenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncChildrenHash,
          dependencies: SyncChildrenFamily._dependencies,
          allTransitiveDependencies:
              SyncChildrenFamily._allTransitiveDependencies,
          root: root,
        );

  SyncChildrenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.root,
  }) : super.internal();

  final SyncedItem root;

  @override
  List<SyncedItem> runNotifierBuild(
    covariant SyncChildren notifier,
  ) {
    return notifier.build(
      root,
    );
  }

  @override
  Override overrideWith(SyncChildren Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncChildrenProvider._internal(
        () => create()..root = root,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        root: root,
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
    return other is SyncChildrenProvider && other.root == root;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, root.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncChildrenRef on AutoDisposeNotifierProviderRef<List<SyncedItem>> {
  /// The parameter `root` of this provider.
  SyncedItem get root;
}

class _SyncChildrenProviderElement
    extends AutoDisposeNotifierProviderElement<SyncChildren, List<SyncedItem>>
    with SyncChildrenRef {
  _SyncChildrenProviderElement(super.provider);

  @override
  SyncedItem get root => (origin as SyncChildrenProvider).root;
}

String _$syncDownloadStatusHash() =>
    r'1036352200e1138b4ef70e524c0baf13bb9cd452';

abstract class _$SyncDownloadStatus
    extends BuildlessAutoDisposeNotifier<DownloadStream?> {
  late final SyncedItem arg;
  late final List<SyncedItem> children;

  DownloadStream? build(
    SyncedItem arg,
    List<SyncedItem> children,
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
    List<SyncedItem> children,
  ) {
    return SyncDownloadStatusProvider(
      arg,
      children,
    );
  }

  @override
  SyncDownloadStatusProvider getProviderOverride(
    covariant SyncDownloadStatusProvider provider,
  ) {
    return call(
      provider.arg,
      provider.children,
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
    List<SyncedItem> children,
  ) : this._internal(
          () => SyncDownloadStatus()
            ..arg = arg
            ..children = children,
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
          children: children,
        );

  SyncDownloadStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
    required this.children,
  }) : super.internal();

  final SyncedItem arg;
  final List<SyncedItem> children;

  @override
  DownloadStream? runNotifierBuild(
    covariant SyncDownloadStatus notifier,
  ) {
    return notifier.build(
      arg,
      children,
    );
  }

  @override
  Override overrideWith(SyncDownloadStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncDownloadStatusProvider._internal(
        () => create()
          ..arg = arg
          ..children = children,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
        children: children,
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
    return other is SyncDownloadStatusProvider &&
        other.arg == arg &&
        other.children == children;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);
    hash = _SystemHash.combine(hash, children.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncDownloadStatusRef on AutoDisposeNotifierProviderRef<DownloadStream?> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;

  /// The parameter `children` of this provider.
  List<SyncedItem> get children;
}

class _SyncDownloadStatusProviderElement
    extends AutoDisposeNotifierProviderElement<SyncDownloadStatus,
        DownloadStream?> with SyncDownloadStatusRef {
  _SyncDownloadStatusProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncDownloadStatusProvider).arg;
  @override
  List<SyncedItem> get children =>
      (origin as SyncDownloadStatusProvider).children;
}

String _$syncStatusesHash() => r'64a3499fc7b7bbdbd6594b1eec76cf42a119a041';

abstract class _$SyncStatuses
    extends BuildlessAutoDisposeAsyncNotifier<SyncStatus> {
  late final SyncedItem arg;
  late final List<SyncedItem>? children;

  FutureOr<SyncStatus> build(
    SyncedItem arg,
    List<SyncedItem>? children,
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
    List<SyncedItem>? children,
  ) {
    return SyncStatusesProvider(
      arg,
      children,
    );
  }

  @override
  SyncStatusesProvider getProviderOverride(
    covariant SyncStatusesProvider provider,
  ) {
    return call(
      provider.arg,
      provider.children,
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
    List<SyncedItem>? children,
  ) : this._internal(
          () => SyncStatuses()
            ..arg = arg
            ..children = children,
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
          children: children,
        );

  SyncStatusesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
    required this.children,
  }) : super.internal();

  final SyncedItem arg;
  final List<SyncedItem>? children;

  @override
  FutureOr<SyncStatus> runNotifierBuild(
    covariant SyncStatuses notifier,
  ) {
    return notifier.build(
      arg,
      children,
    );
  }

  @override
  Override overrideWith(SyncStatuses Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncStatusesProvider._internal(
        () => create()
          ..arg = arg
          ..children = children,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
        children: children,
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
    return other is SyncStatusesProvider &&
        other.arg == arg &&
        other.children == children;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);
    hash = _SystemHash.combine(hash, children.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncStatusesRef on AutoDisposeAsyncNotifierProviderRef<SyncStatus> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;

  /// The parameter `children` of this provider.
  List<SyncedItem>? get children;
}

class _SyncStatusesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SyncStatuses, SyncStatus>
    with SyncStatusesRef {
  _SyncStatusesProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncStatusesProvider).arg;
  @override
  List<SyncedItem>? get children => (origin as SyncStatusesProvider).children;
}

String _$syncSizeHash() => r'81797ecc4a6f600691b6f1fe0c16bae0228ec920';

abstract class _$SyncSize extends BuildlessAutoDisposeNotifier<int?> {
  late final SyncedItem arg;
  late final List<SyncedItem>? children;

  int? build(
    SyncedItem arg,
    List<SyncedItem>? children,
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
    List<SyncedItem>? children,
  ) {
    return SyncSizeProvider(
      arg,
      children,
    );
  }

  @override
  SyncSizeProvider getProviderOverride(
    covariant SyncSizeProvider provider,
  ) {
    return call(
      provider.arg,
      provider.children,
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
    List<SyncedItem>? children,
  ) : this._internal(
          () => SyncSize()
            ..arg = arg
            ..children = children,
          from: syncSizeProvider,
          name: r'syncSizeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncSizeHash,
          dependencies: SyncSizeFamily._dependencies,
          allTransitiveDependencies: SyncSizeFamily._allTransitiveDependencies,
          arg: arg,
          children: children,
        );

  SyncSizeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
    required this.children,
  }) : super.internal();

  final SyncedItem arg;
  final List<SyncedItem>? children;

  @override
  int? runNotifierBuild(
    covariant SyncSize notifier,
  ) {
    return notifier.build(
      arg,
      children,
    );
  }

  @override
  Override overrideWith(SyncSize Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncSizeProvider._internal(
        () => create()
          ..arg = arg
          ..children = children,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
        children: children,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SyncSize, int?> createElement() {
    return _SyncSizeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncSizeProvider &&
        other.arg == arg &&
        other.children == children;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);
    hash = _SystemHash.combine(hash, children.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncSizeRef on AutoDisposeNotifierProviderRef<int?> {
  /// The parameter `arg` of this provider.
  SyncedItem get arg;

  /// The parameter `children` of this provider.
  List<SyncedItem>? get children;
}

class _SyncSizeProviderElement
    extends AutoDisposeNotifierProviderElement<SyncSize, int?>
    with SyncSizeRef {
  _SyncSizeProviderElement(super.provider);

  @override
  SyncedItem get arg => (origin as SyncSizeProvider).arg;
  @override
  List<SyncedItem>? get children => (origin as SyncSizeProvider).children;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
