import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/collection_types.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/recommended_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/util/localization_helper.dart';

part 'library_screen_provider.freezed.dart';
part 'library_screen_provider.g.dart';

enum LibraryViewType {
  recommended,
  favourites,
  genres;

  const LibraryViewType();

  String label(BuildContext context) => switch (this) {
        LibraryViewType.recommended => context.localized.recommended,
        LibraryViewType.favourites => context.localized.favorites,
        LibraryViewType.genres => context.localized.genre(2),
      };

  IconData get icon => switch (this) {
        LibraryViewType.recommended => IconsaxPlusLinear.star,
        LibraryViewType.favourites => IconsaxPlusLinear.heart,
        LibraryViewType.genres => IconsaxPlusLinear.hierarchy_3,
      };

  IconData get iconSelected => switch (this) {
        LibraryViewType.recommended => IconsaxPlusBold.star,
        LibraryViewType.favourites => IconsaxPlusBold.heart,
        LibraryViewType.genres => IconsaxPlusBold.hierarchy_3,
      };
}

@Freezed(fromJson: false, toJson: false, copyWith: true)
abstract class LibraryScreenModel with _$LibraryScreenModel {
  factory LibraryScreenModel({
    @Default([]) List<ViewModel> views,
    ViewModel? selectedViewModel,
    @Default({LibraryViewType.recommended, LibraryViewType.favourites}) Set<LibraryViewType> viewType,
    @Default([]) List<RecommendedModel> recommendations,
    @Default([]) List<RecommendedModel> genres,
    @Default([]) List<ItemBaseModel> favourites,
  }) = _LibraryScreenModel;
}

@Riverpod(keepAlive: true)
class LibraryScreen extends _$LibraryScreen {
  late final JellyService api = ref.read(jellyApiProvider);

  @override
  LibraryScreenModel build() => LibraryScreenModel();

  Future<void> fetchAllLibraries() async {
    final views = await ref.read(viewsProvider.notifier).fetchViews();
    state = state.copyWith(
        views: views?.views.where((element) => element.collectionType != CollectionType.folders).toList() ?? []);
    if (state.views.isEmpty) return;
    final viewModel = state.selectedViewModel ?? state.views.firstOrNull;
    if (viewModel == null) return;
    selectLibrary(viewModel);
    await loadLibrary(viewModel);
  }

  Future<void> selectLibrary(ViewModel viewModel) async {
    state = state.copyWith(selectedViewModel: viewModel);
  }

  Future<void> setViewType(Set<LibraryViewType> type) async {
    state = state.copyWith(viewType: type);
  }

  Future<Response?> loadLibrary(ViewModel viewModel) async {
    if (state.viewType.contains(LibraryViewType.recommended)) {
      await loadRecommendations(viewModel);
    }
    if (state.viewType.contains(LibraryViewType.favourites)) {
      await loadFavourites(viewModel);
    }
    if (state.viewType.contains(LibraryViewType.genres)) {
      await loadGenres(viewModel);
    }
    return null;
  }

  Future<void> loadResume(ViewModel viewModel) async {}

  Future<void> loadRecommendations(ViewModel viewModel) async {
    List<RecommendedModel> newRecommendations = [];

    final resume = await api.usersUserIdItemsResumeGet(
      parentId: viewModel.id,
      limit: 9,
      enableUserData: true,
      enableImageTypes: [
        ImageType.primary,
        ImageType.banner,
        ImageType.screenshot,
      ],
      mediaTypes: [MediaType.video],
      enableTotalRecordCount: false,
    );
    newRecommendations = [
      ...newRecommendations,
      RecommendedModel(
        name: const Resume(),
        posters: resume.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? [],
        type: null,
      ),
    ];

    if (viewModel.collectionType == CollectionType.movies) {
      final response = await api.moviesRecommendationsGet(
        parentId: viewModel.id,
        categoryLimit: 6,
        itemLimit: 9,
        fields: [ItemFields.mediasourcecount],
      );
      newRecommendations = [
        ...newRecommendations,
        ...(response.body?.map(
              (e) => RecommendedModel.fromBaseDto(e, ref),
            ) ??
            [])
      ];
    } else {
      final nextUp = await api.showsNextUpGet(
        parentId: viewModel.id,
        limit: 9,
        imageTypeLimit: 1,
        fields: [ItemFields.mediasourcecount, ItemFields.primaryimageaspectratio],
      );
      newRecommendations = [
        ...newRecommendations,
        RecommendedModel(
          name: const NextUp(),
          posters: nextUp.body?.items
                  ?.map(
                    (e) => ItemBaseModel.fromBaseDto(
                      e,
                      ref,
                    ),
                  )
                  .toList() ??
              [],
          type: null,
        )
      ];
    }

    final latest = await api.usersUserIdItemsGet(
      parentId: viewModel.id,
      sortBy: [ItemSortBy.datelastcontentadded, ItemSortBy.datecreated, ItemSortBy.sortname],
      sortOrder: [SortOrder.descending],
      includeItemTypes: viewModel.collectionType.itemKinds.map((e) => e.dtoKind).toList(),
    );
    newRecommendations = [
      ...newRecommendations,
      RecommendedModel(
        name: const Latest(),
        posters: latest.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? [],
        type: null,
      ),
    ];

    state = state.copyWith(
      recommendations: newRecommendations,
    );
  }

  Future<Response?> loadFavourites(ViewModel viewModel) async {
    final response = await api.itemsGet(
      parentId: viewModel.id,
      isFavorite: true,
      recursive: true,
      limit: 9,
      includeItemTypes: viewModel.collectionType.itemKinds.map((e) => e.dtoKind).toList(),
      enableImageTypes: [ImageType.primary],
      fields: [
        ItemFields.primaryimageaspectratio,
        ItemFields.mediasourcecount,
      ],
      enableTotalRecordCount: false,
    );

    state = state.copyWith(favourites: response.body?.items ?? []);
    return response;
  }

  Future<Response?> loadGenres(ViewModel viewModel) async {
    final genres = await api.genresGet(
      sortBy: [ItemSortBy.sortname],
      sortOrder: [SortOrder.ascending],
      includeItemTypes:
          viewModel.collectionType == CollectionType.movies ? [BaseItemKind.movie] : [BaseItemKind.series],
      parentId: viewModel.id,
    );

    final filteredGenres = (genres.body?.items?.map(
              (item) => GenreItems(id: item.id ?? "", name: item.name ?? ""),
            ) ??
            [])
        .toList();

    if (filteredGenres.isEmpty) return null;

    final futures = filteredGenres.map((genre) {
      return api
          .itemsGet(
        parentId: viewModel.id,
        genreIds: [genre.id],
        limit: 9,
        recursive: true,
        includeItemTypes: viewModel.collectionType.itemKinds.map((e) => e.dtoKind).toList(),
        enableImageTypes: [ImageType.primary],
        fields: [
          ItemFields.primaryimageaspectratio,
          ItemFields.mediasourcecount,
        ],
        sortBy: [ItemSortBy.random],
        enableTotalRecordCount: false,
        imageTypeLimit: 1,
        sortOrder: [SortOrder.ascending],
      )
          .then((response) {
        final items = response.body?.items;
        if (items != null && items.isNotEmpty) {
          return RecommendedModel(name: Other(genre.name), posters: items);
        }
        return null;
      });
    }).toList();

    final results = await Future.wait(futures);

    state = state.copyWith(
      genres: results.whereType<RecommendedModel>().toList(),
    );

    return null;
  }

  void clear() {
    state = LibraryScreenModel();
  }
}
