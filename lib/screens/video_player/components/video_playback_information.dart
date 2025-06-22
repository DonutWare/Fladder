import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/session_info_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/clipboard_helper.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/wrappers/players/player_states.dart';

Future<void> showVideoPlaybackInformation(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const _VideoPlaybackInformation(),
  );
}

class _VideoPlaybackInformation extends ConsumerWidget {
  const _VideoPlaybackInformation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackModel = ref.watch(playBackModel);
    final sessionInfo = ref.watch(sessionInfoProvider);
    final backend = ref.read(videoPlayerProvider.select((value) => value.backend));
    final playbackState = ref.watch(videoPlayerProvider.select((value) => value.lastState));
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Player info", style: Theme.of(context).textTheme.titleMedium),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 4),
                  child: Opacity(
                    opacity: 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('backend: '),
                            Text(backend?.label(context) ?? context.localized.unknown)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('url: '),
                            const SizedBox(width: 8),
                            Flexible(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 3.0,
                                  sigmaY: 3.0,
                                ),
                                child: Text(
                                  playbackModel?.media?.url ?? "No url",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () => context.copyToClipboard(playbackModel?.media?.url ?? "No url"),
                              icon: const Icon(IconsaxPlusLinear.copy),
                            )
                          ],
                        )
                      ].addPadding(const EdgeInsets.symmetric(vertical: 3)),
                    ),
                  ),
                ),
                const Divider(),
                if (playbackState != null) _PlayerInformation(state: playbackState),
                Text("Playback information", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 4),
                  child: Opacity(
                    opacity: 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [const Text('type: '), Text(playbackModel.label(context) ?? "")],
                        ),
                        if (sessionInfo.transCodeInfo != null) ...[
                          Text("Transcoding", style: Theme.of(context).textTheme.titleMedium),
                          if (sessionInfo.transCodeInfo?.transcodeReasons?.isNotEmpty == true)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('reason: '),
                                Text(sessionInfo.transCodeInfo?.transcodeReasons.toString() ?? "")
                              ],
                            ),
                          if (sessionInfo.transCodeInfo?.completionPercentage != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('transcode progress: '),
                                Text("${sessionInfo.transCodeInfo?.completionPercentage?.toStringAsFixed(2)} %")
                              ],
                            ),
                          if (sessionInfo.transCodeInfo?.container != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('container: '),
                                Text(sessionInfo.transCodeInfo!.container.toString())
                              ],
                            ),
                        ],
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('resolution: '),
                            Text(playbackModel?.item.streamModel?.resolutionText ?? "")
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('container: '),
                            Text(playbackModel?.playbackInfo?.mediaSources?.firstOrNull?.container ?? "")
                          ],
                        )
                      ].addPadding(const EdgeInsets.symmetric(vertical: 3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerInformation extends StatelessWidget {
  final PlayerState state;
  const _PlayerInformation({
    required this.state,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Player state", style: Theme.of(context).textTheme.titleMedium),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 4),
          child: Opacity(
            opacity: 0.80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text('playing: '), Text(state.playing.toString())],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text('buffering: '), Text(state.buffering.toString())],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text('duration: '), Text(state.duration.humanize ?? "")],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text('rate: '), Text(state.rate.toString())],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Text('volume: '), Text(state.volume.toString())],
                ),
              ].addPadding(const EdgeInsets.symmetric(vertical: 3)),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
