// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fladder/models/item_base_model.dart';

class HomeModel {
  final bool loading;
  final List<ItemBaseModel> resumeVideo;
  final List<ItemBaseModel> resumeAudio;
  final List<ItemBaseModel> resumeBooks;
  final List<ItemBaseModel> activePrograms;
  final List<ItemBaseModel> nextUp;

  HomeModel({
    this.loading = false,
    this.resumeVideo = const [],
    this.resumeAudio = const [],
    this.resumeBooks = const [],
    this.activePrograms = const [],
    this.nextUp = const [],
  });

  HomeModel copyWith({
    bool? loading,
    List<ItemBaseModel>? resumeVideo,
    List<ItemBaseModel>? resumeAudio,
    List<ItemBaseModel>? resumeBooks,
    List<ItemBaseModel>? activePrograms,
    List<ItemBaseModel>? nextUp,
    List<ItemBaseModel>? nextUpBooks,
  }) {
    return HomeModel(
      loading: loading ?? this.loading,
      resumeVideo: resumeVideo ?? this.resumeVideo,
      resumeAudio: resumeAudio ?? this.resumeAudio,
      resumeBooks: resumeBooks ?? this.resumeBooks,
      activePrograms: activePrograms ?? this.activePrograms,
      nextUp: nextUp ?? this.nextUp,
    );
  }
}
