import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/items/channel_model.dart';
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
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/details_screens/book_detail_screen.dart';
import 'package:fladder/screens/details_screens/channel_detail_screen.dart';
import 'package:fladder/screens/details_screens/details_screens.dart';
import 'package:fladder/screens/details_screens/episode_detail_screen.dart';
import 'package:fladder/screens/details_screens/season_detail_screen.dart';
import 'package:fladder/screens/library_search/library_search_screen.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_screen.dart';
import 'package:fladder/src/video_player_helper.g.dart' show SimpleItemModel;
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
        SortingOptions.parentalRating => Row(
            children: [
              const Icon(
                IconsaxPlusBold.star_1,
                size: 14,
                color: Colors.yellowAccent,
              ),
              const SizedBox(width: 6),
              Text(overview.parentalRating?.toString() ?? "--"),
            ],
          ),
        SortingOptions.communityRating => Row(
            children: [
              const Icon(
                IconsaxPlusBold.star_1,
                size: 14,
                color: Colors.yellowAccent,
              ),
              const SizedBox(width: 6),
              Text(overview.communityRating?.toStringAsFixed(2) ?? "--"),
            ],
          ),
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

  bool get watched => userData.played;

  String? unplayedLabel(BuildContext context) => null;

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
      case BoxSetModel _:
      case PlaylistModel _:
      case PhotoAlbumModel _:
        return LibrarySearchScreen(folderId: [id]);
      case PhotoModel _:
        final photo = this as PhotoModel;
        return PhotoViewerScreen(
          items: [photo],
        );
      case BookModel book:
        return BookDetailScreen(item: book);
      case MovieModel _:
        return MovieDetailScreen(item: this);
      case EpisodeModel _:
        return EpisodeDetailScreen(item: this);
      case SeriesModel series:
        return SeriesDetailScreen(item: series);
      case ChannelModel channel:
        return ChannelDetailScreen(item: channel);
      default:
        return EmptyItem(item: this);
    }
  }

  Future<void> navigateTo(BuildContext context, {WidgetRef? ref, Object? tag}) async {
    switch (this) {
      case FolderModel _:
      case BoxSetModel _:
      case PlaylistModel _:
        context.router.push(LibrarySearchRoute(folderId: [id], recursive: true));
        break;
      case PhotoAlbumModel _:
        context.router.push(LibrarySearchRoute(folderId: [id], recursive: false));
        break;
      case PhotoModel _:
        final photo = this as PhotoModel;
        context.router.push(
          PhotoViewerRoute(
            items: [photo],
            loadingItems: ref?.read(jellyApiProvider).itemsGetAlbumPhotos(albumId: photo.albumId),
            selected: photo.id,
          ),
        );
        break;
      case BookModel _:
      case MovieModel _:
      case EpisodeModel _:
      case SeriesModel _:
      case SeasonModel _:
      case PersonModel _:
      default:
        context.router.push(DetailsRoute(id: id, item: this, tag: tag));
        break;
    }
  }

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
      BaseItemKind.tvchannel => ChannelModel.fromBaseDto(item, ref),
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

  SimpleItemModel toSimpleItem(BuildContext? context) {
    return SimpleItemModel(
      id: id,
      title: title,
      subTitle: context != null ? label(context) : null,
      overview: overview.summary,
      logoUrl: getPosters?.logo?.path ?? images?.logo?.path,
      primaryPoster: images?.primary?.path ?? getPosters?.primary?.path ?? "",
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
    icon: IconsaxPlusLinear.folder_2,
    selectedicon: IconsaxPlusBold.folder_2,
  ),
  audio(
    icon: IconsaxPlusLinear.music,
    selectedicon: IconsaxPlusBold.music,
  ),
  musicAlbum(
    icon: IconsaxPlusLinear.music,
    selectedicon: IconsaxPlusBold.music,
  ),
  musicVideo(
    icon: IconsaxPlusLinear.music,
    selectedicon: IconsaxPlusBold.music,
  ),
  collectionFolder(
    icon: IconsaxPlusLinear.music,
    selectedicon: IconsaxPlusBold.music,
  ),
  video(
    icon: IconsaxPlusLinear.video,
    selectedicon: IconsaxPlusBold.video,
  ),
  movie(
    icon: IconsaxPlusLinear.video_horizontal,
    selectedicon: IconsaxPlusBold.video_horizontal,
  ),
  series(
    icon: IconsaxPlusLinear.video_vertical,
    selectedicon: IconsaxPlusBold.video_vertical,
  ),
  season(
    icon: IconsaxPlusLinear.video_vertical,
    selectedicon: IconsaxPlusBold.video_vertical,
  ),
  episode(
    icon: IconsaxPlusLinear.video_vertical,
    selectedicon: IconsaxPlusBold.video_vertical,
  ),
  photo(
    icon: IconsaxPlusLinear.picture_frame,
    selectedicon: IconsaxPlusBold.picture_frame,
  ),
  person(
    icon: IconsaxPlusLinear.user,
    selectedicon: IconsaxPlusBold.user,
  ),
  photoAlbum(
    icon: IconsaxPlusLinear.gallery,
    selectedicon: IconsaxPlusBold.gallery,
  ),
  folder(
    icon: IconsaxPlusLinear.folder,
    selectedicon: IconsaxPlusBold.folder,
  ),
  boxset(
    icon: IconsaxPlusLinear.bookmark,
    selectedicon: IconsaxPlusBold.bookmark,
  ),
  playlist(
    icon: IconsaxPlusLinear.archive_book,
    selectedicon: IconsaxPlusBold.archive_book,
  ),
  book(
    icon: IconsaxPlusLinear.book,
    selectedicon: IconsaxPlusBold.book,
  );

  const FladderItemType({required this.icon, required this.selectedicon});

  double get aspectRatio => switch (this) {
        FladderItemType.video => 0.8,
        FladderItemType.photo => 0.8,
        FladderItemType.photoAlbum => 0.8,
        FladderItemType.folder => 0.8,
        FladderItemType.musicAlbum => 0.8,
        FladderItemType.baseType => 0.8,
        _ => 0.55,
      };

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

  String label(BuildContext context, {int count = 1}) => switch (this) {
        FladderItemType.baseType => context.localized.mediaTypeBase,
        FladderItemType.audio => context.localized.audio(count),
        FladderItemType.collectionFolder => context.localized.collectionFolder(count),
        FladderItemType.musicAlbum => context.localized.musicAlbum(count),
        FladderItemType.musicVideo => context.localized.video(count),
        FladderItemType.video => context.localized.video(count),
        FladderItemType.movie => context.localized.mediaTypeMovie(count),
        FladderItemType.series => context.localized.mediaTypeSeries(count),
        FladderItemType.season => context.localized.mediaTypeSeason(count),
        FladderItemType.episode => context.localized.mediaTypeEpisode(count),
        FladderItemType.photo => context.localized.mediaTypePhoto(count),
        FladderItemType.person => context.localized.mediaTypePerson(count),
        FladderItemType.photoAlbum => context.localized.mediaTypePhotoAlbum(count),
        FladderItemType.folder => context.localized.mediaTypeFolder(count),
        FladderItemType.boxset => context.localized.mediaTypeBoxset(count),
        FladderItemType.playlist => context.localized.mediaTypePlaylist(count),
        FladderItemType.book => context.localized.mediaTypeBook(count),
      };

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
