import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/models/playback/playback_queue_state.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

typedef QueueSectionReorderCallback = Future<void> Function(
  AudioQueueSection section,
  int oldIndex,
  int newIndex,
);

void showFullScreenItemQueue(
  BuildContext context, {
  required List<ItemBaseModel> items,
  QueueSectionReorderCallback? onSectionReorder,
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
          onSectionReorder: onSectionReorder,
          playSelected: playSelected,
        ),
      );
    },
  );
}

class VideoPlayerQueue extends ConsumerWidget {
  final List<ItemBaseModel> items;
  final ItemBaseModel? currentItem;
  final Function(ItemBaseModel)? playSelected;
  final QueueSectionReorderCallback? onSectionReorder;

  const VideoPlayerQueue({super.key, required this.items, this.currentItem, this.playSelected, this.onSectionReorder});

  void _onItemTapped(BuildContext context, WidgetRef ref, ItemBaseModel item) {
    if (playSelected != null) {
      playSelected!(item);
    } else {
      ref.read(videoPlayerProvider.notifier).playAudioQueueItem(item);
    }
    context.maybePop();
  }

  Future<void> _showItemActionsMenu(
    BuildContext context,
    WidgetRef ref,
    ItemBaseModel item,
    Offset globalPosition, {
    required Future<void> Function() removeAction,
  }) async {
    final itemActions = item.generateActions(
      context,
      ref,
      exclude: {
        ItemActions.play,
        ItemActions.refreshMetaData,
      },
    );

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        globalPosition.dx,
        globalPosition.dy,
      ),
      items: [
        ItemActionButton(
          label: Text(context.localized.removeFromQueue),
          icon: const Icon(IconsaxPlusLinear.minus_cirlce),
          action: removeAction,
        ),
        ...itemActions,
      ].popupMenuItems(useIcons: true),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackInfo = ref.watch(mediaPlaybackProvider);
    final player = ref.watch(videoPlayerProvider);

    final shouldWrap = playbackInfo.repeatMode == AudioRepeatMode.all;
    final providerItems = player.audioQueueForDisplay(wrapAround: shouldWrap);
    final items = providerItems.isNotEmpty ? providerItems : this.items;
    final tempStart = player.temporaryQueueStartInDisplay(wrapAround: shouldWrap);
    final tempCount = player.temporaryQueueCountInDisplay() ?? 0;

    final nowPlaying = items.firstOrNull;

    final nextUpItems = <ItemBaseModel>[];
    final existingItems = <ItemBaseModel>[];
    if (items.isNotEmpty) {
      final tempEnd = tempStart != null ? tempStart + tempCount : -1;
      for (var i = 1; i < items.length; i++) {
        final isNextUp = tempStart != null && tempCount > 0 && i >= tempStart && i < tempEnd;
        if (isNextUp) {
          nextUpItems.add(items[i]);
        } else {
          existingItems.add(items[i]);
        }
      }
    }

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
                      context.localized.queue,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        context.localized.queueItemCount(items.length),
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
              height: MediaQuery.sizeOf(context).height * 0.85,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 24),
                children: [
                  if (nowPlaying != null) ...[
                    _QueueSectionHeader(
                      icon: Icons.play_arrow_rounded,
                      title: context.localized.nowPlaying,
                    ),
                    _QueueTile(
                      item: nowPlaying,
                      isCurrent: true,
                      dragIndex: null,
                      onTap: () => _onItemTapped(context, ref, nowPlaying),
                      onShowActions: (globalPosition) => _showItemActionsMenu(
                        context,
                        ref,
                        nowPlaying,
                        globalPosition,
                        removeAction: () => ref.read(videoPlayerProvider.notifier).removeAudioQueueItem(nowPlaying),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (nextUpItems.isNotEmpty) ...[
                    _QueueSectionHeader(
                      icon: Icons.playlist_add_rounded,
                      title: context.localized.upNext,
                      trailing: IconButton(
                        tooltip: context.localized.clear,
                        onPressed: () async {
                          await ref.read(videoPlayerProvider.notifier).clearTemporaryQueue();
                        },
                        icon: const Icon(Icons.clear_all_rounded),
                      ),
                    ),
                    _QueueSortList(
                      items: nextUpItems,
                      onReorder: (oldIndex, newIndex) {
                        if (onSectionReorder != null) {
                          onSectionReorder!(AudioQueueSection.nextUp, oldIndex, newIndex);
                        }
                      },
                      onTapItem: (item) => _onItemTapped(context, ref, item),
                      onShowItemActions: (index, item, globalPosition) => _showItemActionsMenu(
                        context,
                        ref,
                        item,
                        globalPosition,
                        removeAction: () => ref.read(videoPlayerProvider.notifier).removeAudioQueueSectionItem(
                              AudioQueueSection.nextUp,
                              index,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  _QueueSectionHeader(
                    icon: Icons.queue_music_rounded,
                    title: context.localized.queue,
                  ),
                  if (existingItems.isEmpty)
                    Opacity(
                      opacity: 0.6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          context.localized.queueIsEmpty,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  else
                    _QueueSortList(
                      items: existingItems,
                      onReorder: (oldIndex, newIndex) {
                        if (onSectionReorder != null) {
                          onSectionReorder!(AudioQueueSection.existing, oldIndex, newIndex);
                        }
                      },
                      onTapItem: (item) => _onItemTapped(context, ref, item),
                      onShowItemActions: (index, item, globalPosition) => _showItemActionsMenu(
                        context,
                        ref,
                        item,
                        globalPosition,
                        removeAction: () => ref.read(videoPlayerProvider.notifier).removeAudioQueueSectionItem(
                              AudioQueueSection.existing,
                              index,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  const _QueueSectionHeader({required this.icon, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
            ),
          ),
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: trailing!,
            ),
        ],
      ),
    );
  }
}

class _QueueSortList extends StatelessWidget {
  final List<ItemBaseModel> items;
  final void Function(int oldIndex, int newIndex) onReorder;
  final ValueChanged<ItemBaseModel> onTapItem;
  final void Function(int index, ItemBaseModel item, Offset globalPosition) onShowItemActions;

  const _QueueSortList({
    required this.items,
    required this.onReorder,
    required this.onTapItem,
    required this.onShowItemActions,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: items.length,
      onReorder: onReorder,
      itemBuilder: (context, index) {
        return _QueueTile(
          key: ValueKey('${items[index].id}-$index'),
          item: items[index],
          dragIndex: index,
          onTap: () => onTapItem(items[index]),
          onShowActions: (globalPosition) => onShowItemActions(index, items[index], globalPosition),
        );
      },
    );
  }
}

class _QueueTile extends StatelessWidget {
  final ItemBaseModel item;
  final VoidCallback onTap;
  final ValueChanged<Offset> onShowActions;
  final bool isCurrent;
  final int? dragIndex;

  const _QueueTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onShowActions,
    this.isCurrent = false,
    required this.dragIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) => onShowActions(details.globalPosition),
      onLongPressStart: (details) => onShowActions(details.globalPosition),
      child: ListTile(
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
        subtitle: Text(
          item.subTextShort(context.localized) ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: dragIndex == null
            ? Icon(Icons.play_arrow_rounded, color: Theme.of(context).colorScheme.primary)
            : ReorderableDragStartListener(
                index: dragIndex!,
                child: const Icon(Icons.drag_indicator_rounded),
              ),
        onTap: onTap,
      ),
    );
  }
}
