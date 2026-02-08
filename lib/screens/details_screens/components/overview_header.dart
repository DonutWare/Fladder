import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/details_screens/components/media_stream_information.dart';
import 'package:fladder/screens/shared/media/components/media_header.dart';
import 'package:fladder/screens/shared/media/components/small_detail_widgets.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/position_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/focus_row.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

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
  final List<SimpleLabel> additionalLabels;
  final String? productionYear;
  final Widget? summary;
  final Duration? runTime;
  final String? officialRating;
  final double? communityRating;
  final List<Studio> studios;
  final List<GenreItems> genres;
  final MediaStreamHelper? mediaStreamHelper;
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
    this.additionalLabels = const [],
    this.productionYear,
    this.summary,
    this.runTime,
    this.officialRating,
    this.communityRating,
    this.genres = const [],
    this.studios = const [],
    this.mediaStreamHelper,
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

    final streamHeight = 43.0;

    final streamOptionsButtons = [
      SizedBox(
        height: streamHeight,
        child: EnumBox(
          onFocusChanged: (focused) {
            if (focused) {
              context.ensureVisible(alignment: 1.0);
            }
          },
          currentWidget: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(
                IconsaxPlusLinear.video_square,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Text(
                mediaStreamHelper?.mediaStream.currentVersionStream?.detailedResolutionLabel ?? "",
              ),
            ],
          ),
          itemBuilder: (context) => mediaStreamHelper!.mediaStream.versionStreams
              .mapIndexed((index, e) => ItemActionButton(
                    selected: mediaStreamHelper!.mediaStream.currentVersionStream == e,
                    label: Text(e.name),
                    action: () {
                      final newItem = mediaStreamHelper!.mediaStream.copyWith(
                        versionStreamIndex: e.index,
                      );
                      mediaStreamHelper!.onItemChanged?.call(newItem);
                    },
                  ))
              .toList(),
        ),
      ),
      SizedBox(
        height: streamHeight,
        child: EnumBox(
          onFocusChanged: (focused) {
            if (focused) {
              context.ensureVisible(alignment: 1.0);
            }
          },
          currentWidget: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(
                IconsaxPlusLinear.audio_square,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Text(
                mediaStreamHelper?.mediaStream.currentAudioStream?.shortTitle ?? "",
              ),
            ],
          ),
          itemBuilder: (context) => mediaStreamHelper!.mediaStream.audioStreams
              .mapIndexed((index, e) => ItemActionButton(
                    selected: mediaStreamHelper!.mediaStream.currentAudioStream == e,
                    label: Text(e.displayTitle),
                    action: () {
                      final newItem = mediaStreamHelper!.mediaStream.copyWith(
                        defaultAudioStreamIndex: e.index,
                      );
                      mediaStreamHelper!.onItemChanged?.call(newItem);
                    },
                  ))
              .toList(),
        ),
      ),
      SizedBox(
        height: streamHeight,
        child: EnumBox(
          onFocusChanged: (focused) {
            if (focused) {
              context.ensureVisible(alignment: 1.0);
            }
          },
          currentWidget: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(
                IconsaxPlusLinear.subtitle,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Text(
                (mediaStreamHelper?.mediaStream.currentSubStream?.shortTitle ?? context.localized.off).toUpperCase(),
              ),
            ],
          ),
          itemBuilder: (context) => mediaStreamHelper!.mediaStream.subStreams
              .mapIndexed((index, e) => ItemActionButton(
                    selected: mediaStreamHelper!.mediaStream.currentSubStream == e,
                    label: Text(e.displayTitle),
                    action: () {
                      final newItem = mediaStreamHelper!.mediaStream.copyWith(
                        defaultSubStreamIndex: e.index,
                      );
                      mediaStreamHelper!.onItemChanged?.call(newItem);
                    },
                  ))
              .toList(),
        ),
      )
    ].withPositionProvider();

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
          spacing: 12,
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
                        child: Center(
                          child: MediaHeader(
                            name: name,
                            logo: image?.logo,
                            onTap: onTitleClicked,
                            alignment: logoAlignment,
                          ),
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
                    child: Center(
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
            Column(
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: crossAlignment,
              spacing: 10,
              children: [
                MetadataLabels(
                  officialRating: officialRating,
                  productionYear: productionYear,
                  runTime: runTime,
                  communityRating: communityRating,
                ),
                if (genres.isNotEmpty)
                  Genres(
                    genres: genres.take(6).toList(),
                  ),
                if (additionalLabels.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: additionalLabels,
                  ),
              ],
            ),
            if (summary != null) summary!,
            if (AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone)
              Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  if (mainButton != null) mainButton!,
                  if (mediaStreamHelper != null)
                    Center(
                      child: FittedBox(
                        child: Row(
                          spacing: 4,
                          mainAxisSize: MainAxisSize.min,
                          children: streamOptionsButtons,
                        ),
                      ),
                    ),
                  if (centerButtons != null) centerButtons!,
                ].addInBetween(
                  Center(
                    child: Container(
                      width: 12,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(64),
                        borderRadius: FladderTheme.smallShape.borderRadius,
                      ),
                    ),
                  ),
                ),
              )
            else
              Flexible(
                child: FocusRow(
                  ensureVisibleAlignment: 1.0,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      mainButton,
                      if (mediaStreamHelper != null)
                        Row(
                          spacing: 4,
                          mainAxisSize: MainAxisSize.min,
                          children: streamOptionsButtons,
                        ),
                      centerButtons,
                    ].nonNulls.toList().addInBetween(
                          Container(
                            width: 4,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(64),
                              borderRadius: FladderTheme.smallShape.borderRadius,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MetadataLabels extends StatelessWidget {
  final bool? favourite;
  final String? officialRating;
  final String? productionYear;
  final Duration? runTime;
  final double? communityRating;
  final bool? watched;

  const MetadataLabels({
    this.favourite,
    this.officialRating,
    this.productionYear,
    this.runTime,
    this.communityRating,
    this.watched,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (officialRating != null)
          SimpleLabel(
            icon: null,
            label: Text(officialRating.toString()),
          ),
        if (productionYear != null)
          SimpleLabel(
            icon: IconsaxPlusBold.calendar,
            color: Theme.of(context).colorScheme.surfaceBright,
            label: SelectableText(
              productionYear.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        if (runTime != null && (runTime?.inSeconds ?? 0) > 1)
          SimpleLabel(
            icon: IconsaxPlusBold.timer,
            color: Theme.of(context).colorScheme.surfaceBright,
            iconColor: Theme.of(context).colorScheme.onSurface,
            label: SelectableText(
              runTime.humanize.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        if (communityRating != null && communityRating != 0.0)
          SimpleLabel(
            icon: IconsaxPlusBold.star_1,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            iconColor: Theme.of(context).colorScheme.onTertiaryContainer,
            label: Text(
              communityRating?.toStringAsFixed(2) ?? "",
            ),
          ),
        if (watched != null)
          SimpleLabel(
            icon: watched == true ? IconsaxPlusBold.eye : IconsaxPlusLinear.eye_slash,
            color: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.onPrimary,
          ),
        if (favourite != null)
          SimpleLabel(
            icon: favourite == true ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
            color: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.onError,
          ),
      ].addInBetween(CircleAvatar(
        radius: 3,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      )),
    );
  }
}

class SimpleLabel extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final Widget? label;
  final Color? color;
  final Color? iconColor;
  const SimpleLabel({
    this.icon,
    this.iconWidget,
    this.label,
    this.color,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = (color ?? Theme.of(context).colorScheme.surfaceBright)
        .harmonizeWith(Theme.of(context).colorScheme.primaryContainer);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: FladderTheme.smallShape.borderRadius,
        color: backgroundColor.withAlpha(200),
        border: Border.all(
          color: backgroundColor.withAlpha(255),
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: iconColor ?? Theme.of(context).colorScheme.onSurface,
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 21,
                color: iconColor ?? Theme.of(context).colorScheme.onSurface,
              ),
            if (iconWidget != null) iconWidget!,
            if (label != null) label!
          ],
        ),
      ),
    );
  }
}
