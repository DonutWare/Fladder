import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/playback/playback_queue_source.dart';
import 'package:fladder/providers/items/artist_details_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/details_screens/tracks_detail_screen.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/selectable_icon_button.dart';

class ArtistDetailScreen extends ConsumerStatefulWidget {
  final ArtistModel item;
  const ArtistDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends ConsumerState<ArtistDetailScreen> {
  ArtistDetailsNotifier get provider => ref.read(artistDetailsProvider(widget.item.id).notifier);

  @override
  Widget build(BuildContext context) {
    final artist = ref.watch(artistDetailsProvider(widget.item.id));
    final current = artist ?? widget.item;

    final placeHolder = Text(
      current.name,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
    );

    final derivePosterColor = ref.watch(clientSettingsProvider.select((value) => value.dynamicPosterColors));
    final backgroundColor = derivePosterColor
        ? current.name.toColor.harmonizeWith(Theme.of(context).colorScheme.surface)
        : Theme.of(context).colorScheme.surface;

    final isFavourite = artist?.userData.isFavourite == true;

    final smallSize = AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone;

    final favoriteTracks = artist?.favoriteTracks ?? [];

    return DetailScaffold(
      label: current.name,
      item: current,
      backgroundColor: backgroundColor.withAlpha(80),
      backDrops: artist?.getPosters,
      onRefresh: () async {
        await provider.fetchDetails(widget.item);
      },
      actions: (context) => current.generateActions(
        context,
        ref,
        exclude: {ItemActions.details},
      ),
      content: (detailsContext, padding) {
        final tracks = current.tracks;
        final albums = current.albums;

        return Padding(
          padding: const EdgeInsets.only(bottom: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 3),
              Padding(
                padding: padding.copyWith(bottom: 0, top: 0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: FladderImage(
                    image: artist?.getPosters?.logo,
                    placeHolder: placeHolder,
                    disableBlur: true,
                    imageErrorBuilder: (context, error, stackTrace) => placeHolder,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    alignment: smallSize ? WrapAlignment.center : WrapAlignment.start,
                    runAlignment: smallSize ? WrapAlignment.center : WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SelectableIconButton(
                        onPressed: () async {
                          await current.playLatestTracks(detailsContext, ref, shuffleEnabled: false);
                        },
                        selected: true,
                        icon: IconsaxPlusBold.play,
                      ),
                      SelectableIconButton(
                        onPressed: () async {
                          await current.playLatestTracks(detailsContext, ref, shuffleEnabled: true);
                        },
                        icon: IconsaxPlusLinear.shuffle,
                        label: context.localized.audioPlayerShuffle,
                      ),
                      SelectableIconButton(
                        onPressed: () => showTracksDetailsScreen(
                          context: detailsContext,
                          item: current,
                          ref: ref,
                          queueSource: ArtistInstantMixQueueSource(
                            artistId: current.id,
                            limit: 200,
                          ),
                        ),
                        icon: IconsaxPlusLinear.blend_2,
                        label: context.localized.instantMix,
                      ),
                      SelectableIconButton(
                        onPressed: () async {
                          await ref.read(userProvider.notifier).setAsFavorite(!isFavourite, artist?.id ?? "");
                        },
                        selected: isFavourite,
                        selectedIcon: IconsaxPlusBold.heart,
                        icon: IconsaxPlusLinear.heart,
                      ),
                    ],
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
                      Padding(
                        padding: padding,
                        child: Row(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: TrackList(
                                title: context.localized.latest,
                                tracks: tracks.take(8).toList(),
                                enableSorting: false,
                                showSyncStatus: true,
                                onTrackPlayTap: (track) =>
                                    current.playLatestTracks(detailsContext, ref, startTrack: track),
                                onTrackArtistTap: (_) => current.parentBaseModel.navigateTo(detailsContext),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (albums.isNotEmpty)
                      PosterRow(
                        posters: albums,
                        label: context.localized.discography,
                        contentPadding: padding,
                        showSyncStatus: true,
                      ),
                    if (favoriteTracks.isNotEmpty)
                      PosterRow(
                        posters: favoriteTracks,
                        label: context.localized.youLiked,
                        onLabelClick: () async {
                          await showTracksDetailsScreen(
                            context: detailsContext,
                            item: current,
                            ref: ref,
                            queueSource: ArtistFavoriteQueueSource(
                              artistId: current.id,
                              limit: 300,
                            ),
                          );
                        },
                        contentPadding: padding,
                        showSyncStatus: true,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
