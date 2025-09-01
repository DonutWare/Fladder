import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/items/folder_details_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/media/poster_grid.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

class FolderDetailScreen extends ConsumerWidget {
  final ItemBaseModel item;
  const FolderDetailScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerInstance = folderDetailsProvider(item.id);
    final details = ref.watch(providerInstance);

    return PullToRefresh(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          details?.name ?? "",
        )),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PosterGrid(
                posters: details?.items ?? [],
                onPressed: (action, item) async {
                  switch (item) {
                    case PhotoModel photoModel:
                      final photoItems = details?.items.whereType<PhotoModel>().toList();
                      await context.pushRoute(PhotoViewerRoute(
                        items: photoItems,
                        selected: photoModel.id,
                      ));
                      break;
                    default:
                      if (context.mounted) {
                        await item.navigateTo(context);
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
      onRefresh: () async {
        await ref.read(providerInstance.notifier).fetchDetails(item.id);
      },
    );
  }
}
