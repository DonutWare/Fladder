import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/media/item_detail_list_widget.dart';
import 'package:fladder/util/widget_extensions.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      return Dialog.fullscreen(
        child: VideoPlayerQueue(
          items: items,
          currentItem: currentItem,
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
    return Scaffold(
      appBar: const FladderAppBar(
        label: "",
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Row(
              children: [
                const BackButton(),
                Column(
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
              ],
            ),
          ),
          const Divider(),
          Flexible(
            child: ReorderableListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 64).copyWith(bottom: 64),
              scrollController: controller,
              itemCount: items.length,
              proxyDecorator: (child, index, animation) {
                return child;
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final ItemBaseModel item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);
                });
                // ref.read(videoPlaybackProvider.notifier).setQueue(items);
              },
              itemBuilder: (context, index) {
                final item = items[index];
                final isCurrentItem = item.id == (widget.currentItem?.id ?? "");
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 125,
                    child: ItemDetailListWidget(
                      item: item,
                      elevation: isCurrentItem ? 50 : 1,
                      iconOverlay: !isCurrentItem
                          ? IconButton(
                              onPressed: () {
                                widget.playSelected?.call(item);
                                Navigator.of(context).pop();
                              },
                              iconSize: 80,
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                              ),
                            )
                          : const IconButton(
                              onPressed: null,
                              iconSize: 80,
                              icon: Icon(Icons.play_arrow_rounded),
                            ),
                      actions: [
                        if (!isCurrentItem)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                items.remove(item);
                              });
                              // ref.read(videoPlaybackProvider.notifier).setQueue(items);
                            },
                            icon: const Icon(
                              Icons.delete_rounded,
                            ),
                          )
                      ],
                    ),
                  ),
                ).setKey(
                  Key('$index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
