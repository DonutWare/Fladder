// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_filters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LibraryFilters)
final libraryFiltersProvider = LibraryFiltersFamily._();

final class LibraryFiltersProvider
    extends $NotifierProvider<LibraryFilters, List<LibraryFiltersModel>> {
  LibraryFiltersProvider._({
    required LibraryFiltersFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'libraryFiltersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$libraryFiltersHash();

  @override
  String toString() {
    return r'libraryFiltersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LibraryFilters create() => LibraryFilters();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LibraryFiltersModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LibraryFiltersModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryFiltersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$libraryFiltersHash() => r'52d05dd1366b82e81f290439adce82c30d1697bf';

final class LibraryFiltersFamily extends $Family
    with
        $ClassFamilyOverride<
          LibraryFilters,
          List<LibraryFiltersModel>,
          List<LibraryFiltersModel>,
          List<LibraryFiltersModel>,
          List<String>
        > {
  LibraryFiltersFamily._()
    : super(
        retry: null,
        name: r'libraryFiltersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LibraryFiltersProvider call(List<String> ids) =>
      LibraryFiltersProvider._(argument: ids, from: this);

  @override
  String toString() => r'libraryFiltersProvider';
}

abstract class _$LibraryFilters extends $Notifier<List<LibraryFiltersModel>> {
  late final _$args = ref.$arg as List<String>;
  List<String> get ids => _$args;

  List<LibraryFiltersModel> build(List<String> ids);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<LibraryFiltersModel>, List<LibraryFiltersModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<LibraryFiltersModel>, List<LibraryFiltersModel>>,
              List<LibraryFiltersModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
