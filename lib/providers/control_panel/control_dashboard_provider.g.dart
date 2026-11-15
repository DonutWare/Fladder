// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlDashboard)
final controlDashboardProvider = ControlDashboardProvider._();

final class ControlDashboardProvider
    extends $NotifierProvider<ControlDashboard, ControlDashboardModel> {
  ControlDashboardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlDashboardHash();

  @$internal
  @override
  ControlDashboard create() => ControlDashboard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlDashboardModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlDashboardModel>(value),
    );
  }
}

String _$controlDashboardHash() => r'bad52240797234108b94779f5f1f58de48140bce';

abstract class _$ControlDashboard extends $Notifier<ControlDashboardModel> {
  ControlDashboardModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ControlDashboardModel, ControlDashboardModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlDashboardModel, ControlDashboardModel>,
              ControlDashboardModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
