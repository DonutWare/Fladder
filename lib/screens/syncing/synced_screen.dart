import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/screens/syncing/sync_list_item.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class SyncedScreen extends ConsumerStatefulWidget {
  final ScrollController? navigationScrollController;

  const SyncedScreen({this.navigationScrollController, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SyncedScreenState();
}

class _SyncedScreenState extends ConsumerState<SyncedScreen> {
  @override
  Widget build(BuildContext context) {
    final items = ref.watch(syncProvider.select((value) => value.items));
    return PullToRefresh(
      refreshOnStart: true,
      onRefresh: () => ref.read(syncProvider.notifier).refresh(),
      child: NestedScaffold(
        body: PinchPosterZoom(
          scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference / 2),
          child: items.isNotEmpty
              ? CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: widget.navigationScrollController,
                  slivers: [
                    if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
                      NestedSliverAppBar(
                        searchTitle: "${context.localized.search} ...",
                        parent: context,
                        route: LibrarySearchRoute(),
                      )
                    else
                      const DefaultSliverTopBadding(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          context.localized.syncedItems,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList.builder(
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return SyncListItem(syncedItem: item);
                        },
                        itemCount: items.length,
                      ),
                    ),
                    const DefautlSliverBottomPadding(),
                  ],
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.localized.noItemsSynced,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        IconsaxOutline.cloud_cross,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
