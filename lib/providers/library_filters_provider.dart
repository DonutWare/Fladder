import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/user_provider.dart';

part 'library_filters_provider.g.dart';

@riverpod
class LibraryFilters extends _$LibraryFilters {
  @override
  List<LibraryFiltersModel> build(List<String> ids) => ref.watch(
        userProvider
            .select((value) => (value?.savedFilters ?? []).where((element) => element.containsSameIds(ids)).toList()),
      );

  void removeFilter(LibraryFiltersModel model) => ref.read(userProvider.notifier).removeFilter(model);

  void saveFilter(LibraryFiltersModel model) => ref.read(userProvider.notifier).saveFilter(model);

  void deleteAllFilters() => ref.read(userProvider.notifier).deleteAllFilters();
}
