import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/util/localization_helper.dart';

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

  factory ChannelProgram.fromBaseDto(dto.BaseItemDto item, Ref ref) {
    return ChannelProgram(
      id: item.id ?? "",
      channelId: item.channelId ?? "",
      name: item.name ?? "",
      officialRating: item.officialRating ?? "",
      productionYear: item.productionYear ?? 0,
      indexNumber: item.indexNumber ?? 0,
      parentIndexNumber: item.parentIndexNumber ?? 0,
      episodeTitle: item.episodeTitle,
      startDate: (item.startDate ?? DateTime.now()).toLocal(),
      endDate: (item.endDate ?? DateTime.now()).toLocal(),
      images: ImagesData.fromBaseItem(item, ref),
      isSeries: item.isSeries ?? false,
      overview: item.overview,
    );
  }

  String subLabel(BuildContext context) => isSeries
      ? "$episodeTitle - ${seasonAnnotation(context)}$parentIndexNumber: ${episodeAnnotation(context)}$indexNumber"
      : name;

  String seasonEpisodeLabel(BuildContext context) {
    return "${seasonAnnotation(context)}$parentIndexNumber - ${episodeAnnotation(context)}$indexNumber";
  }

  String seasonAnnotation(BuildContext context) => context.localized.season(1)[0];
  String episodeAnnotation(BuildContext context) => context.localized.episode(1)[0];
}
