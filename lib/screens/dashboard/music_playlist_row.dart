import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/sticky_header_text.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class MusicPlaylistRow extends ConsumerWidget {
  const MusicPlaylistRow({
    required this.playlists,
    required this.label,
    required this.onPlaylistPlayTap,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });

  final List<PlaylistModel> playlists;
  final String label;
  final Future<void> Function(PlaylistModel playlist) onPlaylistPlayTap;
  final EdgeInsets contentPadding;

  int _columnsForSize(ViewSize size) {
    return switch (size) {
      ViewSize.phone => 2,
      ViewSize.tablet => 3,
      ViewSize.desktop || ViewSize.television => 4,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewSize = AdaptiveLayout.viewSizeOf(context);
    final columns = _columnsForSize(viewSize);
    final horizontalPadding = contentPadding.copyWith(top: 0, bottom: 0);
    const crossAxisSpacing = 12.0;
    const mainAxisSpacing = 12.0;
    const rowHeight = 90.0;
    final rowCount = (playlists.length / columns).ceil();
    final gridHeight = rowCount == 0 ? 0.0 : (rowCount * rowHeight) + ((rowCount - 1) * mainAxisSpacing);

    void showBottomSheet(BuildContext context, WidgetRef ref, ItemBaseModel playlist) {
      showBottomSheetPill(
        context: context,
        item: playlist,
        content: (scrollContext, scrollController) => ListView(
          shrinkWrap: true,
          controller: scrollController,
          children: playlist
              .generateActions(
                context,
                ref,
              )
              .listTileItems(scrollContext, useIcons: true),
        ),
      );
    }

    Future<void> showContextMenu(BuildContext context, WidgetRef ref, Offset globalPos, ItemBaseModel playlist) async {
      final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
      await showMenu(
        context: context,
        position: position,
        items: playlist
            .generateActions(
              context,
              ref,
            )
            .popupMenuItems(useIcons: true),
      );
    }

    return Padding(
      padding: horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Flexible(
            child: StickyHeaderText(
              label: label,
            ),
          ),
          SizedBox(
            height: gridHeight,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: playlists.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                mainAxisExtent: rowHeight,
              ),
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return FocusButton(
                  onTap: () => playlist.navigateTo(context),
                  onFocusChanged: (focused) {
                    if (focused) {
                      context.ensureVisible();
                    }
                  },
                  onLongPress: () => showBottomSheet(context, ref, playlist),
                  onSecondaryTapDown: (globalPos) => showContextMenu(context, ref, globalPos.localPosition, playlist),
                  borderRadius: FladderTheme.smallShape.borderRadius,
                  overlays: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: FocusButton(
                              onTap: () => onPlaylistPlayTap(playlist),
                              onFocusChanged: (focused) {
                                if (focused) {
                                  context.ensureVisible();
                                }
                              },
                              borderRadius: FladderTheme.smallShape.borderRadius,
                              focusedOverlays: [
                                Align(
                                  alignment: Alignment.center,
                                  child: IconButton.filledTonal(
                                    onPressed: () => onPlaylistPlayTap(playlist),
                                    icon: const Icon(
                                      IconsaxPlusBold.play,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                              child: ClipRRect(
                                borderRadius: FladderTheme.smallShape.borderRadius,
                                child: FladderImage(
                                  image: playlist.images?.primary,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox.expand(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  playlist.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: FladderTheme.smallShape.borderRadius,
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
