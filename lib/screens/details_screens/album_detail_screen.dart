import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/providers/items/album_details_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';

class AlbumDetailScreen extends ConsumerStatefulWidget {
  final AlbumModel item;
  const AlbumDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends ConsumerState<AlbumDetailScreen> {
  late final AlbumDetailsNotifier provider = ref.read(albumDetailsProvider(widget.item.id).notifier);

  Color? backgroundColor;
  ImageProvider? _lastImageProvider;

  void _updateBackgroundColor(dynamic imageData) {
    final provider = imageData?.imageProvider;
    if (provider == null || identical(provider, _lastImageProvider)) return;
    _lastImageProvider = provider;

    getDominantColor(provider).then((color) {
      if (!mounted || !identical(provider, _lastImageProvider)) return;
      setState(() {
        backgroundColor = color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final album = ref.watch(albumDetailsProvider(widget.item.id));
    final current = album ?? widget.item;
    final tracks = current.tracks;
    final imageData = current.images?.primary ?? current.images?.backDrop?.firstOrNull;
    if (backgroundColor == null) {
      _updateBackgroundColor(imageData);
    }

    final artistLabel = current.artistLabel.isNotEmpty ? current.artistLabel : 'Artist';
    final mainArtistLabel = artistLabel.split(',').first.trim();
    final hasArtistNavigation = current.parentBaseModel.id.isNotEmpty;
    final releaseYear = current.overview.yearAired?.toString();
    final totalDuration =
        tracks.fold<Duration>(Duration.zero, (duration, track) => duration + (track.overview.runTime ?? Duration.zero));
    final durationText = totalDuration > Duration.zero ? totalDuration.readAbleDuration : null;
    final albumMeta = [
      if (releaseYear != null) releaseYear,
      '${tracks.length} ${tracks.length == 1 ? 'track' : 'tracks'}',
      if (durationText != null) durationText,
    ].join(' • ');

    final radius = FladderTheme.smallShape.borderRadius;

    return DetailScaffold(
      label: current.name,
      item: current,
      backDrops: current.images,
      posterFillsContent: true,
      onRefresh: () async {
        await provider.fetchDetails(widget.item);
      },
      actions: (context) => current.generateActions(
        context,
        ref,
        exclude: {ItemActions.details},
      ),
      content: (detailsContext, padding) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: imageData != null
                    ? DecorationImage(
                        image: imageData.imageProvider,
                        fit: BoxFit.cover,
                        opacity: 0.1,
                        colorFilter: ColorFilter.mode(
                          backgroundColor ?? Colors.black,
                          BlendMode.softLight,
                        ),
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface.withAlpha(230),
                      Theme.of(context).colorScheme.surface.withAlpha(13),
                    ],
                  ),
                  border: BoxBorder.fromLTRB(
                    top: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                    bottom: BorderSide(width: 1.5, color: Theme.of(context).colorScheme.onSurface.withAlpha(30)),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: padding.left,
                    right: padding.right,
                    top: 120,
                    bottom: 24,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 24,
                      runSpacing: 24,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          width: 275,
                          height: 275,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: radius,
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius: radius,
                                border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
                              ),
                              clipBehavior: Clip.hardEdge,
                              margin: EdgeInsets.zero,
                              child: FladderImage(
                                image: current.images?.primary ?? current.images?.backDrop?.firstOrNull,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ALBUM', style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 1.5)),
                            const SizedBox(height: 10),
                            Text(current.name, style: Theme.of(context).textTheme.displaySmall),
                            const SizedBox(height: 14),
                            ClickableText(
                              text: mainArtistLabel,
                              style: Theme.of(context).textTheme.titleLarge,
                              onTap:
                                  hasArtistNavigation ? () => current.parentBaseModel.navigateTo(detailsContext) : null,
                            ),
                            if (albumMeta.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(albumMeta, style: Theme.of(context).textTheme.bodyLarge),
                            ],
                            const SizedBox(height: 24),
                            IconButton.filledTonal(
                              onPressed: tracks.isNotEmpty ? () => tracks.first.play(detailsContext, ref) : null,
                              icon: const Icon(
                                IconsaxPlusLinear.play,
                                size: 36,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(detailsContext).colorScheme.surface,
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(detailsContext).height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  const SizedBox(height: 16),
                  if (tracks.isNotEmpty) ...[
                    TrackList(
                      title: 'Tracks',
                      tracks: tracks,
                      padding: padding,
                      onTrackTap: (track) => track.play(detailsContext, ref),
                      onTrackArtistTap: (_) => current.parentBaseModel.navigateTo(detailsContext),
                      showAlbum: false,
                      onTrackSecondaryTap: (track, details) {
                        track.showDetailsMenu(
                          context,
                          ref,
                          details.globalPosition,
                        );
                      },
                    ),
                  ],
                  if (current.relatedAlbums.isNotEmpty) ...[
                    PosterRow(
                      posters: current.relatedAlbums,
                      label: 'More by $mainArtistLabel',
                      contentPadding: padding,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
