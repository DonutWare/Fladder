// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_screen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LibraryScreen)
final libraryScreenProvider = LibraryScreenProvider._();

final class LibraryScreenProvider
    extends $NotifierProvider<LibraryScreen, LibraryScreenModel> {
  LibraryScreenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'libraryScreenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$libraryScreenHash();

  @$internal
  @override
  LibraryScreen create() => LibraryScreen();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LibraryScreenModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LibraryScreenModel>(value),
    );
  }
}

String _$libraryScreenHash() => r'b79861a36e973ae839725862d9373a21961225e9';

abstract class _$LibraryScreen extends $Notifier<LibraryScreenModel> {
  LibraryScreenModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LibraryScreenModel, LibraryScreenModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LibraryScreenModel, LibraryScreenModel>,
              LibraryScreenModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
