import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/folder_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/person_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/playlist_model.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/details_screens/book_detail_screen.dart';
import 'package:fladder/screens/details_screens/details_screens.dart';
import 'package:fladder/screens/details_screens/episode_detail_screen.dart';
import 'package:fladder/screens/details_screens/season_detail_screen.dart';
import 'package:fladder/screens/library_search/library_search_screen.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

part 'item_base_model.mapper.dart';

@MappableClass()
class ItemBaseModel with ItemBaseModelMappable {
  final String name;
  final String id;
  final OverviewModel overview;
  final String? parentId;
  final String? playlistId;
  final ImagesData? images;
  final int? childCount;
  final double? primaryRatio;
  final UserData userData;
  final bool? canDownload;
  final bool? canDelete;
  final dto.BaseItemKind? jellyType;

  const ItemBaseModel({
    required this.name,
    required this.id,
    required this.overview,
    required this.parentId,
    required this.playlistId,
    required this.images,
    required this.childCount,
    required this.primaryRatio,
    required this.userData,
    required this.canDownload,
    required this.canDelete,
    required this.jellyType,
  });

  ItemBaseModel? setProgress(double progress) {
    return copyWith(userData: userData.copyWith(progress: progress));
  }

  Widget? subTitle(SortingOptions options) => switch (options) {
        SortingOptions.parentalRating => overview.parentalRating != null
            ? Row(
                children: [
                  const Icon(
                    IconsaxBold.star_1,
                    size: 14,
                    color: Colors.yellowAccent,
                  ),
                  const SizedBox(width: 6),
                  Text((overview.parentalRating ?? 0.0).toString())
                ],
              )
            : null,
        SortingOptions.communityRating => overview.communityRating != null
            ? Row(
                children: [
                  const Icon(
                    IconsaxBold.star_1,
                    size: 14,
                    color: Colors.yellowAccent,
                  ),
                  const SizedBox(width: 6),
                  Text((overview.communityRating ?? 0.0).toString())
                ],
              )
            : null,
        _ => null,
      };

  String get title => name;

  ///Used for retrieving the correct id when fetching queue
  String get streamId => id;

  ItemBaseModel get parentBaseModel => copyWith(id: parentId);

  bool get emptyShow => false;

  bool get identifiable => false;

  int? get unPlayedItemCount => userData.unPlayedItemCount;

  bool get unWatched => !userData.played && userData.progress <= 0 && userData.unPlayedItemCount == 0;

  String? detailedName(BuildContext context) => "$name${overview.yearAired != null ? " (${overview.yearAired})" : ""}";

  String? get subText => null;
  String? subTextShort(BuildContext context) => null;
  String? label(BuildContext context) => null;

  ImagesData? get getPosters => images;

  ImageData? get bannerImage => images?.primary ?? getPosters?.randomBackDrop ?? getPosters?.primary;

  bool get playAble => false;

  bool get syncAble => false;

  bool get galleryItem => false;

  MediaStreamsModel? get streamModel => null;

  String playText(BuildContext context) => context.localized.play(name);

  double get progress => userData.progress;

  String playButtonLabel(BuildContext context) =>
      progress != 0 ? context.localized.resume(name.maxLength()) : context.localized.play(name.maxLength());

  Widget get detailScreenWidget {
    switch (this) {
      case PersonModel _:
        return PersonDetailScreen(person: Person(id: id, image: images?.primary));
      case SeasonModel _:
        return SeasonDetailScreen(item: this);
      case FolderModel _:
      case PhotoAlbumModel _:
      case BoxSetModel _:
      case PlaylistModel _:
        return LibrarySearchScreen(folderId: [id]);
      case PhotoModel _:
        final photo = this as PhotoModel;
        return LibrarySearchScreen(
          folderId: [photo.albumId ?? photo.parentId ?? ""],
          photoToView: photo,
        );
      case BookModel book:
        return BookDetailScreen(item: book);
      case MovieModel _:
        return MovieDetailScreen(item: this);
      case EpisodeModel _:
        return EpisodeDetailScreen(item: this);
      case SeriesModel series:
        return SeriesDetailScreen(item: series);
      default:
        return EmptyItem(item: this);
    }
  }

  Future<void> navigateTo(BuildContext context) async => context.router.push(DetailsRoute(id: id, item: this));

  factory ItemBaseModel.fromBaseDto(dto.BaseItemDto item, Ref ref) {
    return switch (item.type) {
      BaseItemKind.photo || BaseItemKind.video => PhotoModel.fromBaseDto(item, ref),
      BaseItemKind.photoalbum => PhotoAlbumModel.fromBaseDto(item, ref),
      BaseItemKind.folder ||
      BaseItemKind.collectionfolder ||
      BaseItemKind.aggregatefolder =>
        FolderModel.fromBaseDto(item, ref),
      BaseItemKind.episode => EpisodeModel.fromBaseDto(item, ref),
      BaseItemKind.movie => MovieModel.fromBaseDto(item, ref),
      BaseItemKind.series => SeriesModel.fromBaseDto(item, ref),
      BaseItemKind.person => PersonModel.fromBaseDto(item, ref),
      BaseItemKind.season => SeasonModel.fromBaseDto(item, ref),
      BaseItemKind.boxset => BoxSetModel.fromBaseDto(item, ref),
      BaseItemKind.book => BookModel.fromBaseDto(item, ref),
      BaseItemKind.playlist => PlaylistModel.fromBaseDto(item, ref),
      _ => ItemBaseModel._fromBaseDto(item, ref)
    };
  }

