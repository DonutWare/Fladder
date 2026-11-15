// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_browser_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DirectoryBrowser)
final directoryBrowserProvider = DirectoryBrowserProvider._();

final class DirectoryBrowserProvider
    extends $NotifierProvider<DirectoryBrowser, DirectoryBrowserModel> {
  DirectoryBrowserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'directoryBrowserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$directoryBrowserHash();

  @$internal
  @override
  DirectoryBrowser create() => DirectoryBrowser();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DirectoryBrowserModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DirectoryBrowserModel>(value),
    );
  }
}

String _$directoryBrowserHash() => r'a57839cc748cdb26daab0525b03ad9351c12abd2';

abstract class _$DirectoryBrowser extends $Notifier<DirectoryBrowserModel> {
  DirectoryBrowserModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DirectoryBrowserModel, DirectoryBrowserModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DirectoryBrowserModel, DirectoryBrowserModel>,
              DirectoryBrowserModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
