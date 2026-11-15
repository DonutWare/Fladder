// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_provider_helpers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncedItem)
final syncedItemProvider = SyncedItemFamily._();

final class SyncedItemProvider
    extends
        $FunctionalProvider<
          AsyncValue<SyncedItem?>,
          SyncedItem?,
          Stream<SyncedItem?>
        >
    with $FutureModifier<SyncedItem?>, $StreamProvider<SyncedItem?> {
  SyncedItemProvider._({
    required SyncedItemFamily super.from,
    required ItemBaseModel? super.argument,
  }) : super(
         retry: null,
         name: r'syncedItemProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$syncedItemHash();

  @override
  String toString() {
    return r'syncedItemProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<SyncedItem?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<SyncedItem?> create(Ref ref) {
    final argument = this.argument as ItemBaseModel?;
    return syncedItem(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncedItemProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$syncedItemHash() => r'8342c557accf52fd0a8561274ecf9b77b5cf7acd';

final class SyncedItemFamily extends $Family
    with $FunctionalFamilyOverride<Stream<SyncedItem?>, ItemBaseModel?> {
  SyncedItemFamily._()
    : super(
        retry: null,
        name: r'syncedItemProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SyncedItemProvider call(ItemBaseModel? item) =>
      SyncedItemProvider._(argument: item, from: this);

  @override
  String toString() => r'syncedItemProvider';
}

@ProviderFor(SyncedChildren)
final syncedChildrenProvider = SyncedChildrenFamily._();

final class SyncedChildrenProvider
    extends $AsyncNotifierProvider<SyncedChildren, List<SyncedItem>> {
  SyncedChildrenProvider._({
    required SyncedChildrenFamily super.from,
    required SyncedItem super.argument,
  }) : super(
         retry: null,
         name: r'syncedChildrenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$syncedChildrenHash();

  @override
  String toString() {
    return r'syncedChildrenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SyncedChildren create() => SyncedChildren();

  @override
  bool operator ==(Object other) {
    return other is SyncedChildrenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$syncedChildrenHash() => r'13e1df8d7e855f0bc455bd6e367e179e0d1fbf85';

final class SyncedChildrenFamily extends $Family
    with
        $ClassFamilyOverride<
          SyncedChildren,
          AsyncValue<List<SyncedItem>>,
          List<SyncedItem>,
          FutureOr<List<SyncedItem>>,
          SyncedItem
        > {
  SyncedChildrenFamily._()
    : super(
        retry: null,
        name: r'syncedChildrenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SyncedChildrenProvider call(SyncedItem item) =>
      SyncedChildrenProvider._(argument: item, from: this);

  @override
  String toString() => r'syncedChildrenProvider';
}

abstract class _$SyncedChildren extends $AsyncNotifier<List<SyncedItem>> {
  late final _$args = ref.$arg as SyncedItem;
  SyncedItem get item => _$args;

  FutureOr<List<SyncedItem>> build(SyncedItem item);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SyncedItem>>, List<SyncedItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SyncedItem>>, List<SyncedItem>>,
              AsyncValue<List<SyncedItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SyncedNestedChildren)
final syncedNestedChildrenProvider = SyncedNestedChildrenFamily._();

final class SyncedNestedChildrenProvider
    extends $AsyncNotifierProvider<SyncedNestedChildren, List<SyncedItem>> {
  SyncedNestedChildrenProvider._({
    required SyncedNestedChildrenFamily super.from,
    required SyncedItem super.argument,
  }) : super(
         retry: null,
         name: r'syncedNestedChildrenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$syncedNestedChildrenHash();

  @override
  String toString() {
    return r'syncedNestedChildrenProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SyncedNestedChildren create() => SyncedNestedChildren();

  @override
  bool operator ==(Object other) {
    return other is SyncedNestedChildrenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$syncedNestedChildrenHash() =>
    r'ea8dd0e694efa6d6ec0c73d699b5fb3e933f9322';

final class SyncedNestedChildrenFamily extends $Family
    with
        $ClassFamilyOverride<
          SyncedNestedChildren,
          AsyncValue<List<SyncedItem>>,
          List<SyncedItem>,
          FutureOr<List<SyncedItem>>,
          SyncedItem
        > {
  SyncedNestedChildrenFamily._()
    : super(
        retry: null,
        name: r'syncedNestedChildrenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SyncedNestedChildrenProvider call(SyncedItem item) =>
      SyncedNestedChildrenProvider._(argument: item, from: this);

  @override
  String toString() => r'syncedNestedChildrenProvider';
}

abstract class _$SyncedNestedChildren extends $AsyncNotifier<List<SyncedItem>> {
  late final _$args = ref.$arg as SyncedItem;
  SyncedItem get item => _$args;

  FutureOr<List<SyncedItem>> build(SyncedItem item);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SyncedItem>>, List<SyncedItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SyncedItem>>, List<SyncedItem>>,
              AsyncValue<List<SyncedItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SyncDownloadStatus)
final syncDownloadStatusProvider = SyncDownloadStatusFamily._();

final class SyncDownloadStatusProvider
    extends $NotifierProvider<SyncDownloadStatus, DownloadStream?> {
  SyncDownloadStatusProvider._({
    required SyncDownloadStatusFamily super.from,
    required (SyncedItem, List<SyncedItem>) super.argument,
  }) : super(
         retry: null,
         name: r'syncDownloadStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$syncDownloadStatusHash();

  @override
  String toString() {
    return r'syncDownloadStatusProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SyncDownloadStatus create() => SyncDownloadStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadStream? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadStream?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SyncDownloadStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$syncDownloadStatusHash() =>
    r'242a0a6cfe5314d75ab09dca50a88527acb92e9e';

final class SyncDownloadStatusFamily extends $Family
    with
        $ClassFamilyOverride<
          SyncDownloadStatus,
          DownloadStream?,
          DownloadStream?,
          DownloadStream?,
          (SyncedItem, List<SyncedItem>)
        > {
  SyncDownloadStatusFamily._()
    : super(
        retry: null,
        name: r'syncDownloadStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SyncDownloadStatusProvider call(SyncedItem arg, List<SyncedItem> children) =>
      SyncDownloadStatusProvider._(argument: (arg, children), from: this);

  @override
  String toString() => r'syncDownloadStatusProvider';
}

abstract class _$SyncDownloadStatus extends $Notifier<DownloadStream?> {
  late final _$args = ref.$arg as (SyncedItem, List<SyncedItem>);
  SyncedItem get arg => _$args.$1;
  List<SyncedItem> get children => _$args.$2;

  DownloadStream? build(SyncedItem arg, List<SyncedItem> children);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DownloadStream?, DownloadStream?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DownloadStream?, DownloadStream?>,
              DownloadStream?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

@ProviderFor(SyncSize)
final syncSizeProvider = SyncSizeFamily._();

final class SyncSizeProvider extends $NotifierProvider<SyncSize, int?> {
  SyncSizeProvider._({
    required SyncSizeFamily super.from,
    required (SyncedItem, List<SyncedItem>?) super.argument,
  }) : super(
         retry: null,
         name: r'syncSizeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$syncSizeHash();

  @override
  String toString() {
    return r'syncSizeProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SyncSize create() => SyncSize();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SyncSizeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$syncSizeHash() => r'a975c17b0918892ccf9ee36a3635d34d7398512f';

final class SyncSizeFamily extends $Family
    with
        $ClassFamilyOverride<
          SyncSize,
          int?,
          int?,
          int?,
          (SyncedItem, List<SyncedItem>?)
        > {
  SyncSizeFamily._()
    : super(
        retry: null,
        name: r'syncSizeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SyncSizeProvider call(SyncedItem arg, List<SyncedItem>? children) =>
      SyncSizeProvider._(argument: (arg, children), from: this);

  @override
  String toString() => r'syncSizeProvider';
}

abstract class _$SyncSize extends $Notifier<int?> {
  late final _$args = ref.$arg as (SyncedItem, List<SyncedItem>?);
  SyncedItem get arg => _$args.$1;
  List<SyncedItem>? get children => _$args.$2;

  int? build(SyncedItem arg, List<SyncedItem>? children);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
