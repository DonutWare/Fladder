import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/items/book_details_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/media/components/media_play_button.dart';
import 'package:fladder/screens/shared/media/expanding_overview.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/screens/shared/media/poster_list_item.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/widget_extensions.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/selectable_icon_button.dart';

class BookDetailScreen extends ConsumerStatefulWidget {
  final BookModel item;
  const BookDetailScreen({required this.item, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel> get provider =>
      bookDetailsProvider(widget.item.id);

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(provider);
    return DetailScaffold(
      label: widget.item.name,
      item: details.book,
      actions: (context) => details.book?.generateActions(
        context,
        ref,
        exclude: {
          ItemActions.play,
          ItemActions.playFromStart,
          ItemActions.details,
        },
        onDeleteSuccesFully: (item) {
          if (context.mounted) {
            context.router.popBack();
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
      onRefresh: () async => await ref.read(provider.notifier).fetchDetails(widget.item),
      backDrops: details.cover,
      content: (padding) => details.book != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (details.nextUp != null)
                              OverviewHeader(
                                subTitle: details.book?.parentName ?? details.parentModel?.name,
                                name: details.nextUp?.name ?? "",
                                image: ImagesData(
                                  logo: details.book?.getPosters?.primary,
                                ),
                                centerButtons: Builder(
                                  builder: (context) {
                                    //Wrapped so the correct context is used for refreshing the pages
                                    return MediaPlayButton(
                                      item: details.nextUp!,
                                      onPressed: () async => details.nextUp.play(context, ref, provider: provider),
                                    );
                                  },
                                ),
                                productionYear: details.nextUp!.overview.productionYear,
                                runTime: details.nextUp!.overview.runTime,
                                genres: details.nextUp!.overview.genreItems,
                                studios: details.nextUp!.overview.studios,
                                officialRating: details.nextUp!.overview.parentalRating,
                                communityRating: details.nextUp!.overview.communityRating,
                              ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (details.parentModel != null)
                                  SelectableIconButton(
                                    onPressed: () async => await details.parentModel?.navigateTo(context),
                                    selected: false,
                                    selectedIcon: IconsaxPlusBold.book,
                                    icon: IconsaxPlusLinear.book,
                                  ),
                                if (details.parentModel != null)
                                  SelectableIconButton(
                                    onPressed: () async => await ref.read(userProvider.notifier).setAsFavorite(
                                        !details.parentModel!.userData.isFavourite, details.parentModel!.id),
                                    selected: details.parentModel!.userData.isFavourite,
                                    selectedIcon: IconsaxPlusBold.heart,
                                    icon: IconsaxPlusLinear.heart,
                                  )
                                else
                                  SelectableIconButton(
                                    onPressed: () async => await ref
                                        .read(userProvider.notifier)
                                        .setAsFavorite(!details.book!.userData.isFavourite, details.book!.id),
                                    selected: details.book!.userData.isFavourite,
                                    selectedIcon: IconsaxPlusBold.heart,
                                    icon: IconsaxPlusLinear.heart,
                                  ),

                                //This one toggles all books in a collection
                                Builder(builder: (context) {
                                  return Tooltip(
                                    message: "Mark all chapters as read",
                                    child: SelectableIconButton(
                                      onPressed: () async => await Future.forEach(
                                          details.allBooks,
                                          (element) async => await ref
                                              .read(userProvider.notifier)
                                              .markAsPlayed(!details.collectionPlayed, element.id)),
                                      selected: details.collectionPlayed,
                                      selectedIcon: Icons.check_circle_rounded,
                                      icon: Icons.check_circle_outline_rounded,
                                    ),
                                  );
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ).padding(padding),
                  if (details.nextUp!.overview.summary.isNotEmpty == true)
                    ExpandingOverview(
                      text: details.nextUp!.overview.summary,
                    ).padding(padding),
                  if (details.chapters.length > 1)
                    Builder(
                      builder: (context) {
                        final parentContext = context;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.localized.chapter(details.chapters.length),
                                style: Theme.of(context).textTheme.titleLarge),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Divider(),
                            ),
                            ...details.chapters.map(
                              (e) {
                                final current = e == details.nextUp;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Opacity(
                                    opacity: e.userData.played ? 0.65 : 1,
                                    child: Card(
                                      color: current ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
                                      child: PosterListItem(
                                        poster: e,
                                        onPressed: (action, item) => showBottomSheetPill(
                                          context: context,
                                          item: item,
                                          content: (context, scrollController) => ListView(
                                            shrinkWrap: true,
                                            controller: scrollController,
                                            children: item
                                                .generateActions(
                                                  parentContext,
                                                  ref,
                                                )
                                                .listTileItems(context, useIcons: true),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ).padding(padding);
                      },
                    ),
                  if (details.nextUp?.overview.externalUrls?.isNotEmpty == true)
                    Padding(
                      padding: padding,
                      child: ExternalUrlsRow(
                        urls: details.nextUp?.overview.externalUrls,
                      ),
                    )
                ].addPadding(const EdgeInsets.symmetric(vertical: 16)),
              ),
            )
          : Container(),
    );
  }
}
