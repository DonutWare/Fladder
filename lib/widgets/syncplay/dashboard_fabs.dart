import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/syncplay/syncplay_group_sheet.dart';

/// Combined FAB for dashboard with search and SyncPlay actions
class DashboardFabs extends ConsumerWidget {
  const DashboardFabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);
    final isDualLayout = AdaptiveLayout.of(context).layoutMode == LayoutMode.dual;

    final children = [
      // SyncPlay FAB
      _SyncPlayFabButton(isActive: isActive),
      // Search FAB
      AdaptiveFab(
        context: context,
        title: context.localized.search,
        key: const Key('dashboard_search'),
        onPressed: () => context.router.navigate(LibrarySearchRoute()),
        child: const Icon(IconsaxPlusLinear.search_normal_1),
      ).normal,
    ];

    return isDualLayout
        ? Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: children,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: children,
          );
  }
}

class _SyncPlayFabButton extends StatelessWidget {
  final bool isActive;

  const _SyncPlayFabButton({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'syncplay_fab',
      child: IconButton.filledTonal(
        iconSize: 26,
        tooltip: 'SyncPlay',
        onPressed: () => _showSyncPlaySheet(context),
        style: IconButton.styleFrom(
          backgroundColor: isActive ? Theme.of(context).colorScheme.primaryContainer : null,
        ),
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Icon(
                isActive ? IconsaxPlusBold.people : IconsaxPlusLinear.people,
              ),
              if (isActive)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSyncPlaySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SyncPlayGroupSheet(),
    );
  }
}
