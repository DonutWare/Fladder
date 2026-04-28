import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

typedef TrackTapCallback = void Function(AudioModel track);
typedef TrackArtistTapCallback = void Function(AudioModel track);
typedef TrackSecondaryTapCallback = void Function(AudioModel track, TapDownDetails details);

class TrackList extends StatefulWidget {
  final String title;
  final bool enableSorting;
  final List<AudioModel> tracks;
  final int? maxTracks;
  final bool showAlbum;
  final Function(AudioModel track)? onTrackPlayTap;
  final Function(AudioModel track)? onTrackTap;
  final Function(AudioModel track)? onTrackArtistTap;
  final Function(AudioModel track, TapDownDetails details)? onTrackSecondaryTap;
  final EdgeInsets? padding;

  const TrackList({
    required this.title,
    this.enableSorting = true,
    required this.tracks,
    this.maxTracks,
    this.showAlbum = true,
    this.onTrackPlayTap,
    this.onTrackTap,
    this.onTrackArtistTap,
    this.onTrackSecondaryTap,
    this.padding,
    super.key,
  });

  @override
  State<TrackList> createState() => _TrackListState();
}

const double _trackCellSpacing = 16;

enum _TrackSortColumn { position, title, album, plays, duration }

enum _TrackColumn {
  position(label: '#', width: 45, sortable: false, sortColumn: _TrackSortColumn.position, align: TextAlign.center),
  title(label: 'Title', flex: 4, sortable: true, sortColumn: _TrackSortColumn.title),
  album(label: 'Album', flex: 3, sortable: true, sortColumn: _TrackSortColumn.album),
  plays(label: 'Plays', width: 90, sortable: true, sortColumn: _TrackSortColumn.plays, align: TextAlign.end),
  duration(label: 'Duration', width: 80, sortable: true, sortColumn: _TrackSortColumn.duration, align: TextAlign.end),
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

class _TrackListState extends State<TrackList> {
  _TrackSortColumn? _sortColumn;
  bool _ascending = true;

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
              _ascending ? Icons.arrow_upward : Icons.arrow_downward,
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
    if (visibleTracks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              _buildHeaderRow(context),
              ...visibleTracks.mapIndexed(
                (index, track) => TableRow(
                  children: [
                    _TrackListItem(
                      index: widget.showAlbum ? index + 1 : track.trackNumber ?? index + 1,
                      track: track,
                      onTap: widget.onTrackTap,
                      onTrackPlayTap: widget.onTrackPlayTap,
                      onArtistTap: widget.onTrackArtistTap,
                      onSecondaryTap: widget.onTrackSecondaryTap,
                      showAlbum: widget.showAlbum,
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
              if (widget.showAlbum) ...[
                const SizedBox(width: _trackCellSpacing),
                Expanded(flex: _TrackColumn.album.flex!, child: _buildHeaderLabel(context, _TrackColumn.album)),
              ],
              const SizedBox(width: _trackCellSpacing),
              SizedBox(
                width: _TrackColumn.plays.width!,
                child: _buildHeaderLabel(context, _TrackColumn.plays),
              ),
              const SizedBox(width: _trackCellSpacing),
              SizedBox(
                width: _TrackColumn.duration.width!,
                child: _buildHeaderLabel(context, _TrackColumn.duration),
              ),
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
  final TrackTapCallback? onTap;
  final TrackArtistTapCallback? onArtistTap;
  final TrackSecondaryTapCallback? onSecondaryTap;
  final Function(AudioModel track)? onTrackPlayTap;
  final bool showAlbum;

  const _TrackListItem({
    required this.index,
    required this.track,
    this.onTrackPlayTap,
    this.onTap,
    this.onArtistTap,
    this.onSecondaryTap,
    this.showAlbum = true,
  });

  @override
  ConsumerState<_TrackListItem> createState() => _TrackListItemState();
}

class _TrackListItemState extends ConsumerState<_TrackListItem> {
  bool _hovering = false;

  void _handleHover(bool hovering) {
    setState(() => _hovering = hovering);
  }

  @override
  Widget build(BuildContext context) {
    final trackArtists = widget.track.artistNames.isNotEmpty ? widget.track.artistNames.join(', ') : null;
    final durationText = widget.track.overview.runTime?.readAbleDuration;
    final playCountText = widget.track.userData.playCount > 0 ? 'x${widget.track.userData.playCount}' : '-';

    final radius = FladderTheme.smallShape.borderRadius;

    return FocusButton(
      onHover: _handleHover,
      onTap: widget.onTap != null ? () => widget.onTap?.call(widget.track) : null,
      onSecondaryTapDown:
          widget.onSecondaryTap != null ? (details) => widget.onSecondaryTap?.call(widget.track, details) : null,
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
                            onPressed:
                                widget.onTrackPlayTap != null ? () => widget.onTrackPlayTap?.call(widget.track) : null,
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
              if (widget.showAlbum) ...[
                const SizedBox(width: _trackCellSpacing),
                Expanded(
                  flex: _TrackColumn.album.flex!,
                  child: ClickableText(
                    text: widget.track.album ?? '',
                    onTap: widget.track.album != null ? () => widget.track.parentBaseModel.navigateTo(context) : null,
                  ),
                ),
              ],
              const SizedBox(width: _trackCellSpacing),
              SizedBox(
                width: _TrackColumn.plays.width!,
                child: Text(
                  playCountText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: _trackCellSpacing),
              SizedBox(
                width: _TrackColumn.duration.width!,
                child: Text(
                  durationText ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: _trackCellSpacing),
              SizedBox(
                width: _TrackColumn.action.width!,
                child: PopupMenuButton(
                  itemBuilder: (context) => widget.track.generateActions(context, ref).popupMenuItems(useIcons: true),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
