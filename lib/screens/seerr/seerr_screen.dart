import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_dashboard_provider.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/seerr/widgets/seerr_poster_row.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_banner_row.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class SeerrScreen extends ConsumerStatefulWidget {
  const SeerrScreen({super.key});

  @override
  ConsumerState<SeerrScreen> createState() => _SeerrScreenState();
}

class _SeerrScreenState extends ConsumerState<SeerrScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(seerrDashboardProvider.notifier).fetchDashboard();
    });
  }

  Future<void> openRequest(BuildContext context, SeerrDashboardPosterModel poster) async {
    await openSeerrRequestPopup(context, poster);
    await ref.read(seerrDashboardProvider.notifier).fetchDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final padding = AdaptiveLayout.adaptivePadding(context);
    final dashboardState = ref.watch(seerrDashboardProvider);
    final canViewRecent = ref.watch(seerrUserProvider.select((state) => state?.canViewRecent ?? false));
    final backgroundImages = [
      ...dashboardState.recentlyAdded,
      ...dashboardState.recentRequests,
      ...dashboardState.trending,
      ...dashboardState.popularMovies,
      ...dashboardState.popularSeries,
      ...dashboardState.expectedMovies,
      ...dashboardState.expectedSeries,
    ].map((e) => e.images).toList(growable: false);

    return MediaQuery.removeViewInsets(
      context: context,
      child: NestedScaffold(
        background: BackgroundImage(
          images: backgroundImages,
        ),
        body: PullToRefresh(
          onRefresh: () => ref.read(seerrDashboardProvider.notifier).fetchDashboard(),
          child: (context) => CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: AdaptiveLayout.scrollOf(context, HomeTabs.seerr),
            slivers: [
              if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
                NestedSliverAppBar(parent: context)
              else
                const DefaultSliverTopBadding(),
              if (canViewRecent && dashboardState.recentlyAdded.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.recentlyAdded,
                    posters: dashboardState.recentlyAdded,
                    contentPadding: padding,
                  ),
                ),
              if (dashboardState.recentRequests.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrRequestBannerRow(
                    label: context.localized.recentRequests,
                    posters: dashboardState.recentRequests,
                    contentPadding: padding,
                    onRequestAddTap: (poster) => openRequest(context, poster),
                  ),
                ),
              if (dashboardState.trending.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.trending,
                    posters: dashboardState.trending,
                    contentPadding: padding,
                    onLabelClick: () => context.pushRoute(SeerrSearchRoute(mode: SeerrSearchMode.trending)),
                  ),
                ),
              if (dashboardState.popularMovies.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.popularMovies,
                    posters: dashboardState.popularMovies,
                    contentPadding: padding,
                    onLabelClick: () => context.pushRoute(SeerrSearchRoute(mode: SeerrSearchMode.discoverMovies)),
                  ),
                ),
              if (dashboardState.popularSeries.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.popularSeries,
                    posters: dashboardState.popularSeries,
                    contentPadding: padding,
                    onLabelClick: () => context.pushRoute(SeerrSearchRoute(mode: SeerrSearchMode.discoverTv)),
                  ),
                ),
              if (dashboardState.expectedMovies.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.expectedMovies,
                    posters: dashboardState.expectedMovies,
                    contentPadding: padding,
                    onLabelClick: () => context.pushRoute(
                      SeerrSearchRoute(
                        mode: SeerrSearchMode.discoverMovies,
                        yearGte: DateTime.now().year,
                      ),
                    ),
                  ),
                ),
              if (dashboardState.expectedSeries.isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.expectedSeries,
                    posters: dashboardState.expectedSeries,
                    contentPadding: padding,
                    onLabelClick: () => context.pushRoute(
                      SeerrSearchRoute(
                        mode: SeerrSearchMode.discoverTv,
                        yearGte: DateTime.now().year,
                      ),
                    ),
                  ),
                ),
              const DefautlSliverBottomPadding(),
            ],
          ),
        ),
      ),
    );
  }
}
