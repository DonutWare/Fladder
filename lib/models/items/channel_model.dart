import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as dto;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/util/localization_helper.dart';

class ChannelModel extends ItemBaseModel {
  final String channelId;
  final List<ChannelProgram> programs;

  ChannelModel({
    required this.channelId,
    this.programs = const [],
    required super.name,
    required super.id,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    super.jellyType,
    required super.canDownload,
    required super.canDelete,
  });

  Map<DateTime, List<ChannelProgram>> get programsMap {
    final map = <DateTime, List<ChannelProgram>>{};
    final sorted = [...programs]..sort((a, b) => a.startDate.compareTo(b.startDate));
    for (var program in sorted) {
      final day = DateTime(program.startDate.year, program.startDate.month, program.startDate.day);
      map.putIfAbsent(day, () => []).add(program);
    }
    return map;
  }

  @override
  ItemBaseModel get parentBaseModel => copyWith(id: parentId);

  @override
  bool get playAble => true;

  int get currentPage => userData.playbackPositionTicks ~/ 10000;

  @override
  String playText(BuildContext context) => context.localized.read(name);

  @override
  double get progress => userData.progress != 0 ? 100 : 0;

  @override
  String? unplayedLabel(BuildContext context) => userData.progress != 0 ? context.localized.page(currentPage) : null;

  @override
  String playButtonLabel(BuildContext context) => context.localized.watchChannel(name);

  factory ChannelModel.fromBaseDto(BaseItemDto item, Ref ref) {
    return ChannelModel(
      channelId: item.channelId ?? "0",
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ImagesData.fromBaseItem(item, ref),
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      primaryRatio: item.primaryImageAspectRatio,
      jellyType: item.type,
    );
  }

  ChannelModel copyWithTwo({
    String? channelId,
    List<ChannelProgram>? programs,
    String? name,
    String? id,
    OverviewModel? overview,
    String? parentId,
    String? playlistId,
    ImagesData? images,
    int? childCount,
    double? primaryRatio,
    UserData? userData,
    dto.BaseItemKind? jellyType,
    bool? canDownload,
    bool? canDelete,
  }) {
    return ChannelModel(
      channelId: channelId ?? this.channelId,
      programs: programs ?? this.programs,
      name: name ?? this.name,
      id: id ?? this.id,
      overview: overview ?? this.overview,
      parentId: parentId ?? this.parentId,
      playlistId: playlistId ?? this.playlistId,
      images: images ?? this.images,
      childCount: childCount ?? this.childCount,
      primaryRatio: primaryRatio ?? this.primaryRatio,
      userData: userData ?? this.userData,
      jellyType: jellyType ?? this.jellyType,
      canDownload: canDownload ?? this.canDownload,
      canDelete: canDelete ?? this.canDelete,
    );
  }
}
