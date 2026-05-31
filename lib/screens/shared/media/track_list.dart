import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/screens/syncing/sync_button.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

typedef TrackTapCallback = void Function(AudioModel track);
typedef TrackArtistTapCallback = void Function(AudioModel track);
typedef TrackSecondaryTapCallback = void Function(AudioModel track, TapDownDetails details);

class TrackList extends ConsumerStatefulWidget {
  final String title;
  final bool enableSorting;
  final bool showHeader;
  final List<AudioModel> tracks;
  final int? maxTracks;
  final bool showAlbum;
  final bool showSyncStatus;
  final Function(AudioModel track)? onTrackPlayTap;
  final Function(AudioModel track)? onTrackTap;
  final Function(AudioModel track)? onTrackArtistTap;
  final Function(AudioModel track, TapDownDetails details)? onTrackSecondaryTap;
  final Function(List<AudioModel> selected)? onPlaySelected;
  final Function(List<AudioModel> selected)? onAddToQueueSelected;
  final EdgeInsets? padding;

  const TrackList({
    required this.title,
    this.enableSorting = true,
    this.showHeader = true,
    required this.tracks,
    this.maxTracks,
    this.showAlbum = true,
    this.showSyncStatus = false,
    this.onTrackPlayTap,
    this.onTrackTap,
    this.onTrackArtistTap,
    this.onTrackSecondaryTap,
    this.onPlaySelected,
    this.onAddToQueueSelected,
    this.padding,
    super.key,
  });

  @override
  ConsumerState<TrackList> createState() => _TrackListState();
}

const double _trackCellSpacing = 16;

enum _TrackSortColumn { position, title, album, plays, duration }

enum _TrackColumn {
  position(label: '#', width: 45, sortable: false, sortColumn: _TrackSortColumn.position, align: TextAlign.center),
  title(label: 'Title', flex: 4, sortable: true, sortColumn: _TrackSortColumn.title),
  album(label: 'Album', flex: 3, sortable: true, sortColumn: _TrackSortColumn.album),
  plays(label: 'Plays', width: 90, sortable: true, sortColumn: _TrackSortColumn.plays, align: TextAlign.end),
  duration(label: 'Duration', width: 80, sortable: true, sortColumn: _TrackSortColumn.duration, align: TextAlign.end),
  sync(label: '', width: 40, sortable: false),
  action(label: '', width: 40, sortable: false);

  final String label;
  final int? flex;
  final double? width;
  final bool sortable;
  final _TrackSortColumn? sortColumn;
  final TextAlign align;

  const _TrackColumn({
    required this.label,
    this.flex,
    this.width,
    required this.sortable,
    this.sortColumn,
    this.align = TextAlign.start,
  });
}

class _TrackListState extends ConsumerState<TrackList> {
  _TrackSortColumn? _sortColumn;
  bool _ascending = true;
  final Set<String> _selectedTrackIds = {};
  int? _lastSelectedIndex;

  bool get _selectionEnabled => widget.onPlaySelected != null || widget.onAddToQueueSelected != null;

  void _handleTrackTap(AudioModel track, int index) {
    final isShift = HardwareKeyboard.instance.isShiftPressed;
    final isCtrl = HardwareKeyboard.instance.isControlPressed || HardwareKeyboard.instance.isMetaPressed;

    setState(() {
      if (isShift && _lastSelectedIndex != null) {
        final tracks = _sortedTracks();
        final from = _lastSelectedIndex! < index ? _lastSelectedIndex! : index;
        final to = _lastSelectedIndex! > index ? _lastSelectedIndex! : index;
        for (var i = from; i <= to; i++) {
          _selectedTrackIds.add(tracks[i].id);
        }
      } else if (isCtrl) {
        if (_selectedTrackIds.contains(track.id)) {
          _selectedTrackIds.remove(track.id);
        } else {
          _selectedTrackIds.add(track.id);
        }
        _lastSelectedIndex = index;
      } else {
        _selectedTrackIds.clear();
        _selectedTrackIds.add(track.id);
        _lastSelectedIndex = index;
      }
    });
  }

