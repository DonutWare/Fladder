// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlServer)
final controlServerProvider = ControlServerProvider._();

final class ControlServerProvider
    extends $NotifierProvider<ControlServer, ControlServerModel> {
  ControlServerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlServerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlServerHash();

  @$internal
  @override
  ControlServer create() => ControlServer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlServerModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlServerModel>(value),
    );
  }
}

String _$controlServerHash() => r'70ac3e602388e5a6d32be1639deb8f072d7124dc';

abstract class _$ControlServer extends $Notifier<ControlServerModel> {
  ControlServerModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ControlServerModel, ControlServerModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlServerModel, ControlServerModel>,
              ControlServerModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
