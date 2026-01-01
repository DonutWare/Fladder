import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_browse_provider.dart';
import 'package:fladder/providers/seerr_dashboard_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/seerr/widgets/seerr_poster_card.dart';
import 'package:fladder/screens/seerr/widgets/seerr_poster_row.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/grid_focus_traveler.dart';
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

  Future<void> openRequest(BuildContext context, SeerrDashboardPosterModel poster) async {
    await openSeerrRequestPopup(context, poster);
    await ref.read(seerrDashboardProvider.notifier).fetchDashboard();
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

    final backgroundImages = query.trim().isNotEmpty
        ? searchResults.map((e) => e.images).toList(growable: false)
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
              if (query.trim().isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverPadding(
                  padding: padding.add(const EdgeInsets.symmetric(horizontal: 8)),
                  sliver: Builder(
                    builder: (context) {
                      final posterSize = MediaQuery.sizeOf(context).width /
                          (AdaptiveLayout.poster(context).gridRatio *
                              ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
                      final width = MediaQuery.of(context).size.width;
                      final cellWidth = (width / posterSize).floorToDouble();
                      final crossAxisCount = ((width / cellWidth).floor()).clamp(2, 10);

                      return GridFocusTraveler(
                        itemCount: searchResults.length,
                        crossAxisCount: crossAxisCount,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.55,
                        ),
                        itemBuilder: (context, selectedIndex, index) {
                          final poster = searchResults[index];
                          return SeerrPosterCard(
                            key: Key(poster.id),
                            poster: poster,
                            onTap: (poster) => openRequest(context, poster),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
              if (query.trim().isEmpty) ...[
                if (dashboardState.recentlyAdded.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: context.localized.recentlyAdded,
                      posters: dashboardState.recentlyAdded,
                      contentPadding: padding,
                      onRequestAddTap: (poster) => openRequest(context, poster),
                    ),
                  ),
                if (dashboardState.recentRequests.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
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
                      onRequestAddTap: (poster) => openRequest(context, poster),
                    ),
                  ),
                if (dashboardState.popularMovies.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: context.localized.popularMovies,
                      posters: dashboardState.popularMovies,
                      contentPadding: padding,
                      onRequestAddTap: (poster) => openRequest(context, poster),
                    ),
                  ),
                if (dashboardState.expectedMovies.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: context.localized.expectedMovies,
                      posters: dashboardState.expectedMovies,
                      contentPadding: padding,
                      onRequestAddTap: (poster) => openRequest(context, poster),
                    ),
                  ),
                if (dashboardState.expectedSeries.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SeerrPosterRow(
                      label: context.localized.expectedSeries,
                      posters: dashboardState.expectedSeries,
                      contentPadding: padding,
                      onRequestAddTap: (poster) => openRequest(context, poster),
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