  List<AudioModel> get _selectedTracks {
    final sorted = _sortedTracks();
    return sorted.where((t) => _selectedTrackIds.contains(t.id)).toList();
  }

  List<ItemAction> _buildTrackActions(BuildContext context, AudioModel track) {
    final overrideWithSelection =
        _selectionEnabled && _selectedTrackIds.isNotEmpty && _selectedTrackIds.contains(track.id);
    final baseActions = track.generateActions(
      context,
      ref,
      exclude: overrideWithSelection ? {ItemActions.play, ItemActions.addToQueue} : const {},
    );

    if (!overrideWithSelection) {
      return baseActions;
    }

    final selectedTracks = _selectedTracks;
    return [
      ItemActionButton(
        action: () => widget.onPlaySelected?.call(selectedTracks),
        icon: const Icon(IconsaxPlusLinear.play),
        label: Text(context.localized.playLabel),
      ),
      ItemActionButton(
        action: () => widget.onAddToQueueSelected?.call(selectedTracks),
        icon: const Icon(IconsaxPlusLinear.music_playlist),
        label: Text(context.localized.addToQueue),
      ),
      ...baseActions,
    ];
  }

  void _toggleSort(_TrackSortColumn column) {
    setState(() {
      if (_sortColumn == column) {
        _ascending = !_ascending;
      } else {
        _sortColumn = column;
        _ascending = true;
      }
    });
  }

  List<AudioModel> _sortedTracks() {
    final sorted = [...widget.tracks];

    if (_sortColumn == null) {
      return widget.maxTracks != null ? sorted.take(widget.maxTracks!).toList() : sorted;
    }

    sorted.sort((a, b) {
      int result;
      switch (_sortColumn!) {
        case _TrackSortColumn.position:
          result = (a.trackNumber ?? 0).compareTo(b.trackNumber ?? 0);
          break;
        case _TrackSortColumn.title:
          result = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case _TrackSortColumn.album:
          result = (a.album ?? '').toLowerCase().compareTo((b.album ?? '').toLowerCase());
          break;
        case _TrackSortColumn.plays:
          result = a.userData.playCount.compareTo(b.userData.playCount);
          break;
        case _TrackSortColumn.duration:
          result = (a.overview.runTime?.inSeconds ?? 0).compareTo(b.overview.runTime?.inSeconds ?? 0);
          break;
      }
      return _ascending ? result : -result;
    });

    return widget.maxTracks != null ? sorted.take(widget.maxTracks!).toList() : sorted;
  }

  Widget _buildHeaderLabel(BuildContext context, _TrackColumn column) {
    final active = column.sortable && _sortColumn == column.sortColumn;
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        );

