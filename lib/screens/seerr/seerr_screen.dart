import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/providers/seerr_browse_provider.dart';
import 'package:fladder/providers/seerr_dashboard_provider.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/seerr/seerr_poster_row.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class SeerrScreen extends ConsumerStatefulWidget {
  const SeerrScreen({super.key});

  @override
  ConsumerState<SeerrScreen> createState() => _SeerrScreenState();
}

class _SeerrScreenState extends ConsumerState<SeerrScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(seerrDashboardProvider.notifier).fetchDashboard();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = AdaptiveLayout.adaptivePadding(context);
    final searchState = ref.watch(seerrSearchProvider);
    final query = searchState.query;
    final dashboardState = ref.watch(seerrDashboardProvider);

    ref.listen(
      seerrSearchProvider.select((value) => value.query),
      (previous, next) {
        if (_controller.text != next) {
          _controller.text = next;
        }
      },
    );

    final searchResults = searchState.results;
    final searchPosters = searchResults.map((e) => e.poster).toList(growable: false);

    final backgroundImages = query.trim().isNotEmpty
        ? searchPosters.map((e) => e.images).toList(growable: false)
        : dashboardState.recentlyAdded.map((e) => e.images).toList(growable: false);

    return MediaQuery.removeViewInsets(
      context: context,
      child: NestedScaffold(
        background: BackgroundImage(
          images: backgroundImages,
        ),
        body: PullToRefresh(
          onRefresh: () => ref.read(seerrDashboardProvider.notifier).fetchDashboard(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: AdaptiveLayout.scrollOf(context, HomeTabs.seerr),
            slivers: [
              if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
                NestedSliverAppBar(parent: context)
              else
                const DefaultSliverTopBadding(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      Builder(builder: (context) {
                        return IconButton(
                          onPressed: () => context.refreshData(),
                          icon: const Icon(IconsaxPlusLinear.menu_1),
                        );
                      }),
                      Expanded(
                        child: OutlinedTextField(
                          autoFocus: true,
                          controller: _controller,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => ref.read(seerrSearchProvider.notifier).submit(value),
                          decoration: InputDecoration(
                            hintText: "${context.localized.search}...",
                            contentPadding: const EdgeInsets.only(top: 13),
                            suffixIcon: IconButton(
                              onPressed: () => ref.read(seerrSearchProvider.notifier).submit(_controller.text),
                              icon: const Icon(IconsaxPlusLinear.search_status),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      searchState.isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              if (query.trim().isNotEmpty)
                SliverToBoxAdapter(
                  child: SeerrPosterRow(
                    label: context.localized.search,
                    posters: searchPosters,
                    contentPadding: padding,
                  ),
                ),
              if (query.trim().isEmpty) ...[
                if (dashboardState.recentlyAdded.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: 'Recently added',
                      posters: dashboardState.recentlyAdded,
                      contentPadding: padding,
                      onTap: (poster) async {
                        final jellyfinId = poster.jellyfinItemId;
                        if (jellyfinId == null || jellyfinId.trim().isEmpty) return;

                        final item = ItemBaseModel(
                          name: poster.title,
                          id: jellyfinId,
                          overview: const OverviewModel(),
                          parentId: null,
                          playlistId: null,
                          images: null,
                          childCount: null,
                          primaryRatio: null,
                          userData: const UserData(),
                          canDownload: null,
                          canDelete: null,
                          jellyType: dto.BaseItemKind.movie,
                        );

                        await item.navigateTo(context);
                      },
                    ),
                  ),
                if (dashboardState.recentRequests.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: 'Recent Requests',
                      posters: dashboardState.recentRequests,
                      contentPadding: padding,
                    ),
                  ),
                if (dashboardState.trending.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: 'Trending',
                      posters: dashboardState.trending,
                      contentPadding: padding,
                    ),
                  ),
                if (dashboardState.popularMovies.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: 'Popular Movies',
                      posters: dashboardState.popularMovies,
                      contentPadding: padding,
                    ),
                  ),
                if (dashboardState.expectedMovies.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: 'Expected movies',
                      posters: dashboardState.expectedMovies,
                      contentPadding: padding,
                    ),
                  ),
                if (dashboardState.expectedSeries.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: 'Expected series',
                      posters: dashboardState.expectedSeries,
                      contentPadding: padding,
                    ),
                  ),
              ],
              const DefautlSliverBottomPadding(),
            ],
          ),
        ),
      ),
    );
  }
}
