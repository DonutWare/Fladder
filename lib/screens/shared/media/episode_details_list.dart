import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/media/episode_posters.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/theme_extensions.dart';
import 'package:fladder/widgets/shared/deferred_build.dart';

class EpisodeViewTypeSelector extends StatelessWidget {
  final List<EpisodeDetailsViewType?> options;
  final EpisodeDetailsViewType? selected;
  final ValueChanged<EpisodeDetailsViewType?> onChanged;
  final bool showLabels;

  const EpisodeViewTypeSelector({
    required this.options,
    required this.selected,
    required this.onChanged,
    this.showLabels = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<EpisodeDetailsViewType?>(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return context.colors.primaryContainer;
          }
          return context.colors.surfaceContainer;
        }),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: showLabels ? 16 : 8)),
        visualDensity: showLabels ? null : VisualDensity.compact,
        elevation: const WidgetStatePropertyAll(5),
        side: const WidgetStatePropertyAll(BorderSide.none),
      ),
      showSelectedIcon: showLabels,
      segments: options.map(
        (e) {
          final label = e?.label(context) ?? context.localized.row;
          return ButtonSegment(
            value: e,
            icon: Icon(e?.icon ?? IconsaxPlusBold.slider_horizontal),
            tooltip: showLabels ? null : label,
            label: showLabels
                ? SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(label),
                    ),
                  )
                : null,
          );
        },
      ).toList(),
      selected: {selected},
      onSelectionChanged: (newOptions) => onChanged(newOptions.first),
    );
  }
}

class EpisodeDetailsList extends ConsumerWidget {
  final EpisodeDetailsViewType viewType;
  final List<EpisodeModel> episodes;
  final EdgeInsets? padding;
  const EpisodeDetailsList({required this.viewType, required this.episodes, this.padding, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context).width /
        ((AdaptiveLayout.poster(context).gridRatio * 2) *
            ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
    final decimals = size - size.toInt();
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
        );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: switch (viewType) {
        EpisodeDetailsViewType.list => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: padding,
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              return LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth > 800;
                  // Outer and inner card padding, plus the gap between poster and text when side by side.
                  final posterWidth = wide ? (constraints.maxWidth - 32 - 16) / 4 : constraints.maxWidth - 32;
                  final placeholderHeight = posterWidth / 1.76 + 32 + (wide ? 0 : 120);
                  return DeferredBuild(
                    placeholderHeight: placeholderHeight,
                    builder: (context) {
                      final children = [
                        Flexible(
                          flex: 1,
                          child: EpisodePoster(
                            episode: episode,
                            showLabel: false,
                            actions: episode.generateActions(context, ref),
                            onTap: () => episode.navigateTo(context),
                            isCurrentEpisode: false,
                          ),
                        ),
                        const SizedBox(width: 16, height: 16),
                        Flexible(
                          flex: 3,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SelectableText(
                                          episode.seasonEpisodeLabel(context.localized),
                                          style: textStyle,
                                        ),
                                        if (episode.overview.runTime != null)
                                          SelectableText(
                                            " - ${episode.overview.runTime!.humanize!}",
                                            style: textStyle,
                                          ),
                                      ],
                                    ),
                                    SelectableText(
                                      episode.name,
                                      style:
                                          Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    SelectableText(
                                      episode.overview.summary,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ].addPadding(const EdgeInsets.symmetric(vertical: 4)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: wide
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: children,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: children,
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        EpisodeDetailsViewType.grid => GridView.builder(
            shrinkWrap: true,
            padding: padding,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.toInt().clamp(1, double.maxFinite).toInt(),
                mainAxisSpacing: (8 * decimals) + 8,
                crossAxisSpacing: (8 * decimals) + 8,
                childAspectRatio: 1.67),
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              // The grid delegate sizes the cell, so the placeholder height doesn't matter here.
              return DeferredBuild(
                placeholderHeight: 0,
                builder: (context) => EpisodePoster(
                  episode: episode,
                  actions: episode.generateActions(context, ref),
                  onTap: () => episode.navigateTo(context),
                  isCurrentEpisode: false,
                ),
              );
            },
          )
      },
    );
  }
}
