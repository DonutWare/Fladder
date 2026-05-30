import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/providers/items/artist_details_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';

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

    return DetailScaffold(
      label: current.name,
      item: current,
      backDrops: artist?.images,
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
                    imageErrorBuilder: (context, error, stackTrace) => placeHolder,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (current.subText?.isNotEmpty == true)
                          Text(current.subText!, style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 45,
                          child: Row(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              IconButton.filled(
                                onPressed: () async {
                                  await current.playLatestTracks(detailsContext, ref, shuffleEnabled: false);
                                },
                                icon: const Icon(IconsaxPlusBold.play),
                                tooltip: context.localized.play(current.name),
                              ),
                              FilledButton.tonalIcon(
                                onPressed: () async {
                                  await current.playLatestTracks(detailsContext, ref, shuffleEnabled: true);
                                },
                                icon: const Icon(IconsaxPlusLinear.shuffle),
                                label: Text(context.localized.audioPlayerShuffle),
                              ),
                              FilledButton.tonalIcon(
                                onPressed: () async {
                                  await current.playInstantMix(detailsContext, ref);
                                },
                                icon: const Icon(IconsaxPlusLinear.blend_2),
                                label: Text(context.localized.instantMix),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16)
                      ],
                    ),
                  ],
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
                        child: TrackList(
                          title: context.localized.latest,
                          tracks: tracks.take(8).toList(),
                          enableSorting: false,
                          showSyncStatus: true,
                          onTrackPlayTap: (track) => current.playLatestTracks(detailsContext, ref, startTrack: track),
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
                    if (albums.isNotEmpty)
                      PosterRow(
                        posters: albums,
                        label: context.localized.musicAlbum(2),
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
