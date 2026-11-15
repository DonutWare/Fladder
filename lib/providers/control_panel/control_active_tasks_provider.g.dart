// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_active_tasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlActiveTasks)
final controlActiveTasksProvider = ControlActiveTasksProvider._();

final class ControlActiveTasksProvider
    extends $NotifierProvider<ControlActiveTasks, List<TaskInfo>> {
  ControlActiveTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlActiveTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlActiveTasksHash();

  @$internal
  @override
  ControlActiveTasks create() => ControlActiveTasks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TaskInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TaskInfo>>(value),
    );
  }
}

String _$controlActiveTasksHash() =>
    r'9142b16528ff76402e2a957ad48a08420f7dbd7c';

abstract class _$ControlActiveTasks extends $Notifier<List<TaskInfo>> {
  List<TaskInfo> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<TaskInfo>, List<TaskInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TaskInfo>, List<TaskInfo>>,
              List<TaskInfo>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
