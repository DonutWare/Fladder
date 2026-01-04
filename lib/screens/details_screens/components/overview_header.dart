import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/shared/media/components/media_header.dart';
import 'package:fladder/screens/shared/media/components/small_detail_widgets.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/list_padding.dart';

class OverviewHeader extends ConsumerWidget {
  final String name;
  final double? minHeight;
  final bool disableheader;
  final ImagesData? image;
  final Widget? mainButton;
  final Widget? poster;
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
    this.minHeight,
    this.disableheader = false,
    this.image,
    this.mainButton,
    this.poster,
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

    final isPhone = AdaptiveLayout.viewSizeOf(context) == ViewSize.phone;

    final crossAlignment = !isPhone ? CrossAxisAlignment.start : CrossAxisAlignment.stretch;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight ?? fullHeight,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: crossAlignment,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            if (!isPhone)
              Flexible(
                child: Row(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (poster != null) poster!,
                    Flexible(
                      child: ExcludeFocus(
                        child: MediaHeader(
                          name: name,
                          logo: image?.logo,
                          onTap: onTitleClicked,
                          alignment: logoAlignment,
                        ),
                      ),
                    )
                  ],
                ),
              )
            else
              Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (poster != null) poster!,
                  ExcludeFocus(
                    child: MediaHeader(
                      name: name,
                      logo: image?.logo,
                      onTap: onTitleClicked,
                      alignment: logoAlignment,
                    ),
                  )
                ],
              ),
            ExcludeFocus(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAlignment,
                children: [
                  if (subTitle != null && name.toLowerCase() != subTitle!.toLowerCase())
                    Flexible(
                      child: SelectableText(
                        subTitle ?? "",
                        textAlign: TextAlign.center,
                        style: mainStyle,
                        maxLines: 1,
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
                spacing: 10,
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
                        _SimpleLabel(
                          icon: null,
                          label: Text(officialRating.toString()),
                        ),
                      if (productionYear != null)
                        _SimpleLabel(
                          icon: IconsaxPlusBold.calendar,
                          color: Theme.of(context).colorScheme.surfaceBright,
                          label: SelectableText(
                            productionYear.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (runTime != null && (runTime?.inSeconds ?? 0) > 1)
                        _SimpleLabel(
                          icon: IconsaxPlusBold.timer,
                          color: Theme.of(context).colorScheme.surfaceBright,
                          iconColor: Theme.of(context).colorScheme.onSurface,
                          label: SelectableText(
                            runTime.humanize.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (communityRating != null && communityRating != 0.0)
                        _SimpleLabel(
                          icon: IconsaxPlusBold.star_1,
                          color: Theme.of(context).colorScheme.tertiaryContainer,
                          iconColor: Theme.of(context).colorScheme.onTertiaryContainer,
                          label: Text(
                            communityRating?.toStringAsFixed(2) ?? "",
                          ),
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
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  if (genres.isNotEmpty)
                    Genres(
                      genres: genres.take(6).toList(),
                    ),
                ],
              ),
            ),
            if (AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone) ...[
              if (mainButton != null) mainButton!,
              if (centerButtons != null) centerButtons!,
            ] else
              Flexible(
                child: Row(
                  spacing: 16,
                  children: [
                    if (mainButton != null) ...[
                      mainButton!,
                      Container(
                        width: 2,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(64),
                          borderRadius: FladderTheme.smallShape.borderRadius,
                        ),
                      )
                    ],
                    if (centerButtons != null) centerButtons!,
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SimpleLabel extends StatelessWidget {
  final IconData? icon;
  final Widget label;
  final Color? color;
  final Color? iconColor;
  const _SimpleLabel({
    this.icon,
    required this.label,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: FladderTheme.smallShape.borderRadius,
        color: (color ?? Theme.of(context).colorScheme.surfaceBright).withAlpha(200),
        border: Border.all(
          color: (color ?? Theme.of(context).colorScheme.surfaceBright).withAlpha(255),
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: iconColor ?? Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 4),
            ],
            label,
          ],
        ),
      ),
    );
  }
}
