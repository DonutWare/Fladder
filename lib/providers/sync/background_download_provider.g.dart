// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_download_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BackgroundDownloader)
final backgroundDownloaderProvider = BackgroundDownloaderProvider._();

final class BackgroundDownloaderProvider
    extends $NotifierProvider<BackgroundDownloader, FileDownloader> {
  BackgroundDownloaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundDownloaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundDownloaderHash();

  @$internal
  @override
  BackgroundDownloader create() => BackgroundDownloader();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileDownloader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileDownloader>(value),
    );
  }
}

String _$backgroundDownloaderHash() =>
    r'9b4032e6ee780c64ea44d4ab1f451e5278b6d8f6';

abstract class _$BackgroundDownloader extends $Notifier<FileDownloader> {
  FileDownloader build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FileDownloader, FileDownloader>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FileDownloader, FileDownloader>,
              FileDownloader,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