  factory ItemBaseModel._fromBaseDto(dto.BaseItemDto item, Ref ref) {
    return ItemBaseModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ImagesData.fromBaseItem(item, ref),
      primaryRatio: item.primaryImageAspectRatio,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      jellyType: item.type,
    );
  }

  FladderItemType get type => switch (this) {
        MovieModel _ => FladderItemType.movie,
        SeriesModel _ => FladderItemType.series,
        SeasonModel _ => FladderItemType.season,
        PhotoAlbumModel _ => FladderItemType.photoAlbum,
        PhotoModel model => model.internalType,
        EpisodeModel _ => FladderItemType.episode,
        BookModel _ => FladderItemType.book,
        PlaylistModel _ => FladderItemType.playlist,
        FolderModel _ => FladderItemType.folder,
        ItemBaseModel _ => FladderItemType.baseType,
      };

  @override
  bool operator ==(covariant ItemBaseModel other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ type.hashCode;
  }
}

// Currently supported types
enum FladderItemType {
  baseType(
    icon: IconsaxOutline.folder_2,
    selectedicon: IconsaxBold.folder_2,
  ),
  audio(
    icon: IconsaxOutline.music,
    selectedicon: IconsaxBold.music,
  ),
  musicAlbum(
    icon: IconsaxOutline.music,
    selectedicon: IconsaxBold.music,
  ),
  musicVideo(
    icon: IconsaxOutline.music,
    selectedicon: IconsaxBold.music,
  ),
  collectionFolder(
    icon: IconsaxOutline.music,
    selectedicon: IconsaxBold.music,
  ),
  video(
    icon: IconsaxOutline.video,
    selectedicon: IconsaxBold.video,
  ),
  movie(
    icon: IconsaxOutline.video_horizontal,
    selectedicon: IconsaxBold.video_horizontal,
  ),
  series(
    icon: IconsaxOutline.video_vertical,
    selectedicon: IconsaxBold.video_vertical,
  ),
  season(
    icon: IconsaxOutline.video_vertical,
    selectedicon: IconsaxBold.video_vertical,
  ),
  episode(
    icon: IconsaxOutline.video_vertical,
    selectedicon: IconsaxBold.video_vertical,
  ),
  photo(
    icon: IconsaxOutline.picture_frame,
    selectedicon: IconsaxBold.picture_frame,
  ),
  person(
    icon: IconsaxOutline.user,
    selectedicon: IconsaxBold.user,
  ),
  photoAlbum(
    icon: IconsaxOutline.gallery,
    selectedicon: IconsaxBold.gallery,
  ),
  folder(
    icon: IconsaxOutline.folder,
    selectedicon: IconsaxBold.folder,
  ),
  boxset(
    icon: IconsaxOutline.bookmark,
    selectedicon: IconsaxBold.bookmark,
  ),
  playlist(
    icon: IconsaxOutline.archive_book,
    selectedicon: IconsaxBold.archive_book,
  ),
  book(
    icon: IconsaxOutline.book,
    selectedicon: IconsaxBold.book,
  );

  const FladderItemType({required this.icon, required this.selectedicon});

  static Set<FladderItemType> get playable => {
        FladderItemType.series,
        FladderItemType.episode,
        FladderItemType.season,
        FladderItemType.movie,
        FladderItemType.musicVideo,
      };

  static Set<FladderItemType> get galleryItem => {
        FladderItemType.photo,
        FladderItemType.video,
      };

  String label(BuildContext context) {
    return switch (this) {
      FladderItemType.baseType => context.localized.mediaTypeBase,
      FladderItemType.audio => context.localized.audio,
      FladderItemType.collectionFolder => context.localized.collectionFolder,
      FladderItemType.musicAlbum => context.localized.musicAlbum,
      FladderItemType.musicVideo => context.localized.video,
      FladderItemType.video => context.localized.video,
      FladderItemType.movie => context.localized.mediaTypeMovie,
      FladderItemType.series => context.localized.mediaTypeSeries,
      FladderItemType.season => context.localized.mediaTypeSeason,
      FladderItemType.episode => context.localized.mediaTypeEpisode,
      FladderItemType.photo => context.localized.mediaTypePhoto,
      FladderItemType.person => context.localized.mediaTypePerson,
      FladderItemType.photoAlbum => context.localized.mediaTypePhotoAlbum,
      FladderItemType.folder => context.localized.mediaTypeFolder,
      FladderItemType.boxset => context.localized.mediaTypeBoxset,
      FladderItemType.playlist => context.localized.mediaTypePlaylist,
      FladderItemType.book => context.localized.mediaTypeBook,
    };
  }

  BaseItemKind get dtoKind => switch (this) {
        FladderItemType.baseType => BaseItemKind.userrootfolder,
        FladderItemType.audio => BaseItemKind.audio,
        FladderItemType.collectionFolder => BaseItemKind.collectionfolder,
        FladderItemType.musicAlbum => BaseItemKind.musicalbum,
        FladderItemType.musicVideo => BaseItemKind.video,
        FladderItemType.video => BaseItemKind.video,
        FladderItemType.movie => BaseItemKind.movie,
        FladderItemType.series => BaseItemKind.series,
        FladderItemType.season => BaseItemKind.season,
        FladderItemType.episode => BaseItemKind.episode,
        FladderItemType.photo => BaseItemKind.photo,
        FladderItemType.person => BaseItemKind.person,
        FladderItemType.photoAlbum => BaseItemKind.photoalbum,
        FladderItemType.folder => BaseItemKind.folder,
        FladderItemType.boxset => BaseItemKind.boxset,
        FladderItemType.playlist => BaseItemKind.playlist,
        FladderItemType.book => BaseItemKind.book,
      };

  final IconData icon;
  final IconData selectedicon;
}
