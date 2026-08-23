import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/playback/playback_queue_source.dart';
import 'package:fladder/screens/shared/media/track_list.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/selectable_icon_button.dart';

Future<void> showTracksDetailsScreen({
  required BuildContext context,
  required ItemBaseModel item,
  required WidgetRef ref,
  required PlaybackQueueSource queueSource,
}) async {
  await showDialog(
    context: context,
    builder: (context) => TracksDetailsScreen(
      item: item,
      queueSource: queueSource,
    ),
  );
}

class TracksDetailsScreen extends ConsumerStatefulWidget {
  final ItemBaseModel item;
  final PlaybackQueueSource queueSource;
  const TracksDetailsScreen({
    super.key,
    required this.item,
    required this.queueSource,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TracksDetailsScreenState();
}

class _TracksDetailsScreenState extends ConsumerState<TracksDetailsScreen> {
  List<AudioModel> tracks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  Future<void> _loadTracks() async {
    try {
      final fetchedTracks = await widget.queueSource.fetchQueue(ref.read);
      setState(() {
        tracks = fetchedTracks.whereType<AudioModel>().toList();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = switch (widget.queueSource) {
      ArtistInstantMixQueueSource _ ||
      AlbumInstantMixQueueSource _ ||
      AudioInstantMixQueueSource _ =>
        context.localized.instantMixBy(widget.item.name),
      ArtistFavoriteQueueSource _ => context.localized.favoritesOf(widget.item.name),
      _ => context.localized.latestTracksBy(widget.item.name),
    };
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SelectableIconButton(
                  onPressed: isLoading || tracks.isEmpty
                      ? null
                      : () async {
                          await widget.queueSource.play(context, ref);
                          Navigator.of(context).pop();
                        },
                  selected: false,
                  icon: IconsaxPlusBold.play,
                ),
              ],
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (tracks.isEmpty)
              Center(child: Text(context.localized.queueIsEmpty))
            else
              Flexible(
                child: SingleChildScrollView(
                  child: TrackList(
                    tracks: tracks,
                    showHeader: false,
                    onTrackPlayTap: (track) async {
                      await widget.queueSource.play(context, ref);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