    if (!column.sortable) {
      return Align(
        alignment: switch (column.align) {
          TextAlign.center => Alignment.center,
          TextAlign.end => Alignment.centerRight,
          _ => Alignment.centerLeft,
        },
        child: Text(column.label, style: style, textAlign: column.align),
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: widget.enableSorting
          ? () {
              if (column.sortColumn != null) {
                _toggleSort(column.sortColumn!);
              }
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: switch (column.align) {
          TextAlign.center => MainAxisAlignment.center,
          TextAlign.end => MainAxisAlignment.end,
          _ => MainAxisAlignment.start,
        },
        spacing: 4,
        children: [
          Flexible(
            child: Text(
              column.label,
              style: style,
              textAlign: column.align,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (active && widget.enableSorting) ...[
            Icon(
              _ascending ? IconsaxPlusLinear.arrow_up : IconsaxPlusLinear.arrow_down,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleTracks = _sortedTracks();
    final showCompactLayout = AdaptiveLayout.layoutModeOf(context) == LayoutMode.single;
    if (visibleTracks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title.isNotEmpty) Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              if (widget.showHeader) _buildHeaderRow(context),
              ...visibleTracks.mapIndexed(
                (index, track) => TableRow(
                  children: [
                    _TrackListItem(
                      index: widget.showAlbum ? index + 1 : track.trackNumber ?? index + 1,
                      track: track,
                      actions: _buildTrackActions(context, track),
                      onTap: _selectionEnabled ? (_) => _handleTrackTap(track, index) : widget.onTrackTap,
                      onTrackPlayTap: widget.onTrackPlayTap,
                      onArtistTap: widget.onTrackArtistTap,
                      onSecondaryTap: widget.onTrackSecondaryTap,
                      showAlbum: widget.showAlbum,
                      showSyncStatus: widget.showSyncStatus,
                      compactLayout: showCompactLayout,
                      isSelected: _selectionEnabled && _selectedTrackIds.contains(track.id),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildHeaderRow(BuildContext context) {
    final showCompactLayout = AdaptiveLayout.layoutModeOf(context) == LayoutMode.single;

    return TableRow(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12).add(const EdgeInsets.only(left: 4, right: 16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: _TrackColumn.position.width,
                child: _buildHeaderLabel(context, _TrackColumn.position),
              ),
              const SizedBox(width: _trackCellSpacing),
              Expanded(flex: _TrackColumn.title.flex!, child: _buildHeaderLabel(context, _TrackColumn.title)),
              if (!showCompactLayout && widget.showAlbum) ...[
                const SizedBox(width: _trackCellSpacing),
                Expanded(flex: _TrackColumn.album.flex!, child: _buildHeaderLabel(context, _TrackColumn.album)),
              ],
              if (!showCompactLayout) ...[
                const SizedBox(width: _trackCellSpacing),
                SizedBox(
                  width: _TrackColumn.plays.width!,
                  child: _buildHeaderLabel(context, _TrackColumn.plays),
                ),
              ],
              const SizedBox(width: _trackCellSpacing),
              SizedBox(
                width: _TrackColumn.duration.width!,
                child: _buildHeaderLabel(context, _TrackColumn.duration),
              ),
              if (widget.showSyncStatus) ...[
                const SizedBox(width: _trackCellSpacing),
                SizedBox(
                  width: _TrackColumn.sync.width!,
                  child: _buildHeaderLabel(context, _TrackColumn.sync),
                ),
              ],
              const SizedBox(width: _trackCellSpacing),
              SizedBox(width: _TrackColumn.action.width!),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrackListItem extends ConsumerStatefulWidget {
  final int index;
  final AudioModel track;
  final List<ItemAction> actions;
  final TrackTapCallback? onTap;
  final TrackArtistTapCallback? onArtistTap;
  final TrackSecondaryTapCallback? onSecondaryTap;
  final Function(AudioModel track)? onTrackPlayTap;
  final bool showAlbum;
  final bool showSyncStatus;
  final bool compactLayout;
  final bool isSelected;

  const _TrackListItem({
    required this.index,
    required this.track,
    required this.actions,
    this.onTrackPlayTap,
    this.onTap,
    this.onArtistTap,
    this.onSecondaryTap,
    this.showAlbum = true,
    this.showSyncStatus = false,
    this.compactLayout = false,
    this.isSelected = false,
  });

  @override
  ConsumerState<_TrackListItem> createState() => _TrackListItemState();
}

class _TrackListItemState extends ConsumerState<_TrackListItem> {
  bool _hovering = false;

  Future<void> _showContextMenu(Offset globalPosition) async {
    final position = RelativeRect.fromLTRB(globalPosition.dx, globalPosition.dy, globalPosition.dx, globalPosition.dy);
    await showMenu(
      context: context,
      position: position,
      items: widget.actions.popupMenuItems(useIcons: true),
    );
  }

  void _handleHover(bool hovering) {
    setState(() => _hovering = hovering);
  }

  @override
  Widget build(BuildContext context) {
    final trackArtists = widget.track.artists.isNotEmpty
        ? widget.track.artists
            .map(
              (e) => e.name,
            )
            .join(', ')
        : null;
    final durationText = widget.track.overview.runTime?.readAbleDuration;
    final playCountText = widget.track.userData.playCount > 0 ? 'x${widget.track.userData.playCount}' : '-';

    final radius = FladderTheme.smallShape.borderRadius;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.isSelected ? Theme.of(context).colorScheme.primaryContainer.withAlpha(80) : Colors.transparent,
      ),
      child: FocusButton(
        onHover: _handleHover,
        onTap: widget.onTap != null ? () => widget.onTap?.call(widget.track) : null,
        onLongPress: () {
          if (widget.onSecondaryTap != null) {
            showBottomSheetPill(
              context: context,
              item: widget.track,
              content: (scrollContext, scrollController) => ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: widget.track
                    .generateActions(
                      context,
                      ref,
                    )
                    .listTileItems(scrollContext, useIcons: true),
              ),
            );
          }
        },
        onSecondaryTapDown: (details) async {
          if (widget.actions.isNotEmpty) {
            await _showContextMenu(details.globalPosition);
            return;
          }
          widget.onSecondaryTap?.call(widget.track, details);
        },
        borderRadius: BorderRadius.circular(12),
        onFocusChanged: (focus) {
          if (focus) {
            context.ensureVisible();
          }
        },
        overlays: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12).add(const EdgeInsets.only(left: 4, right: 16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: _TrackColumn.position.width!,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _hovering
                          ? IconButton(
                              onPressed: widget.onTrackPlayTap != null
                                  ? () => widget.onTrackPlayTap?.call(widget.track)
                                  : null,
                              icon: const Icon(IconsaxPlusBold.play),
                            )
                          : widget.showAlbum
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: radius,
                                    color: Theme.of(context).colorScheme.surfaceContainer,
                                  ),
                                  foregroundDecoration: BoxDecoration(
                                    borderRadius: radius,
                                    border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: FladderImage(
                                    image: widget.track.images?.primary,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Text('${widget.index}', style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                ),
                const SizedBox(width: _trackCellSpacing),
                Expanded(
                  flex: _TrackColumn.title.flex!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.track.name, style: Theme.of(context).textTheme.titleMedium),
                      if (trackArtists != null) ...[
                        const SizedBox(height: 4),
                        ClickableText(
                          text: trackArtists,
                          style: Theme.of(context).textTheme.bodySmall,
                          onTap: widget.onArtistTap != null ? () => widget.onArtistTap?.call(widget.track) : null,
                        ),
                      ],
                    ],
                  ),
                ),
                if (!widget.compactLayout && widget.showAlbum && _TrackColumn.album.flex != null) ...[
                  const SizedBox(width: _trackCellSpacing),
                  Expanded(
                    flex: _TrackColumn.album.flex!,
                    child: ClickableText(
                      text: widget.track.album ?? '',
                      onTap: widget.track.album != null ? () => widget.track.parentBaseModel.navigateTo(context) : null,
                    ),
                  ),
                ],
                if (!widget.compactLayout) ...[
                  const SizedBox(width: _trackCellSpacing),
                  SizedBox(
                    width: _TrackColumn.plays.width,
                    child: Text(
                      playCountText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
                const SizedBox(width: _trackCellSpacing),
                SizedBox(
                  width: _TrackColumn.duration.width,
                  child: Text(
                    durationText ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.end,
                  ),
                ),
                if (widget.showSyncStatus) ...[
                  const SizedBox(width: _trackCellSpacing),
                  SizedBox(
                    width: _TrackColumn.sync.width,
                    child: ref.watch(syncedItemProvider(widget.track)).when(
                          error: (error, stackTrace) => const SizedBox.shrink(),
                          data: (syncedItem) {
                            if (syncedItem == null) {
                              return const SizedBox.shrink();
                            }
                            return Align(
                              alignment: Alignment.centerRight,
                              child: SyncButton(item: widget.track, syncedItem: syncedItem),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                        ),
                  ),
                ],
                const SizedBox(width: _trackCellSpacing),
                SizedBox(
                  width: _TrackColumn.action.width,
                  child: PopupMenuButton(
                    itemBuilder: (context) => widget.actions.popupMenuItems(useIcons: true),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
