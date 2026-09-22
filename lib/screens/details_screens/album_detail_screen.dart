import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/playback/playback_queue_source.dart';
import 'package:fladder/providers/items/album_details_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/details_screens/tracks_detail_screen.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/media/components/poster_placeholder.dart';
import 'package:fladder/screens/shared/media/components/small_detail_widgets.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/selectable_icon_button.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class AlbumDetailScreen extends ConsumerStatefulWidget {
  final AlbumModel item;
  const AlbumDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends ConsumerState<AlbumDetailScreen> {
  late final AlbumDetailsNotifier provider = ref.read(albumDetailsProvider(widget.item.id).notifier);
  Color? _posterColor;
  String? _lastPosterId;

  void _updatePosterColor(ImageData? imageData) {
    if (imageData == null) {
      _posterColor = null;
      _lastPosterId = null;
      return;
    }

    final posterId = imageData.key.isNotEmpty ? imageData.key : imageData.path;

    if (posterId == _lastPosterId) {
      return;
    }

    _lastPosterId = posterId;
    final imageProvider = imageData.imageProvider;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final newColor = await getDominantColor(imageProvider);
      if (!mounted || posterId != _lastPosterId) return;

      setState(() => _posterColor = newColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    final album = ref.watch(albumDetailsProvider(widget.item.id));
    final current = album ?? widget.item;
    final tracks = current.tracks;

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

    final smallScreen = AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone;

    final albumPoster = current.images?.primary ?? current.images?.backDrop?.firstOrNull;
    if (albumPoster != null) {
      _updatePosterColor(albumPoster);
    } else if (_lastPosterId != null) {
      _lastPosterId = null;
      _posterColor = null;
    }

    final derivePosterColor = ref.watch(clientSettingsProvider.select((value) => value.dynamicPosterColors));
    final fallbackBackgroundColor = current.name.toColor.harmonizeWith(Theme.of(context).colorScheme.surface);
    final backgroundColor = derivePosterColor
        ? (albumPoster != null ? (_posterColor ?? fallbackBackgroundColor) : fallbackBackgroundColor)
        : Theme.of(context).colorScheme.surface;

    final isFavourite = album?.userData.isFavourite ?? false;

    return DetailScaffold(
      label: current.name,
      item: current,
      backDrops: current.images,
      posterFillsContent: true,
      onRefresh: () async {
        await provider.fetchDetails(widget.item);
      },
      dominantColor: derivePosterColor ? (_posterColor ?? backgroundColor) : null,
      actions: (context) => current.generateActions(
        context,
        ref,
        exclude: {ItemActions.details},
      ),
      content: (detailsContext, padding) {
        final topGradientColor =
            albumPoster == null ? backgroundColor : Theme.of(detailsContext).colorScheme.primaryContainer;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      topGradientColor,
                      Theme.of(detailsContext).colorScheme.surfaceContainerLow,
                    ],
                  ),
                  border: BoxBorder.fromLTRB(
                    top: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                    bottom: BorderSide(width: 1.5, color: backgroundColor.withAlpha(30)),
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
                    child: Column(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: smallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          alignment: smallScreen ? WrapAlignment.center : WrapAlignment.start,
                          runAlignment: smallScreen ? WrapAlignment.center : WrapAlignment.start,
                          spacing: 24,
                          runSpacing: 24,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: 230,
                              height: 230,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: radius,
                                    color: backgroundColor,
                                  ),
                                  foregroundDecoration: BoxDecoration(
                                    borderRadius: radius,
                                    border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: FladderImage(
                                    image: albumPoster,
                                    fit: BoxFit.cover,
                                    placeHolder: PosterPlaceholder(item: current),
                                  ),
                                ),
                              ),
                            ),
                            IntrinsicWidth(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: smallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.localized.musicAlbum(1).toUpperCase(),
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 1.5),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    current.name,
                                    style: Theme.of(context).textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 14),
                                  ClickableText(
                                    text: mainArtistLabel,
                                    style: Theme.of(context).textTheme.titleLarge,
                                    onTap: hasArtistNavigation
                                        ? () => current.parentBaseModel.navigateTo(detailsContext)
                                        : null,
                                  ),
                                  if (albumMeta.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    Text(albumMeta, style: Theme.of(context).textTheme.bodyLarge),
                                  ],
                                  const SizedBox(height: 24),
                                  FittedBox(
                                    child: SizedBox(
                                      height: 45,
                                      child: Row(
                                        spacing: 8,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          SelectableIconButton(
                                            autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                                            onPressed: tracks.isNotEmpty
                                                ? () async {
                                                    await ref.read(videoPlayerProvider).setShuffleEnabled(false);
                                                    await album.play(detailsContext, ref);
                                                  }
                                                : null,
                                            icon: IconsaxPlusBold.play,
                                            selected: true,
                                          ),
                                          SelectableIconButton(
                                            onPressed: tracks.isNotEmpty
                                                ? () async {
                                                    await ref.read(videoPlayerProvider).setShuffleEnabled(true);
                                                    await album.play(detailsContext, ref);
                                                  }
                                                : null,
                                            label: context.localized.audioPlayerShuffle,
                                            icon: IconsaxPlusLinear.shuffle,
                                          ),
                                          SelectableIconButton(
                                            onPressed: tracks.isNotEmpty
                                                ? () => showTracksDetailsScreen(
                                                      context: detailsContext,
                                                      item: album!,
                                                      ref: ref,
                                                      queueSource: AlbumInstantMixQueueSource(
                                                        albumId: album.id,
                                                        limit: 200,
                                                      ),
                                                    )
                                                : null,
                                            selected: false,
                                            icon: IconsaxPlusLinear.blend_2,
                                            label: context.localized.instantMix,
                                          ),
                                          SelectableIconButton(
                                            onPressed: () async {
                                              await ref
                                                  .read(userProvider.notifier)
                                                  .setAsFavorite(!isFavourite, album?.id ?? "");
                                            },
                                            selected: isFavourite,
                                            selectedIcon: IconsaxPlusBold.heart,
                                            icon: IconsaxPlusLinear.heart,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (album?.overview.genreItems.isNotEmpty == true)
                          Genres(
                            genres: album?.overview.genreItems.take(10).toList() ?? [],
                            onGenreClicked: (genre) {
                              final itemViewId = album?.parentId ?? "";
                              LibrarySearchRoute(
                                parentId: [itemViewId],
                                genres: {genre.name: true},
                              ).push(context);
                            },
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
                      title: context.localized.track(tracks.length),
                      enableSorting: false,
                      tracks: tracks,
                      showSyncStatus: true,
                      showDiscSplit: true,
                      padding: padding,
                      onTrackPlayTap: (track) => track.play(detailsContext, ref),
                      onTrackArtistTap: (_) => current.parentBaseModel.navigateTo(detailsContext),
                      showAlbum: false,
                      onPlaySelected: (selected) => selected.play(detailsContext, ref),
                      onAddToQueueSelected: (selected) async {
                        await ref.read(videoPlayerProvider.notifier).addToTemporaryQueue(selected);
                        if (detailsContext.mounted) {
                          FladderSnack.show(
                            detailsContext.localized.addedToQueue(selected.length),
                            context: detailsContext,
                          );
                        }
                      },
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
                    const Divider(),
                    PosterRow(
                      posters: current.relatedAlbums,
                      label: context.localized.moreFrom(mainArtistLabel),
                      contentPadding: padding,
                      showSyncStatus: true,
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
