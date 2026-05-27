import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/providers/items/album_details_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class AlbumDetailScreen extends ConsumerStatefulWidget {
  final AlbumModel item;
  const AlbumDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends ConsumerState<AlbumDetailScreen> {
  late final AlbumDetailsNotifier provider = ref.read(albumDetailsProvider(widget.item.id).notifier);

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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(detailsContext).colorScheme.primaryContainer,
                      Theme.of(detailsContext).colorScheme.surfaceContainer,
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
                      alignment: smallScreen ? WrapAlignment.center : WrapAlignment.start,
                      runAlignment: smallScreen ? WrapAlignment.center : WrapAlignment.start,
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
                                      IconButton.filled(
                                        autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                                        onPressed: tracks.isNotEmpty
                                            ? () async {
                                                await ref.read(videoPlayerProvider).setShuffleEnabled(false);
                                                await album.play(detailsContext, ref);
                                              }
                                            : null,
                                        icon: const Icon(
                                          IconsaxPlusBold.play,
                                        ),
                                        tooltip: context.localized.playLabel,
                                      ),
                                      FilledButton.tonalIcon(
                                        onPressed: tracks.isNotEmpty
                                            ? () async {
                                                await ref.read(videoPlayerProvider).setShuffleEnabled(true);
                                                await album.play(detailsContext, ref);
                                              }
                                            : null,
                                        label: Text(context.localized.audioPlayerShuffle),
                                        icon: const Icon(
                                          IconsaxPlusLinear.shuffle,
                                        ),
                                      ),
                                      FilledButton.tonalIcon(
                                        onPressed: tracks.isNotEmpty
                                            ? () async {
                                                await album.playInstantMix(detailsContext, ref);
                                              }
                                            : null,
                                        icon: const Icon(IconsaxPlusLinear.blend_2),
                                        label: Text(context.localized.instantMix),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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
