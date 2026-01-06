// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_download_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$backgroundDownloaderHash() =>
    r'4dcf61b6439ce1251d42abc80b99e53fe97d7465';

/// See also [BackgroundDownloader].
@ProviderFor(BackgroundDownloader)
final backgroundDownloaderProvider =
    NotifierProvider<BackgroundDownloader, FileDownloader>.internal(
  BackgroundDownloader.new,
  name: r'backgroundDownloaderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$backgroundDownloaderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BackgroundDownloader = Notifier<FileDownloader>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
