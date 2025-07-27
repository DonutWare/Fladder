// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_provider_helpers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncedItemHash() => r'7b1178ba78529ebf65425aa4cb8b239a28c7914b';

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

/// See also [syncedItem].
@ProviderFor(syncedItem)
const syncedItemProvider = SyncedItemFamily();

/// See also [syncedItem].
class SyncedItemFamily extends Family<AsyncValue<SyncedItem?>> {
  /// See also [syncedItem].
  const SyncedItemFamily();

  /// See also [syncedItem].
  SyncedItemProvider call(
    ItemBaseModel? item,
  ) {
    return SyncedItemProvider(
      item,
    );
  }

  @override
  SyncedItemProvider getProviderOverride(
    covariant SyncedItemProvider provider,
  ) {
    return call(
      provider.item,
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
  String? get name => r'syncedItemProvider';
}

/// See also [syncedItem].
class SyncedItemProvider extends AutoDisposeStreamProvider<SyncedItem?> {
  /// See also [syncedItem].
  SyncedItemProvider(
    ItemBaseModel? item,
  ) : this._internal(
          (ref) => syncedItem(
            ref as SyncedItemRef,
            item,
          ),
          from: syncedItemProvider,
          name: r'syncedItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncedItemHash,
          dependencies: SyncedItemFamily._dependencies,
          allTransitiveDependencies:
              SyncedItemFamily._allTransitiveDependencies,
          item: item,
        );

  SyncedItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final ItemBaseModel? item;

  @override
  Override overrideWith(
    Stream<SyncedItem?> Function(SyncedItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SyncedItemProvider._internal(
        (ref) => create(ref as SyncedItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SyncedItem?> createElement() {
    return _SyncedItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncedItemProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncedItemRef on AutoDisposeStreamProviderRef<SyncedItem?> {
  /// The parameter `item` of this provider.
  ItemBaseModel? get item;
}

class _SyncedItemProviderElement
    extends AutoDisposeStreamProviderElement<SyncedItem?> with SyncedItemRef {
  _SyncedItemProviderElement(super.provider);

  @override
  ItemBaseModel? get item => (origin as SyncedItemProvider).item;
}

String _$syncedChildrenHash() => r'2b6ce1611750785060df6317ce0ea25e2dc0aeb4';

abstract class _$SyncedChildren
    extends BuildlessAutoDisposeAsyncNotifier<List<SyncedItem>> {
  late final SyncedItem item;

  FutureOr<List<SyncedItem>> build(
    SyncedItem item,
  );
}

/// See also [SyncedChildren].
@ProviderFor(SyncedChildren)
const syncedChildrenProvider = SyncedChildrenFamily();

/// See also [SyncedChildren].
class SyncedChildrenFamily extends Family<AsyncValue<List<SyncedItem>>> {
  /// See also [SyncedChildren].
  const SyncedChildrenFamily();

  /// See also [SyncedChildren].
  SyncedChildrenProvider call(
    SyncedItem item,
  ) {
    return SyncedChildrenProvider(
      item,
    );
  }

  @override
  SyncedChildrenProvider getProviderOverride(
    covariant SyncedChildrenProvider provider,
  ) {
    return call(
      provider.item,
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
  String? get name => r'syncedChildrenProvider';
}

/// See also [SyncedChildren].
class SyncedChildrenProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SyncedChildren, List<SyncedItem>> {
  /// See also [SyncedChildren].
  SyncedChildrenProvider(
    SyncedItem item,
  ) : this._internal(
          () => SyncedChildren()..item = item,
          from: syncedChildrenProvider,
          name: r'syncedChildrenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncedChildrenHash,
          dependencies: SyncedChildrenFamily._dependencies,
          allTransitiveDependencies:
              SyncedChildrenFamily._allTransitiveDependencies,
          item: item,
        );

  SyncedChildrenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final SyncedItem item;

  @override
  FutureOr<List<SyncedItem>> runNotifierBuild(
    covariant SyncedChildren notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(SyncedChildren Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncedChildrenProvider._internal(
        () => create()..item = item,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SyncedChildren, List<SyncedItem>>
      createElement() {
    return _SyncedChildrenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncedChildrenProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncedChildrenRef
    on AutoDisposeAsyncNotifierProviderRef<List<SyncedItem>> {
  /// The parameter `item` of this provider.
  SyncedItem get item;
}

class _SyncedChildrenProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SyncedChildren,
        List<SyncedItem>> with SyncedChildrenRef {
  _SyncedChildrenProviderElement(super.provider);

  @override
  SyncedItem get item => (origin as SyncedChildrenProvider).item;
}

String _$syncedNestedChildrenHash() =>
    r'ea8dd0e694efa6d6ec0c73d699b5fb3e933f9322';

abstract class _$SyncedNestedChildren
    extends BuildlessAutoDisposeAsyncNotifier<List<SyncedItem>> {
  late final SyncedItem item;

  FutureOr<List<SyncedItem>> build(
    SyncedItem item,
  );
}

/// See also [SyncedNestedChildren].
@ProviderFor(SyncedNestedChildren)
const syncedNestedChildrenProvider = SyncedNestedChildrenFamily();

/// See also [SyncedNestedChildren].
class SyncedNestedChildrenFamily extends Family<AsyncValue<List<SyncedItem>>> {
  /// See also [SyncedNestedChildren].
  const SyncedNestedChildrenFamily();

  /// See also [SyncedNestedChildren].
  SyncedNestedChildrenProvider call(
    SyncedItem item,
  ) {
    return SyncedNestedChildrenProvider(
      item,
    );
  }

  @override
  SyncedNestedChildrenProvider getProviderOverride(
    covariant SyncedNestedChildrenProvider provider,
  ) {
    return call(
      provider.item,
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
  String? get name => r'syncedNestedChildrenProvider';
}

/// See also [SyncedNestedChildren].
class SyncedNestedChildrenProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SyncedNestedChildren, List<SyncedItem>> {
  /// See also [SyncedNestedChildren].
  SyncedNestedChildrenProvider(
    SyncedItem item,
  ) : this._internal(
          () => SyncedNestedChildren()..item = item,
          from: syncedNestedChildrenProvider,
          name: r'syncedNestedChildrenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncedNestedChildrenHash,
          dependencies: SyncedNestedChildrenFamily._dependencies,
          allTransitiveDependencies:
              SyncedNestedChildrenFamily._allTransitiveDependencies,
          item: item,
        );

  SyncedNestedChildrenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final SyncedItem item;

  @override
  FutureOr<List<SyncedItem>> runNotifierBuild(
    covariant SyncedNestedChildren notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(SyncedNestedChildren Function() create) {
    return ProviderOverride(
      origin: this,
      override: SyncedNestedChildrenProvider._internal(
        () => create()..item = item,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SyncedNestedChildren,
      List<SyncedItem>> createElement() {
    return _SyncedNestedChildrenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncedNestedChildrenProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SyncedNestedChildrenRef
    on AutoDisposeAsyncNotifierProviderRef<List<SyncedItem>> {
  /// The parameter `item` of this provider.
  SyncedItem get item;
}

class _SyncedNestedChildrenProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SyncedNestedChildren,
        List<SyncedItem>> with SyncedNestedChildrenRef {
  _SyncedNestedChildrenProviderElement(super.provider);

  @override
  SyncedItem get item => (origin as SyncedNestedChildrenProvider).item;
}

String _$syncDownloadStatusHash() =>
    r'6ee039e094f1e007ebaeb20ae63430be829cdeb7';

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

String _$syncSizeHash() => r'eeb6ab8dc1fdf5696c06e53f04a0e54ad68c6748';

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
