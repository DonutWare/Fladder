import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/api_provider.dart';

class BookProviderModel {
  final List<BookModel> chapters;
  final ItemBaseModel? parentModel;
  BookProviderModel({
    this.chapters = const [],
    this.parentModel,
  });

  BookModel? get book => chapters.firstOrNull;

  ImagesData? get cover => parentModel?.getPosters ?? book?.getPosters;

  List<BookModel> get allBooks {
    if (chapters.isEmpty) return [book].nonNulls.toList();
    return chapters;
  }

  bool get collectionPlayed {
    if (chapters.isEmpty) return book?.userData.played ?? false;
    for (var i = 0; i < chapters.length; i++) {
      if (!chapters[i].userData.played) {
        return false;
      }
    }
    return true;
  }

  BookModel? get nextUp {
    if (chapters.isEmpty) return book;
    return chapters.lastWhereOrNull((element) => element.currentPage != 0) ??
        chapters.firstWhereOrNull((element) => !element.userData.played) ??
        chapters.first;
  }

  BookModel? nextChapter(BookModel? currentBook) {
    if (currentBook != null && chapters.isEmpty) return null;

    final currentChapter = chapters.indexOf(currentBook!);

    // Check if the current chapter is the last one
    if (currentChapter == chapters.length - 1) return null;

    // Return the next chapter
    return chapters[currentChapter + 1];
  }

  BookModel? previousChapter(BookModel? currentBook) {
    if (currentBook != null && chapters.isEmpty) return null;

    final currentChapter = chapters.indexOf(currentBook!);

    // Check if the current chapter is the first one
    if (currentChapter == 0) return null;

    // Return the previous chapter
    return chapters[currentChapter - 1];
  }

  BookProviderModel copyWith({
    List<BookModel>? chapters,
    ValueGetter<ItemBaseModel?>? parentModel,
  }) {
    return BookProviderModel(
      chapters: chapters ?? this.chapters,
      parentModel: parentModel != null ? parentModel.call() : this.parentModel,
    );
  }
}

final bookDetailsProvider =
    StateNotifierProvider.autoDispose.family<BookDetailsProviderNotifier, BookProviderModel, String>((ref, id) {
  return BookDetailsProviderNotifier(ref);
});

class BookDetailsProviderNotifier extends StateNotifier<BookProviderModel> {
  BookDetailsProviderNotifier(this.ref) : super(BookProviderModel());

  final Ref ref;

  late Directory savedDirectory;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(BookModel book) async {
    state = state.copyWith(
      parentModel: () => state.book ?? book,
    );
    String bookId = state.book?.id ?? book.id;

    final response = await api.usersUserIdItemsItemIdGet(itemId: bookId);
    final parentResponse = await api.usersUserIdItemsItemIdGet(itemId: response.body?.parentId);

    final parentModel = parentResponse.bodyOrThrow;
    final getViews = await api.usersUserIdViewsGet();

    //Hacky solution for determining parent views
    final parentIsView =
        getViews.body?.items?.firstWhereOrNull((element) => element.name == parentResponse.body?.name) != null;

    Response<ServerQueryResult>? siblingsResponse;
    if (!parentIsView) {
      siblingsResponse = await api.itemsGet(
        parentId: parentModel.id,
        recursive: true,
        sortBy: SortingOptions.name.toSortBy,
        fields: [
          ItemFields.genres,
          ItemFields.parentid,
          ItemFields.tags,
          ItemFields.datecreated,
          ItemFields.datelastmediaadded,
          ItemFields.parentid,
          ItemFields.overview,
          ItemFields.originaltitle,
          ItemFields.primaryimageaspectratio,
        ],
        includeItemTypes: [
          BaseItemKind.book,
        ],
      );
    } else {
      siblingsResponse = null;
    }

    final openedBook = response.bodyOrThrow;

    state = state.copyWith(
      parentModel: !parentIsView ? () => parentResponse.bodyOrThrow : null,
      chapters: (siblingsResponse?.body?.items ?? [openedBook]).whereType<BookModel>().nonNulls.toList(),
    );

    return response;
  }
}
