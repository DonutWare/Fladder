import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/shared/media/components/chip_button.dart';
import 'package:fladder/screens/shared/media/components/media_header.dart';
import 'package:fladder/screens/shared/media/components/small_detail_widgets.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/list_padding.dart';

class OverviewHeader extends ConsumerWidget {
  final String name;
  final ImagesData? image;
  final Widget? centerButtons;
  final EdgeInsets? padding;
  final String? subTitle;
  final String? originalTitle;
  final Alignment logoAlignment;
  final Function()? onTitleClicked;
  final int? productionYear;
  final String? summary;
  final Duration? runTime;
  final String? officialRating;
  final double? communityRating;
  final List<Studio> studios;
  final List<GenreItems> genres;
  const OverviewHeader({
    required this.name,
    this.image,
    this.centerButtons,
    this.padding,
    this.subTitle,
    this.originalTitle,
    this.logoAlignment = Alignment.bottomCenter,
    this.onTitleClicked,
    this.productionYear,
    this.summary,
    this.runTime,
    this.officialRating,
    this.communityRating,
    this.genres = const [],
    this.studios = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
    final subStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 18,
        );

    final fullHeight =
        (MediaQuery.sizeOf(context).height - (MediaQuery.paddingOf(context).top + 150)).clamp(50, 1250).toDouble();

    final crossAlignment =
        AdaptiveLayout.viewSizeOf(context) != ViewSize.phone ? CrossAxisAlignment.start : CrossAxisAlignment.center;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: fullHeight,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: crossAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ExcludeFocus(
                child: MediaHeader(
                  name: name,
                  logo: image?.logo,
                  onTap: onTitleClicked,
                  alignment: logoAlignment,
                ),
              ),
            ),
            ExcludeFocus(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAlignment,
                children: [
                  if (subTitle != null)
                    Flexible(
                      child: SelectableText(
                        subTitle ?? "",
                        textAlign: TextAlign.center,
                        style: mainStyle,
                      ),
                    ),
                  if (name.toLowerCase() != originalTitle?.toLowerCase() && originalTitle != null)
                    SelectableText(
                      originalTitle.toString(),
                      textAlign: TextAlign.center,
                      style: subStyle,
                    ),
                ].addInBetween(const SizedBox(height: 4)),
              ),
            ),
            ExcludeFocus(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAlignment,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (officialRating != null)
                        ChipButton(
                          label: officialRating.toString(),
                        ),
                      if (productionYear != null)
                        SelectableText(
                          productionYear.toString(),
                          textAlign: TextAlign.center,
                          style: subStyle,
                        ),
                      if (runTime != null && (runTime?.inSeconds ?? 0) > 1)
                        SelectableText(
                          runTime.humanize.toString(),
                          textAlign: TextAlign.center,
                          style: subStyle,
                        ),
                      if (communityRating != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              communityRating?.toStringAsFixed(2) ?? "",
                              style: subStyle,
                            ),
                          ],
                        ),
                    ].addInBetween(CircleAvatar(
                      radius: 3,
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                    )),
                  ),
                  if (summary?.isNotEmpty == true)
                    Flexible(
                      child: Text(
                        summary ?? "",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  if (genres.isNotEmpty)
                    Genres(
                      genres: genres.take(6).toList(),
                    ),
                ].addInBetween(const SizedBox(height: 10)),
              ),
            ),
            if (centerButtons != null) centerButtons!,
          ].addInBetween(const SizedBox(height: 21)),
        ),
      ),
    );
  }
}
