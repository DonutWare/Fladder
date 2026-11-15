// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Update)
final updateProvider = UpdateProvider._();

final class UpdateProvider extends $NotifierProvider<Update, UpdatesModel> {
  UpdateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateHash();

  @$internal
  @override
  Update create() => Update();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdatesModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdatesModel>(value),
    );
  }
}

String _$updateHash() => r'e22205cb13e6b43df1296de90e39059f09bb80a8';

abstract class _$Update extends $Notifier<UpdatesModel> {
  UpdatesModel build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UpdatesModel, UpdatesModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdatesModel, UpdatesModel>,
              UpdatesModel,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
