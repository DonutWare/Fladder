import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/items/episode_details_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/details_screens/components/media_stream_information.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/media/chapter_row.dart';
import 'package:fladder/screens/shared/media/components/media_play_button.dart';
import 'package:fladder/screens/shared/media/episode_posters.dart';
import 'package:fladder/screens/shared/media/expanding_overview.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/widget_extensions.dart';
import 'package:fladder/widgets/shared/selectable_icon_button.dart';

class EpisodeDetailScreen extends ConsumerStatefulWidget {
  final ItemBaseModel item;
  const EpisodeDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<EpisodeDetailScreen> {
  AutoDisposeStateNotifierProvider<EpisodeDetailsProvider, EpisodeDetailModel> get providerInstance =>
      episodeDetailsProvider(widget.item.id);

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(providerInstance);
    final seasonDetails = details.series;
    final episodeDetails = details.episode;
    final wrapAlignment =
        AdaptiveLayout.of(context).layout != LayoutState.phone ? WrapAlignment.start : WrapAlignment.center;

    return DetailScaffold(
      label: widget.item.name,
      item: details.episode,
      actions: (context) => details.episode?.generateActions(
        context,
        ref,
        exclude: {
          if (details.series == null) ItemActions.openShow,
          ItemActions.details,
        },
        onDeleteSuccesFully: (item) {
          if (context.mounted) {
            context.router.popBack();
          }
        },
      ),
      onRefresh: () async => await ref.read(providerInstance.notifier).fetchDetails(widget.item),
      backDrops: details.episode?.images ?? details.series?.images,
      content: (padding) => seasonDetails != null && episodeDetails != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OverviewHeader(
                    name: details.series?.name ?? "",
                    image: seasonDetails.images,
                    centerButtons: episodeDetails.playAble
                        ? MediaPlayButton(
                            item: episodeDetails,
                            onPressed: () async {
                              await details.episode.play(context, ref);
                              ref.read(providerInstance.notifier).fetchDetails(widget.item);
                            },
                            onLongPressed: () async {
                              await details.episode.play(context, ref, showPlaybackOption: true);
                              ref.read(providerInstance.notifier).fetchDetails(widget.item);
                            },
                          )
                        : null,
                    padding: padding,
                    subTitle: details.episode?.detailedName(context),
                    originalTitle: details.series?.originalTitle,
                    onTitleClicked: () => details.series?.navigateTo(context),
                    productionYear: details.series?.overview.productionYear,
                    runTime: details.episode?.overview.runTime,
                    studios: details.series?.overview.studios ?? [],
                    genres: details.series?.overview.genreItems ?? [],
                    officialRating: details.series?.overview.parentalRating,
                    communityRating: details.series?.overview.communityRating,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: wrapAlignment,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SelectableIconButton(
                        onPressed: () async {
                          await ref
                              .read(userProvider.notifier)
                              .setAsFavorite(!(episodeDetails.userData.isFavourite), episodeDetails.id);
                        },
                        selected: episodeDetails.userData.isFavourite,
                        selectedIcon: IconsaxBold.heart,
                        icon: IconsaxOutline.heart,
                      ),
                      SelectableIconButton(
                        onPressed: () async {
                          await ref
                              .read(userProvider.notifier)
                              .markAsPlayed(!(episodeDetails.userData.played), episodeDetails.id);
                        },
                        selected: episodeDetails.userData.played,
                        selectedIcon: IconsaxBold.tick_circle,
                        icon: IconsaxOutline.tick_circle,
                      ),
                    ].addPadding(const EdgeInsets.symmetric(horizontal: 6)),
                  ).padding(padding),
                  if (details.episode?.mediaStreams != null)
                    Padding(
                      padding: padding,
                      child: MediaStreamInformation(
                        mediaStream: details.episode!.mediaStreams,
                        onSubIndexChanged: (index) {
                          ref.read(providerInstance.notifier).setSubIndex(index);
                        },
                        onAudioIndexChanged: (index) {
                          ref.read(providerInstance.notifier).setAudioIndex(index);
                        },
                      ),
                    ),
                  if (episodeDetails.overview.summary.isNotEmpty == true)
                    ExpandingOverview(
                      text: episodeDetails.overview.summary,
                    ).padding(padding),
                  if (episodeDetails.chapters.isNotEmpty)
                    ChapterRow(
                      chapters: episodeDetails.chapters,
                      contentPadding: padding,
                      onPressed: (chapter) async {
                        await details.episode?.play(context, ref, startPosition: chapter.startPosition);
                        ref.read(providerInstance.notifier).fetchDetails(widget.item);
                      },
                    ),
                  if (details.episodes.length > 1)
                    EpisodePosters(
                      contentPadding: padding,
                      label: context.localized
                          .moreFrom("${context.localized.season(1).toLowerCase()} ${episodeDetails.season}"),
                      onEpisodeTap: (action, episodeModel) {
                        if (episodeModel.id == episodeDetails.id) {
                          fladderSnackbar(context, title: context.localized.selectedWith(context.localized.episode(0)));
                        } else {
                          action();
                        }
                      },
                      playEpisode: (episode) => episode.play(
                        context,
                        ref,
                      ),
                      episodes: details.episodes.where((element) => element.season == episodeDetails.season).toList(),
                    ),
                  if (details.series?.overview.externalUrls?.isNotEmpty == true)
                    Padding(
                      padding: padding,
                      child: ExternalUrlsRow(
                        urls: details.series?.overview.externalUrls,
                      ),
                    )
                ].addPadding(const EdgeInsets.symmetric(vertical: 16)),
              ),
            )
          : Container(),
    );
  }
}
