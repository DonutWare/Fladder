import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';

void showAudioQueueDialog(
  BuildContext context, {
  required ValueChanged<List<ItemBaseModel>> onListChanged,
  required Function(ItemBaseModel item) playSelected,
}) {
  showDialog(
    useSafeArea: false,
    useRootNavigator: true,
    context: context,
    builder: (context) {
      return Dialog(
        child: AudioQueueDialog(
          onListChanged: onListChanged,
          playSelected: playSelected,
        ),
      );
    },
  );
}

class AudioQueueDialog extends ConsumerWidget {
  final ValueChanged<List<ItemBaseModel>> onListChanged;
  final Function(ItemBaseModel item) playSelected;

  const AudioQueueDialog({
    super.key,
    required this.onListChanged,
    required this.playSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackInfo = ref.watch(mediaPlaybackProvider);
    final currentModel = ref.watch(playBackModel);
    final player = ref.watch(videoPlayerProvider);

    final shouldWrap = playbackInfo.repeatMode == AudioRepeatMode.all;
    final items = player.audioQueueForDisplay(wrapAround: shouldWrap);
    final currentItem = currentModel?.item;

    return _AudioQueueDialogBody(
      items: items,
      currentItem: currentItem,
      onListChanged: onListChanged,
      playSelected: playSelected,
    );
  }
}

class _AudioQueueDialogBody extends StatefulWidget {
  final List<ItemBaseModel> items;
  final ItemBaseModel? currentItem;
  final ValueChanged<List<ItemBaseModel>> onListChanged;
  final Function(ItemBaseModel item) playSelected;

  const _AudioQueueDialogBody({
    required this.items,
    required this.currentItem,
    required this.onListChanged,
    required this.playSelected,
  });

  @override
  State<_AudioQueueDialogBody> createState() => _AudioQueueDialogBodyState();
}

class _AudioQueueDialogBodyState extends State<_AudioQueueDialogBody> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final currentItem = widget.currentItem;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Queue',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        '${items.length} items',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.maybePop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const Divider(),
          Flexible(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.85,
              child: ReorderableListView.builder(
                shrinkWrap: true,
                buildDefaultDragHandles: false,
                padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 24),
                scrollController: _controller,
                itemCount: items.length,
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex == 0 || newIndex == 0) {
                    return;
                  }

                  final reordered = List<ItemBaseModel>.from(items);
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = reordered.removeAt(oldIndex);
                  reordered.insert(newIndex, item);

                  widget.onListChanged(reordered);
                },
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isCurrent = currentItem != null && item.id == currentItem.id;

                  return ListTile(
                    key: ValueKey(item.id),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    minLeadingWidth: 0,
                    leading: ClipOval(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: FladderImage(
                          image: item.images?.primary,
                          fit: BoxFit.cover,
                          placeHolder: const Center(child: Icon(Icons.music_note_rounded, size: 20)),
                          imageErrorBuilder: (context, error, stack) =>
                              const Center(child: Icon(Icons.music_note_rounded, size: 20)),
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: isCurrent ? FontWeight.bold : null,
                          ),
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isCurrent)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              'Now playing',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        Text(
                          item.subTextShort(context.localized) ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: isCurrent
                        ? Icon(Icons.play_arrow_rounded, color: Theme.of(context).colorScheme.primary)
                        : ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_indicator_rounded),
                          ),
                    onTap: () {
                      widget.playSelected(item);
                      context.maybePop();
                    },
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
