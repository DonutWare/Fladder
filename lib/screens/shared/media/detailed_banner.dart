import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/custom_shader_mask.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

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
  late ValueNotifier<ItemBaseModel> selectedPoster = ValueNotifier(widget.posters.first);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final phoneOffsetHeight =
        AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone ? MediaQuery.paddingOf(context).top + 80 : 0.0;
    return Stack(
      children: [
        ExcludeFocus(
          child: Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(0, -phoneOffsetHeight),
              child: FractionallySizedBox(
                widthFactor: 0.85,
                child: AspectRatio(
                  aspectRatio: 1.8,
                  child: CustomShaderMask(
                    child: ValueListenableBuilder(
                      valueListenable: selectedPoster,
                      builder: (context, value, child) => FladderImage(
                        image: value.images?.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: size.height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ExcludeFocus(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 4),
                    child: FractionallySizedBox(
                      widthFactor: AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone ? 1.0 : 0.55,
                      child: ValueListenableBuilder(
                        valueListenable: selectedPoster,
                        builder: (context, value, child) => OverviewHeader(
                          name: value.parentBaseModel.name,
                          subTitle: value.label(context),
                          image: value.getPosters,
                          logoAlignment: AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone
                              ? Alignment.center
                              : Alignment.centerLeft,
                          summary: value.overview.summary,
                          productionYear: value.overview.productionYear,
                          runTime: value.overview.runTime,
                          genres: value.overview.genreItems,
                          studios: value.overview.studios,
                          officialRating: value.overview.parentalRating,
                          communityRating: value.overview.communityRating,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FocusProvider(
                autoFocus: true,
                child: PosterRow(
                  primaryPosters: true,
                  label: context.localized.nextUp,
                  posters: widget.posters,
                  onFocused: (poster) {
                    context.ensureVisible(
                      alignment: 1.0,
                    );
                    selectedPoster.value = poster;
                    widget.onSelect(poster);
                  },
                ),
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ],
    );
  }
}
