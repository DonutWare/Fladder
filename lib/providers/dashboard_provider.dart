import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/util/list_extensions.dart';

final dashboardProvider = StateNotifierProvider<DashboardNotifier, HomeModel>((ref) {
  return DashboardNotifier(ref);
});

class DashboardNotifier extends StateNotifier<HomeModel> {
  DashboardNotifier(this.ref) : super(HomeModel());

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<void> fetchNextUpAndResume() async {
    if (state.loading) return;
    state = state.copyWith(loading: true);
    final viewTypes =
        ref.read(viewsProvider.select((value) => value.dashboardViews)).map((e) => e.collectionType).toSet().toList();
    final limit = 16;

    final imagesToFetch = {
      ImageType.logo,
      ImageType.thumb,
      ImageType.primary,
      ImageType.backdrop,
      ImageType.banner,
    }.toList();

    final fieldsToFetch = {
      ItemFields.parentid,
      ItemFields.mediastreams,
      ItemFields.mediasources,
      ItemFields.candelete,
      ItemFields.candownload,
      ItemFields.primaryimageaspectratio,
      ItemFields.overview,
      ItemFields.airtime,
    };

    Future<List<ChannelModel>> fetchActivePrograms() async {
      List<ChannelModel> channels = (await api.liveTvChannelsGet(limit: limit))
              .body
              ?.items
              ?.map((e) => ChannelModel.fromBaseDto(e, ref))
              .toList() ??
          [];

      return Future.wait(
        channels.map(
          (e) async {
            final programs = await ref.read(liveTvProvider.notifier).fetchProgramsForChannel(e);
            return e.copyChannelWith(
              programs: programs,
            );
          },
        ),
      );
    }

    List<ItemBaseModel> activePrograms = [];
    List<ItemBaseModel>? resumeVideo;
    List<ItemBaseModel>? resumeAudio;
    List<ItemBaseModel>? resumeBooks;
    List<ItemBaseModel> nextUp = [];

    // eagerError: true, weil die alte sequenzielle Kette beim ersten Fehler
    // ebenfalls sofort abbrach (spätere Requests wurden gar nicht erst gestartet).
    final pending = <Future<void>>[
      if (viewTypes.containsAny([CollectionType.livetv]))
        fetchActivePrograms().then((value) {
          activePrograms = value;
        }),
      if (viewTypes.containsAny([CollectionType.movies, CollectionType.tvshows]))
        api
            .usersUserIdItemsResumeGet(
          enableImageTypes: imagesToFetch,
          fields: fieldsToFetch.toList(),
          mediaTypes: [MediaType.video],
          enableTotalRecordCount: false,
          limit: limit,
        )
            .then((response) {
          resumeVideo = response.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList();
        }),
      if (viewTypes.contains(CollectionType.music))
        api
            .usersUserIdItemsResumeGet(
          enableImageTypes: imagesToFetch,
          fields: fieldsToFetch.toList(),
          mediaTypes: [MediaType.audio],
          enableTotalRecordCount: false,
          limit: limit,
        )
            .then((response) {
          resumeAudio = response.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList();
        }),
      if (viewTypes.contains(CollectionType.books))
        api
            .usersUserIdItemsResumeGet(
          enableImageTypes: imagesToFetch,
          fields: fieldsToFetch.toList(),
          mediaTypes: [MediaType.book],
          enableTotalRecordCount: false,
          limit: limit,
        )
            .then((response) {
          resumeBooks = response.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList();
        }),
      api
          .showsNextUpGet(
        nextUpDateCutoff: DateTime.now().subtract(
            ref.read(clientSettingsProvider.select((value) => value.nextUpDateCutoff ?? const Duration(days: 28)))),
        fields: fieldsToFetch.toList(),
        enableImageTypes: imagesToFetch,
        imageTypeLimit: 1,
      )
          .then((response) {
        nextUp = response.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? [];
      }),
    ];

    try {
      await Future.wait(pending, eagerError: true);
      state = state.copyWith(
        activePrograms: activePrograms,
        resumeVideo: resumeVideo,
        resumeAudio: resumeAudio,
        resumeBooks: resumeBooks,
        nextUp: nextUp,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void clear() {
    state = HomeModel();
  }
}
