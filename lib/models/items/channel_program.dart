import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';

part 'channel_program.freezed.dart';
part 'channel_program.g.dart';

@freezed
abstract class ChannelProgram with _$ChannelProgram {
  const ChannelProgram._();

  factory ChannelProgram({
    required String id,
    required String channelId,
    required String name,
    required String officialRating,
    required int productionYear,
    required int indexNumber,
    required int parentIndexNumber,
    String? episodeTitle,
    required DateTime startDate,
    required DateTime endDate,
    ImagesData? images,
    required bool isSeries,
    String? overview,
  }) = _ChannelProgram;

  factory ChannelProgram.fromJson(Map<String, dynamic> json) => _$ChannelProgramFromJson(json);

  factory ChannelProgram.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return ChannelProgram(
      id: item.id ?? "",
      channelId: item.channelId ?? item.parentId ?? "",
      name: item.name ?? "",
      officialRating: item.officialRating ?? "",
      productionYear: item.productionYear ?? 0,
      indexNumber: item.indexNumber ?? 0,
      parentIndexNumber: item.parentIndexNumber ?? 0,
      episodeTitle: item.episodeTitle,
      startDate: (item.startDate ?? DateTime.now()).toLocal(),
      endDate: (item.endDate ?? DateTime.now()).toLocal(),
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      isSeries: item.isSeries ?? false,
      overview: item.overview,
    );
  }

  ChannelModel get channel => ChannelModel(
        channelId: channelId,
        iCurrentProgram: null,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        name: "",
        id: channelId,
        images: null,
        overview: const OverviewModel(),
        parentId: "",
        playlistId: "",
        childCount: 0,
        primaryRatio: 0,
        userData: const UserData(),
        canDelete: false,
        canDownload: false,
      );

  String subLabel(AppLocalizations l10n) => isSeries
      ? "$episodeTitle - ${seasonAnnotation(l10n)}$parentIndexNumber: ${episodeAnnotation(l10n)}$indexNumber"
      : name;

  String seasonEpisodeLabel(AppLocalizations l10n) {
    return "${seasonAnnotation(l10n)}$parentIndexNumber - ${episodeAnnotation(l10n)}$indexNumber";
  }

  String seasonAnnotation(AppLocalizations l10n) => l10n.season(1)[0];
  String episodeAnnotation(AppLocalizations l10n) => l10n.episode(1)[0];

  ItemBaseModel toItemBaseModel() {
    return ItemBaseModel(
      id: id,
      name: name,
      overview: OverviewModel(summary: overview ?? "", productionYear: productionYear),
      parentId: channelId,
      playlistId: "",
      images: images,
      childCount: 0,
      primaryRatio: 0,
      userData: const UserData(),
      canDownload: false,
      canDelete: false,
      jellyType: BaseItemKind.tvchannel,
    );
  }
}
