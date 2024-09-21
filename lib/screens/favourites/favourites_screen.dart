import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/build_routes/home_routes.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/poster_size_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/favourites_provider.dart';
import 'package:fladder/screens/shared/media/poster_grid.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

class FavouritesScreen extends ConsumerWidget {
  final ScrollController navigationScrollController;

  const FavouritesScreen({required this.navigationScrollController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouritesProvider);

    return PullToRefresh(
      onRefresh: () async => await ref.read(favouritesProvider.notifier).fetchFavourites(),
      child: NestedScaffold(
        body: PinchPosterZoom(
          scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference / 2),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: navigationScrollController,
            slivers: [
              if (AdaptiveLayout.of(context).layout == LayoutState.phone)
                NestedSliverAppBar(
                  searchTitle: "${context.localized.search} ${context.localized.favorites.toLowerCase()}...",
                  parent: context,
                  route: LibrarySearchRoute(favorites: true),
                )
              else
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
              ...favourites.favourites.entries.where((element) => element.value.isNotEmpty).map(
                    (e) => SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PosterGrid(
                          stickyHeader: true,
                          name: e.key.label(context),
                          posters: e.value,
                        ),
                      ),
                    ),
                  ),
              if (favourites.people.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PosterGrid(
                      stickyHeader: true,
                      name: "People",
                      posters: favourites.people,
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
