import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/video_player_provider.dart';

void showFullScreenItemQueue(
  BuildContext context, {
  required List<ItemBaseModel> items,
  ValueChanged<List<ItemBaseModel>>? onListChanged,
  Function(ItemBaseModel itemStreamModel)? playSelected,
  ItemBaseModel? currentItem,
}) {
  showDialog(
    useSafeArea: false,
    useRootNavigator: true,
    context: context,
    builder: (context) {
      return Dialog(
        child: VideoPlayerQueue(
          items: items,
          currentItem: currentItem,
          onListChanged: onListChanged,
          playSelected: playSelected,
        ),
      );
    },
  );
}

class VideoPlayerQueue extends ConsumerStatefulWidget {
  final List<ItemBaseModel> items;
  final ItemBaseModel? currentItem;
  final Function(ItemBaseModel)? playSelected;
  final ValueChanged<List<ItemBaseModel>>? onListChanged;

  const VideoPlayerQueue({super.key, required this.items, this.currentItem, this.playSelected, this.onListChanged});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerQueueState();
}

class _VideoPlayerQueueState extends ConsumerState<VideoPlayerQueue> {
  late final List<ItemBaseModel> items = widget.items;
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Queue",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        "${items.length} items",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.maybePop();
                },
                icon: const Icon(IconsaxPlusBold.close_circle),
              ),
            ],
          ),
          const Divider(),
          Flexible(
            child: SizedBox(
              height: 512,
              width: 512,
              child: ReorderableListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 64).copyWith(bottom: 64),
                scrollController: controller,
                itemCount: items.length,
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final ItemBaseModel item = items.removeAt(oldIndex);
                    items.insert(newIndex, item);
                  });
                  ref.read(videoPlayerProvider.notifier).reorderAudioQueue(items);
                },
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isCurrentItem = item.id == (widget.currentItem?.id ?? "");
                  return Padding(
                    key: Key(item.id),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 125,
                      width: 250,
                      child: Column(
                        children: [
                          Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: isCurrentItem ? FontWeight.bold : null,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
