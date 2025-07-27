import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/screens/details_screens/components/media_stream_information.dart';
import 'package:fladder/screens/shared/media/episode_posters.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sticky_header_text.dart';
import 'package:fladder/util/string_extensions.dart';

class NextUpEpisode extends ConsumerWidget {
  final EpisodeModel nextEpisode;
  final Function(EpisodeModel episode)? onChanged;
  const NextUpEpisode({required this.nextEpisode, this.onChanged, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alreadyPlayed = nextEpisode.userData.played;
    final episodeSummary = nextEpisode.overview.summary.maxLength(limitTo: 250);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StickyHeaderText(
          label: alreadyPlayed ? context.localized.reWatch : context.localized.nextUp,
        ),
        Opacity(
          opacity: 0.75,
          child: SelectableText(
            nextEpisode.seasonEpisodeLabelFull(context),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SelectableText(
          nextEpisode.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 550) {
              return Column(
                children: [
                  EpisodePoster(
                    episode: nextEpisode,
                    showLabel: false,
                    onTap: () => nextEpisode.navigateTo(context),
                    actions: const [],
                    isCurrentEpisode: false,
                  ),
                  const SizedBox(height: 16),
                  if (nextEpisode.overview.summary.isNotEmpty)
                    HtmlWidget(
                      episodeSummary,
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                ],
              );
            } else {
              return Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: AdaptiveLayout.poster(context).gridRatio,
                        maxWidth: MediaQuery.of(context).size.width / 2),
                    child: EpisodePoster(
                      episode: nextEpisode,
                      showLabel: false,
                      onTap: () => nextEpisode.navigateTo(context),
                      actions: const [],
                      isCurrentEpisode: false,
                    ),
                  ),
                  const SizedBox(width: 32),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MediaStreamInformation(
                          mediaStream: nextEpisode.mediaStreams,
                          onVersionIndexChanged: (index) => onChanged?.call(nextEpisode.copyWith(
                            mediaStreams: nextEpisode.mediaStreams.copyWith(versionStreamIndex: index),
                          )),
                          onAudioIndexChanged: (index) => onChanged?.call(nextEpisode.copyWith(
                              mediaStreams: nextEpisode.mediaStreams.copyWith(defaultAudioStreamIndex: index))),
                          onSubIndexChanged: (index) => onChanged?.call(nextEpisode.copyWith(
                              mediaStreams: nextEpisode.mediaStreams.copyWith(defaultSubStreamIndex: index))),
                        ),
                        if (nextEpisode.overview.summary.isNotEmpty)
                          HtmlWidget(episodeSummary, textStyle: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
