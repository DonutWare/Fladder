import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/util/list_padding.dart';

///This is a wrapper widget for marking a synced item as deleted (while it is being deleted)
class SyncMarkedForDelete extends ConsumerWidget {
  final SyncedItem syncedItem;
  final Widget child;
  const SyncMarkedForDelete({required this.syncedItem, required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        if (syncedItem.markedForDelete)
          Positioned.fill(
            child: Card(
              elevation: 0,
              semanticContainer: false,
              color: Colors.black.withOpacity(0.6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.error),
                  ),
                  const Text("Deleting"),
                  const Icon(IconsaxOutline.trash)
                ].addPadding(const EdgeInsets.symmetric(horizontal: 16)),
              ),
            ),
          )
      ],
    );
  }
}
