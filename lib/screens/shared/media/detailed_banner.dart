import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/media/components/media_play_button.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';

class DetailedBanner extends ConsumerStatefulWidget {
  final List<ItemBaseModel> posters;
  final Function(ItemBaseModel selected) onSelect;
  const DetailedBanner({
    required this.posters,
    required this.onSelect,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailedBannerState();
}

class _DetailedBannerState extends ConsumerState<DetailedBanner> {
  late ItemBaseModel selectedPoster = widget.posters.first;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final color = Theme.of(context).colorScheme.surface;
    final stops = [0.05, 0.35, 0.65, 0.95];
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.50,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.8),
                  color.withValues(alpha: 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                ExcludeFocus(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AspectRatio(
                      aspectRatio: 1.7,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white.withAlpha(0),
                            ],
                            stops: stops,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Colors.white.withAlpha(0),
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],
                              stops: stops,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: FladderImage(
                            image: selectedPoster.images?.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      spacing: 16,
                      children: [
                        Flexible(
                          child: OverviewHeader(
                            name: selectedPoster.parentBaseModel.name,
                            subTitle: selectedPoster.label(context),
                            image: selectedPoster.getPosters,
                            logoAlignment: Alignment.centerLeft,
                            summary: selectedPoster.overview.summary,
                            centerButtons: MediaPlayButton(
                              item: selectedPoster,
                              onLongPressed: () async {
                                await selectedPoster.play(
                                  context,
                                  ref,
                                  showPlaybackOption: true,
                                );
                                context.refreshData();
                              },
                              onPressed: () async {
                                await selectedPoster.play(
                                  context,
                                  ref,
                                );
                                context.refreshData();
                              },
                            ),
                            productionYear: selectedPoster.overview.productionYear,
                            runTime: selectedPoster.overview.runTime,
                            genres: selectedPoster.overview.genreItems,
                            studios: selectedPoster.overview.studios,
                            officialRating: selectedPoster.overview.parentalRating,
                            communityRating: selectedPoster.overview.communityRating,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        FocusProvider(
          autoFocus: true,
          focusPosition: 1.0,
          child: PosterRow(
            primaryPosters: true,
            label: context.localized.goTo,
            posters: widget.posters,
            onFocused: (poster) {
              widget.onSelect(poster);
              setState(() {
                selectedPoster = poster;
              });
            },
          ),
        )
      ],
    );
  }
}
