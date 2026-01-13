import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/syncplay/syncplay_utils.dart';

/// FAB for accessing SyncPlay from the home screen
class SyncPlayFab extends ConsumerWidget {
  const SyncPlayFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);

    return AdaptiveFab(
      context: context,
      title: isActive ? context.localized.syncPlay : 'SyncPlay',
      heroTag: 'syncplay_fab',
      backgroundColor: isActive ? Theme.of(context).colorScheme.primaryContainer : null,
      onPressed: () => showSyncPlaySheet(context),
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
    ).normal;
  }
}
