// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SeerrDashboard)
final seerrDashboardProvider = SeerrDashboardProvider._();

final class SeerrDashboardProvider
    extends $NotifierProvider<SeerrDashboard, SeerrDashboardModel> {
  SeerrDashboardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seerrDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seerrDashboardHash();

  @$internal
  @override
  SeerrDashboard create() => SeerrDashboard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeerrDashboardModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeerrDashboardModel>(value),
    );
  }
}

String _$seerrDashboardHash() => r'e04260df2673014d673f2bf6a715ac638c6bdc4e';

abstract class _$SeerrDashboard extends $Notifier<SeerrDashboardModel> {
  SeerrDashboardModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SeerrDashboardModel, SeerrDashboardModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SeerrDashboardModel, SeerrDashboardModel>,
              SeerrDashboardModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
