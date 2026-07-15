import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:xid/xid.dart';

import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/string_extensions.dart';

part 'library_filters_model.freezed.dart';
part 'library_filters_model.g.dart';

@Freezed(copyWith: true)
abstract class LibraryFiltersModel with _$LibraryFiltersModel {
  const LibraryFiltersModel._();

  factory LibraryFiltersModel({
    required String id,
    required String name,
    required bool isFavourite,
    @Default(false) bool showInSideBar,
    @Default([]) List<String> ids,
    @Default([]) List<String> viewNames,
    @Default(LibraryFilterModel()) LibraryFilterModel filter,
  }) = _LibraryFiltersModel;

  factory LibraryFiltersModel.fromJson(Map<String, dynamic> json) => _$LibraryFiltersModelFromJson(json);

  factory LibraryFiltersModel.fromLibrarySearch(
    String name,
    LibrarySearchModel searchModel, {
    bool? isFavourite,
    String? id,
    bool showInSideBar = false,
  }) {
    return LibraryFiltersModel(
      id: id ?? Xid().toString(),
      name: name,
      isFavourite: isFavourite ?? false,
      ids: searchModel.currentIds,
      filter: searchModel.filters,
      showInSideBar: showInSideBar,
    );
  }

  bool containsSameIds(List<String> otherIds) => ids.length == otherIds.length && Set.from(ids).containsAll(otherIds);

  Key get navKey => Key("filter-$id");

  static String get folderKey => "folder";

  Future<void> navigateTo(BuildContext context, {bool isFolder = false}) async {
    context.pushRoute(
      LibrarySearchRoute(
        viewModelId: "${ids.join(",")},$navKey${isFolder ? ",$folderKey" : ""}",
        key: navKey,
      ).withFilter(
        filter,
      ),
    );
  }

  IconData get icon => IconsaxPlusLinear.document_filter;
  IconData get selectedIcon => IconsaxPlusBold.document_filter;

  Widget? createIcon(
    BuildContext context, {
    required bool usePostersForLibrary,
    required bool expandedSideBar,
    required bool selected,
    required List<ViewModel> views,
  }) {
    final filteredViews = views.where((view) => ids.contains(view.id)).toList();
    final nameColor = name.toColor;
    return usePostersForLibrary
        ? Container(
            decoration: BoxDecoration(
              borderRadius: FladderTheme.smallShape.borderRadius,
            ),
            clipBehavior: Clip.hardEdge,
            child: SizedBox.square(
              dimension: 45,
              child: Stack(
                children: [
                  Container(
                    color: nameColor,
                    child: Center(child: Text(name.getInitials())),
                  ),
                  filteredViews.length == 1
                      ? filteredViews.first.createIcon(
                          context,
                          selected: false,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: filteredViews
                                    .take(2)
                                    .map((view) =>
                                        Expanded(child: view.createIcon(context, selected: false, rounded: false)))
                                    .toList(),
                              ),
                            ),
                            if (filteredViews.length > 2)
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: filteredViews
                                      .skip(2)
                                      .take(2)
                                      .map((view) =>
                                          Expanded(child: view.createIcon(context, selected: false, rounded: false)))
                                      .toList(),
                                ),
                              )
                          ],
                        )
                ],
              ),
            ),
          )
        : null;
  }
}
