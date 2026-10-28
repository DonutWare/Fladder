// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';

class DashboardFilterModel {
  final LibraryFiltersModel filter;
  final List<ItemBaseModel> items;

  const DashboardFilterModel({
    required this.filter,
    required this.items,
  });
}

class HomeModel {
  final bool loading;
  final List<ItemBaseModel> resumeVideo;
  final List<ItemBaseModel> resumeAudio;
  final List<ItemBaseModel> resumeBooks;
  final List<ItemBaseModel> activePrograms;
  final List<ItemBaseModel> nextUp;
  final List<DashboardFilterModel> dashboardFilters;
  final Set<DashboardSorting> loadedSections;

  HomeModel({
    this.loading = false,
    this.resumeVideo = const [],
    this.resumeAudio = const [],
    this.resumeBooks = const [],
    this.activePrograms = const [],
    this.nextUp = const [],
    this.dashboardFilters = const [],
    this.loadedSections = const {},
  });

  HomeModel copyWith({
    bool? loading,
    List<ItemBaseModel>? resumeVideo,
    List<ItemBaseModel>? resumeAudio,
    List<ItemBaseModel>? resumeBooks,
    List<ItemBaseModel>? activePrograms,
    List<ItemBaseModel>? nextUp,
    List<ItemBaseModel>? nextUpBooks,
    List<DashboardFilterModel>? dashboardFilters,
    Set<DashboardSorting>? loadedSections,
  }) {
    return HomeModel(
      loading: loading ?? this.loading,
      resumeVideo: resumeVideo ?? this.resumeVideo,
      resumeAudio: resumeAudio ?? this.resumeAudio,
      resumeBooks: resumeBooks ?? this.resumeBooks,
      activePrograms: activePrograms ?? this.activePrograms,
      nextUp: nextUp ?? this.nextUp,
      dashboardFilters: dashboardFilters ?? this.dashboardFilters,
      loadedSections: loadedSections ?? this.loadedSections,
    );
  }
}
