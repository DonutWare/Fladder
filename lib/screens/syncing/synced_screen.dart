import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/screens/syncing/sync_list_item.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class SyncedScreen extends ConsumerStatefulWidget {
  const SyncedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SyncedScreenState();
}

class _SyncedScreenState extends ConsumerState<SyncedScreen> {
  @override
  Widget build(BuildContext context) {
    final items = ref.watch(syncProvider.select((value) => value.items));
    final padding = AdaptiveLayout.adaptivePadding(context);

    return PullToRefresh(
      refreshOnStart: true,
      onRefresh: () => ref.read(syncProvider.notifier).refresh(),
      child: NestedScaffold(
        background: BackgroundImage(images: items.map((value) => value.images).nonNulls.toList()),
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: AdaptiveLayout.scrollOf(context, HomeTabs.sync),
          slivers: [
            if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
              NestedSliverAppBar(
                parent: context,
                route: LibrarySearchRoute(),
              )
            else
              const DefaultSliverTopBadding(),
            if (kDebugMode)
              SliverToBoxAdapter(
                child: Padding(
                  padding: padding,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: () => ref.read(syncProvider.notifier).viewDatabase(context),
                        child: const Text("View Database"),
                      ),
                      ElevatedButton(
                        onPressed: () => ref.read(syncProvider.notifier).removeAllSyncedData(),
                        child: const Text("Clear drift database"),
                      ),
                    ],
                  ),
                ),
              ),
            if (items.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: padding,
                  child: Text(
                    context.localized.syncedItems,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              SliverPadding(
                padding: padding,
                sliver: SliverList.builder(
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return FocusProvider(
                      autoFocus: index == 0,
                      child: SyncListItem(syncedItem: item),
                    );
                  },
                  itemCount: items.length,
                ),
              ),
            ] else ...[
              SliverFillRemaining(
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
                      IconsaxPlusLinear.cloud_cross,
                    )
                  ],
                ),
              )
            ],
            const DefautlSliverBottomPadding(),
          ],
        ),
      ),
    );
  }
}
