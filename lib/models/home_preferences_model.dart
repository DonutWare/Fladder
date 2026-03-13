import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_preferences_model.freezed.dart';

typedef MediaFolder = ({String id, String name});

@Freezed(copyWith: true)
abstract class HomePreferencesModel with _$HomePreferencesModel {
  const HomePreferencesModel._();

  const factory HomePreferencesModel({
    @Default([]) List<String> orderedLibraryIds,
    @Default([]) List<String> latestItemsExcludes,
    @Default(false) bool hidePlayedInLatest,
    @Default([]) List<String> groupedFolders,
    @Default([]) List<MediaFolder> availableFolders,
    @Default(false) bool loading,
  }) = _HomePreferencesModel;
}
