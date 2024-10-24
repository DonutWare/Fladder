import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/dashboard_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/dashboard/home_banner_widget.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/poster_size_slider.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late final Timer _timer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
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
      await ref.read(dashboardProvider.notifier).fetchNextUpAndResume();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardData = ref.watch(dashboardProvider);
    final views = ref.watch(viewsProvider);
    final homeSettings = ref.watch(homeSettingsProvider);
    final homeBanner = ref.watch(homeSettingsProvider.select((value) => value.homeBanner)) != HomeBanner.hide;
    final resumeVideo = dashboardData.resumeVideo;
    final resumeAudio = dashboardData.resumeAudio;
    final resumeBooks = dashboardData.resumeBooks;

    final allResume = [...resumeVideo, ...resumeAudio, ...resumeBooks].toList();

    final homeCarouselItems = switch (homeSettings.carouselSettings) {
      HomeCarouselSettings.nextUp => dashboardData.nextUp,
      HomeCarouselSettings.combined => [...allResume, ...dashboardData.nextUp],
      HomeCarouselSettings.cont => allResume,
    };

    return MediaQuery.removeViewInsets(
      context: context,
      child: NestedScaffold(
        body: PullToRefresh(
          refreshKey: _refreshIndicatorKey,
          displacement: 80 + MediaQuery.of(context).viewPadding.top,
          onRefresh: () async => await _refreshHome(),
          child: PinchPosterZoom(
            scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference),
            child: CustomScrollView(
              controller: AdaptiveLayout.scrollOf(context),
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                if (AdaptiveLayout.of(context).layout == LayoutState.phone)
                  NestedSliverAppBar(
                    route: LibrarySearchRoute(),
                    parent: context,
                  ),
                if (homeBanner && homeCarouselItems.isNotEmpty) ...{
                  SliverToBoxAdapter(
                    child: Transform.translate(
                      offset: Offset(0, AdaptiveLayout.layoutOf(context) == LayoutState.phone ? -14 : 0),
                      child: HomeBannerWidget(posters: homeCarouselItems),
                    ),
                  ),
                } else if (AdaptiveLayout.of(context).isDesktop)
                  const DefaultSliverTopBadding(),
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
                  if (resumeVideo.isNotEmpty &&
                      (homeSettings.nextUp == HomeNextUp.cont || homeSettings.nextUp == HomeNextUp.separate))
                    SliverToBoxAdapter(
                      child: PosterRow(
                        label: context.localized.dashboardContinueWatching,
                        posters: resumeVideo,
                      ),
                    ),
                  if (resumeAudio.isNotEmpty &&
                      (homeSettings.nextUp == HomeNextUp.cont || homeSettings.nextUp == HomeNextUp.separate))
                    SliverToBoxAdapter(
                      child: PosterRow(
                        label: context.localized.dashboardContinueListening,
                        posters: resumeAudio,
                      ),
                    ),
                  if (resumeBooks.isNotEmpty &&
                      (homeSettings.nextUp == HomeNextUp.cont || homeSettings.nextUp == HomeNextUp.separate))
                    SliverToBoxAdapter(
                      child: PosterRow(
                        label: context.localized.dashboardContinueReading,
                        posters: resumeBooks,
                      ),
                    ),
                  if (dashboardData.nextUp.isNotEmpty &&
                      (homeSettings.nextUp == HomeNextUp.nextUp || homeSettings.nextUp == HomeNextUp.separate))
                    SliverToBoxAdapter(
                      child: PosterRow(
                        label: context.localized.nextUp,
                        posters: dashboardData.nextUp,
                      ),
                    ),
                  if ([...allResume, ...dashboardData.nextUp].isNotEmpty && homeSettings.nextUp == HomeNextUp.combined)
                    SliverToBoxAdapter(
                      child: PosterRow(
                        label: context.localized.dashboardContinue,
                        posters: [...allResume, ...dashboardData.nextUp],
                      ),
                    ),
                  ...views.dashboardViews
                      .where((element) => element.recentlyAdded.isNotEmpty)
                      .map((view) => SliverToBoxAdapter(
                            child: PosterRow(
                              label: context.localized.dashboardRecentlyAdded(view.name),
                              onLabelClick: () => context.router.push(LibrarySearchRoute(
                                viewModelId: view.id,
                                sortingOptions: switch (view.collectionType) {
                                  CollectionType.tvshows ||
                                  CollectionType.books ||
                                  CollectionType.boxsets ||
                                  CollectionType.folders ||
                                  CollectionType.music =>
                                    SortingOptions.dateLastContentAdded,
                                  _ => SortingOptions.dateAdded,
                                },
                                sortOrder: SortingOrder.descending,
                              )),
                              posters: view.recentlyAdded,
                            ),
                          )),
                ].whereNotNull().toList().addInBetween(const SliverToBoxAdapter(child: SizedBox(height: 16))),
                const DefautlSliverBottomPadding(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
