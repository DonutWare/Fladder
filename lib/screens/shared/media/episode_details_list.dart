import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/media/episode_posters.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

enum EpisodeDetailsViewType {
  list(icon: IconsaxPlusBold.grid_6),
  grid(icon: IconsaxPlusBold.grid_2);

  const EpisodeDetailsViewType({required this.icon});

  String label(BuildContext context) => switch (this) {
        EpisodeDetailsViewType.list => context.localized.list,
        EpisodeDetailsViewType.grid => context.localized.grid,
      };

  final IconData icon;
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
              List<Widget> children = [
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
                                Opacity(
                                  opacity: 0.65,
                                  child: SelectableText(
                                    episode.seasonEpisodeLabel(context),
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                if (episode.overview.runTime != null)
                                  Opacity(
                                    opacity: 0.65,
                                    child: SelectableText(
                                      " - ${episode.overview.runTime!.humanize!}",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                              ],
                            ),
                            SelectableText(
                              episode.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: constraints.maxWidth > 800
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
          ),
        EpisodeDetailsViewType.grid => GridView.builder(
            shrinkWrap: true,
            padding: padding,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.toInt(),
                mainAxisSpacing: (8 * decimals) + 8,
                crossAxisSpacing: (8 * decimals) + 8,
                childAspectRatio: 1.67),
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              return EpisodePoster(
                episode: episode,
                actions: episode.generateActions(context, ref),
                onTap: () => episode.navigateTo(context),
                isCurrentEpisode: false,
              );
            },
          )
      },
    );
  }
}
