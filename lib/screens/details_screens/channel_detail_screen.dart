import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/providers/items/channel_details_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/details_screens/components/channel_program_item.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/media/components/media_play_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/selectable_icon_button.dart';

class ChannelDetailScreen extends ConsumerStatefulWidget {
  final ChannelModel item;
  const ChannelDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelDetailScreenState();
}

class _ChannelDetailScreenState extends ConsumerState<ChannelDetailScreen> {
  ChannelDetailsProvider get providerInstance => channelDetailsProvider(widget.item.id);

  @override
  Widget build(BuildContext context) {
    final channel = ref.watch(providerInstance);
    final wrapAlignment =
        AdaptiveLayout.viewSizeOf(context) != ViewSize.phone ? WrapAlignment.start : WrapAlignment.center;

    return DetailScaffold(
      label: channel?.name ?? '',
      item: channel,
      actions: (context) => channel?.generateActions(
        context,
        ref,
        exclude: {
          ItemActions.openShow,
          ItemActions.details,
        },
        onDeleteSuccesFully: (item) {
          if (context.mounted) {
            context.router.popBack();
          }
        },
      ),
      onRefresh: () async => await ref.read(providerInstance.notifier).fetchDetails(widget.item.id),
      content: (context, padding) => channel != null
          ? Padding(
              padding: const EdgeInsets.only(top: 64).add(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OverviewHeader(
                    name: channel.name,
                    image: channel.images?.copyWith(
                      logo: () => channel.images?.primary,
                    ),
                    mainButton: MediaPlayButton(
                      item: channel,
                      onPressed: (restart) {
                        channel.play(context, ref);
                      },
                    ),
                    minHeight: 50,
                    centerButtons: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: wrapAlignment,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SelectableIconButton(
                          onPressed: () async {
                            await ref
                                .read(userProvider.notifier)
                                .setAsFavorite(!channel.userData.isFavourite, channel.id);
                          },
                          selected: channel.userData.isFavourite,
                          selectedIcon: IconsaxPlusBold.heart,
                          icon: IconsaxPlusLinear.heart,
                        ),
                        SelectableIconButton(
                          onPressed: () async {
                            await showBottomSheetPill(
                              context: context,
                              content: (context, scrollController) => ListView(
                                controller: scrollController,
                                shrinkWrap: true,
                                children: channel.generateActions(context, ref).listTileItems(context, useIcons: true),
                              ),
                            );
                          },
                          selected: false,
                          icon: IconsaxPlusLinear.more,
                        ),
                      ],
                    ),
                  ),
                  ...channel.programsMap.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat.yMMMMd().format(e.key),
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Divider(),
                          ...e.value.map(
                            (program) => ChannelProgramItem(program: program),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
