import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/favourites_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/poster_size_slider.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouritesProvider);
    final padding = AdaptiveLayout.adaptivePadding(context);

    return PullToRefresh(
      onRefresh: () async => await ref.read(favouritesProvider.notifier).fetchFavourites(),
      child: NestedScaffold(
        background: BackgroundImage(items: favourites.favourites.values.expand((element) => element).toList()),
        body: PinchPosterZoom(
          scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference / 2),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: AdaptiveLayout.scrollOf(context),
            slivers: [
              if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
                NestedSliverAppBar(
                  searchTitle: "${context.localized.search} ${context.localized.favorites.toLowerCase()}...",
                  parent: context,
                  route: LibrarySearchRoute(favourites: true),
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
                      child: PosterRow(
                        contentPadding: padding,
                        label: e.key.label(context),
                        posters: e.value,
                      ),
                    ),
                  ),
              if (favourites.people.isNotEmpty)
                SliverToBoxAdapter(
                  child: PosterRow(
                    contentPadding: padding,
                    label: context.localized.actor(favourites.people.length),
                    posters: favourites.people,
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
