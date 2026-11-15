// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_users_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlUsers)
final controlUsersProvider = ControlUsersProvider._();

final class ControlUsersProvider
    extends $NotifierProvider<ControlUsers, ControlUsersModel> {
  ControlUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlUsersHash();

  @$internal
  @override
  ControlUsers create() => ControlUsers();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlUsersModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlUsersModel>(value),
    );
  }
}

String _$controlUsersHash() => r'a10a1740c29b00797b0e649f72115d8f9f8187e8';

abstract class _$ControlUsers extends $Notifier<ControlUsersModel> {
  ControlUsersModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ControlUsersModel, ControlUsersModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlUsersModel, ControlUsersModel>,
              ControlUsersModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
