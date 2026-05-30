import 'dart:async';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/music_dashboard_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/dashboard/music_playlist_row.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/button_group.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/poster_size_slider.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

class MusicDashboardScreen extends ConsumerStatefulWidget {
  const MusicDashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MusicDashboardScreenState();
}

class _MusicDashboardScreenState extends ConsumerState<MusicDashboardScreen> {
  late final Timer _timer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final selectedPoster = ValueNotifier<ItemBaseModel?>(null);
  MusicTrackSection _selectedRecentTrackSection = MusicTrackSection.recentlyAdded;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(musicDashboardProvider.notifier).fetchMusicHome());
    _timer = Timer.periodic(const Duration(seconds: 120), (timer) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _refreshHome() async {
    if (mounted) {
      await ref.read(userProvider.notifier).updateInformation();
      await ref.read(viewsProvider.notifier).fetchViews();
      await ref.read(musicDashboardProvider.notifier).fetchMusicHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = AdaptiveLayout.adaptivePadding(context);
    final musicDashboard = ref.watch(musicDashboardProvider);
    final useTVExpandedLayout = ref.watch(clientSettingsProvider.select((value) => value.useTVExpandedLayout));
    final viewSize = AdaptiveLayout.viewSizeOf(context);

    final backgroundItems = [
      ...musicDashboard.playlists,
      ...musicDashboard.recentlyAddedAlbums,
      ...musicDashboard.recentlyAddedArtists,
      ...musicDashboard.mostPlayed,
    ];

    final recentTrackSections = <({MusicTrackSection section, String label, List<AudioModel> tracks})>[
      (
        section: MusicTrackSection.recentlyAdded,
        label: context.localized.recentlyAdded,
        tracks: musicDashboard.recentlyAddedSongs,
      ),
      (
        section: MusicTrackSection.recentlyPlayed,
        label: context.localized.recentlyPlayed,
        tracks: musicDashboard.recentlyPlayedSongs,
      ),
      (
        section: MusicTrackSection.recentlyFavorited,
        label: context.localized.recentlyFavorited,
        tracks: musicDashboard.recentlyFavoritedSongs,
      ),
    ];
    final availableRecentTrackSections =
        recentTrackSections.where((section) => section.tracks.isNotEmpty).toList(growable: false);
    final activeRecentTrackSection =
        availableRecentTrackSections.firstWhereOrNull((section) => section.section == _selectedRecentTrackSection) ??
            availableRecentTrackSections.firstOrNull;

    return NestedScaffold(
      background: ValueListenableBuilder<ItemBaseModel?>(
        valueListenable: selectedPoster,
        builder: (_, value, __) {
          return BackgroundImage(
            images: (value != null ? [value] : backgroundItems).map((e) => e.images).nonNulls.toList(),
          );
        },
      ),
      body: PullToRefresh(
        refreshKey: _refreshIndicatorKey,
        displacement: 80 + MediaQuery.of(context).viewPadding.top,
        onRefresh: () async => await _refreshHome(),
        child: (context) => PinchPosterZoom(
          scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference),
          child: CustomScrollView(
            controller: AdaptiveLayout.scrollOf(context, HomeTabs.dashboard),
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const DefaultSliverTopBadding(),
              if (viewSize == ViewSize.phone)
                NestedSliverAppBar(
                  route: LibrarySearchRoute(),
                  parent: context,
                ),
              if (AdaptiveLayout.of(context).isDesktop)
                const SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PosterSizeWidget(),
                    ],
                  ),
                ),
              ...[
                if (musicDashboard.playlists.isNotEmpty)
                  MusicPlaylistRow(
                    playlists:
                        musicDashboard.playlists.map((playlist) => playlist.copyWith(canDownload: true)).toList(),
                    contentPadding: padding,
                    label: FladderItemType.playlist.label(context.localized, count: musicDashboard.playlists.length),
                    onPlaylistPlayTap: (playlist) => playlist.play(context, ref),
                  ),
                if (musicDashboard.recentlyAddedAlbums.isNotEmpty)
                  PosterRow(
                    tvMode: useTVExpandedLayout,
                    contentPadding: padding,
                    label: context.localized.dashboardRecentlyAddedItems(
                      FladderItemType.musicAlbum
                          .label(context.localized, count: musicDashboard.recentlyAddedAlbums.length)
                          .toLowerCase(),
                    ),
                    collectionAspectRatio: FladderItemType.musicAlbum.aspectRatio,
                    posters: musicDashboard.recentlyAddedAlbums,
                  ),
                if (activeRecentTrackSection != null)
                  Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ExpressiveButtonGroup<MusicTrackSection>(
                                options: availableRecentTrackSections
                                    .map(
                                      (section) => ButtonGroupOption(
                                        value: section.section,
                                        child: Text(section.label),
                                      ),
                                    )
                                    .toList(growable: false),
                                selectedValues: {activeRecentTrackSection.section},
                                onSelected: (value) {
                                  final section = value.firstOrNull;
                                  if (section == null) return;
                                  setState(() => _selectedRecentTrackSection = section);
                                },
                              ),
                            ],
                          ),
                        ),
                        TrackList(
                          title: '',
                          showHeader: false,
                          tracks: activeRecentTrackSection.tracks,
                          showAlbum: true,
                          maxTracks: 10,
                          onTrackTap: (track) => track.parentBaseModel.navigateTo(context),
                          onTrackPlayTap: (track) =>
                              _playTrackFromSection(track, section: activeRecentTrackSection.section),
                          onTrackSecondaryTap: (_, __) {},
                        ),
                      ],
                    ),
                  ),
                if (musicDashboard.recentlyAddedArtists.isNotEmpty)
                  PosterRow(
                    tvMode: useTVExpandedLayout,
                    contentPadding: padding,
                    label: context.localized.dashboardRecentlyAddedItems(
                      FladderItemType.musicArtist
                          .label(context.localized, count: musicDashboard.recentlyAddedArtists.length)
                          .toLowerCase(),
                    ),
                    collectionAspectRatio: FladderItemType.musicAlbum.aspectRatio,
                    posters: musicDashboard.recentlyAddedArtists,
                  ),
                if (musicDashboard.mostPlayed.isNotEmpty)
                  PosterRow(
                    tvMode: useTVExpandedLayout,
                    contentPadding: padding,
                    label: context.localized.mostPlayed,
                    collectionAspectRatio: FladderItemType.musicAlbum.aspectRatio,
                    posters: musicDashboard.mostPlayed,
                  ),
              ]
                  .nonNulls
                  .toList()
                  .mapIndexed(
                    (index, child) => SliverToBoxAdapter(
                      child: FocusProvider(
                        autoFocus: index == 0,
                        child: child,
                      ),
                    ),
                  )
                  .toList()
                  .addInBetween(
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 32),
                    ),
                  ),
              const DefaultSliverBottomPadding(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _playTrackFromSection(AudioModel selectedTrack, {required MusicTrackSection section}) async {
    await ref.read(videoPlayerProvider.notifier).init();

    final fetchedQueue = await ref.read(musicDashboardProvider.notifier).fetchTrackQueue(section: section);
    final queue = fetchedQueue.isNotEmpty ? fetchedQueue : <ItemBaseModel>[selectedTrack];

    final selectedItem = queue.firstWhereOrNull((item) => item.id == selectedTrack.id) ?? queue.first;
    final currentIndex = queue.indexWhere((item) => item.id == selectedItem.id).clamp(0, queue.length - 1);

    final model = await ref.read(playbackModelHelper).createPlaybackModel(
          context,
          selectedItem,
          libraryQueue: queue,
          showPlaybackOptions: false,
        );

    if (model == null) {
      if (mounted) {
        FladderSnack.show(context.localized.unableToPlayMedia, context: context);
      }
      return;
    }

    final startPosition = await model.startDuration() ?? Duration.zero;

    await ref.read(videoPlayerProvider.notifier).loadAudioPlaybackItem(
          model,
          queue,
          currentIndex,
          startPosition,
        );
  }
}
