import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as dto;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';

class ChannelModel extends ItemBaseModel {
  final String channelId;
  final List<ChannelProgram> programs;

  final ChannelProgram? iCurrentProgram;

  ChannelProgram? get currentProgram =>
      iCurrentProgram ??
      programs.firstWhereOrNull((p) {
        final now = DateTime.now();
        return p.startDate.isBefore(now) && p.endDate.isAfter(now);
      }) ??
      programs.firstOrNull;

  final DateTime startDate;
  final DateTime endDate;

  ChannelModel({
    required this.channelId,
    this.programs = const [],
    required this.startDate,
    required this.endDate,
    required this.iCurrentProgram,
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
  ItemBaseModel get parentBaseModel => this;

  @override
  bool get playAble => true;

  int get currentPage => userData.playbackPositionTicks ~/ 10000;

  @override
  String playText(AppLocalizations l10n) => l10n.read(name);

  @override
  ImageData? get bannerImage => getPosters?.backDrop?.lastOrNull ?? images?.primary ?? getPosters?.primary;

  @override
  ImageData? get tvPosterLarge => getPosters?.primary ?? getPosters?.backDrop?.lastOrNull;

  @override
  double get progress {
    final currentProgram = this.currentProgram;
    if (currentProgram == null) {
      return 0;
    }
    final totalDuration = currentProgram.endDate.difference(currentProgram.startDate).inSeconds;
    final elapsed = DateTime.now().difference(currentProgram.startDate).inSeconds;
    if (totalDuration == 0) {
      return 0;
    }
    return (elapsed / totalDuration) * 100;
  }

  @override
  String? unplayedLabel(AppLocalizations l10n) => userData.progress != 0 ? l10n.page(currentPage) : null;

  @override
  String playButtonLabel(AppLocalizations l10n) => l10n.watchChannel(name);

  @override
  String? get subText => currentProgram?.name;

  @override
  String? subTextShort(AppLocalizations l10n) {
    return currentProgram != null
        ? "${l10n.formattedTime(currentProgram?.startDate ?? DateTime.now())} - ${l10n.formattedTime(currentProgram?.endDate ?? DateTime.now())}"
        : null;
  }

  @override
  ImagesData? get getPosters => images?.copyWith(
        primary: () => programs.firstOrNull?.images?.primary ?? images?.primary,
        backDrop: () => programs.firstOrNull?.images?.backDrop,
        logo: () => images?.primary,
      );

  factory ChannelModel.fromBaseDto(BaseItemDto item, Ref? ref) {
    final images = ref != null ? ImagesData.fromBaseItem(item, ref) : null;
    return ChannelModel(
      channelId: item.channelId ?? item.parentId ?? "0",
      name: item.name ?? "",
      id: item.id ?? "",
      iCurrentProgram:
          (ref != null && item.currentProgram != null) ? ChannelProgram.fromBaseDto(item.currentProgram!, ref) : null,
      childCount: item.childCount,
      startDate: item.startDate ?? DateTime.now(),
      endDate: item.endDate ?? DateTime.now(),
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: images?.copyWith(
        logo: () => images.primary,
      ),
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      primaryRatio: item.primaryImageAspectRatio,
      jellyType: item.type,
    );
  }

  ChannelModel withoutProgress() {
    return ChannelModel(
      channelId: channelId,
      programs: [],
      iCurrentProgram: null,
      startDate: startDate,
      endDate: endDate,
      name: name,
      id: id,
      overview: overview,
      parentId: parentId,
      playlistId: playlistId,
      images: images,
      childCount: childCount,
      primaryRatio: primaryRatio,
      userData: userData,
      jellyType: jellyType,
      canDownload: canDownload,
      canDelete: canDelete,
    );
  }

  ChannelModel copyChannelWith({
    String? channelId,
    List<ChannelProgram>? programs,
    DateTime? startDate,
    DateTime? endDate,
    ChannelProgram? currentProgram,
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
      iCurrentProgram: currentProgram ?? iCurrentProgram,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
