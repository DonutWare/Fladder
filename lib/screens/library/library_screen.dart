import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/recommended_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/library_screen_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/home_screen.dart';
import 'package:fladder/screens/metadata/refresh_metadata.dart';
import 'package:fladder/screens/shared/media/poster_row.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/nested_sliver_appbar.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/button_group.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState>? refreshKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final libraryScreenState = ref.watch(libraryScreenProvider);
    final views = libraryScreenState.views;
    final recommendations = libraryScreenState.recommendations;
    final favourites = libraryScreenState.favourites;
    final selectedView = libraryScreenState.selectedViewModel;
    final viewTypes = libraryScreenState.viewType;
    final genres = libraryScreenState.genres;
    final padding = AdaptiveLayout.adaptivePadding(context);
    return NestedScaffold(
      background: BackgroundImage(
        items: [
          ...recommendations.expand((e) => e.posters),
          ...favourites,
        ],
      ),
      body: PullToRefresh(
        refreshOnStart: true,
        refreshKey: refreshKey,
        onRefresh: () => ref.read(libraryScreenProvider.notifier).fetchAllLibraries(),
        child: SizedBox.expand(
          child: CustomScrollView(
            controller: AdaptiveLayout.scrollOf(context, HomeTabs.library),
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const DefaultSliverTopBadding(),
              if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
                NestedSliverAppBar(
                  route: LibrarySearchRoute(),
                  parent: context,
                ),
              if (views.isNotEmpty)
                SliverToBoxAdapter(
                  child: LibraryRow(
                    padding: padding,
                    views: views,
                    selectedView: libraryScreenState.selectedViewModel,
                    onSelected: (view) {
                      ref.read(libraryScreenProvider.notifier).selectLibrary(view);
                      refreshKey?.currentState?.show();
                    },
                  ),
                ),
              if (selectedView != null)
                SliverToBoxAdapter(
                  child: FocusTraversalGroup(
                    policy: ReadingOrderTraversalPolicy(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: SizedBox(
                        height: 40,
                        child: ListView(
                          padding: padding,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            FilledButton.tonalIcon(
                              onPressed: () => context.pushRoute(LibrarySearchRoute(viewModelId: selectedView.id)),
                              label: Text("${context.localized.search} ${selectedView.name}..."),
                              icon: const Icon(IconsaxPlusLinear.search_normal),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: VerticalDivider(),
                            ),
                            ExpressiveButtonGroup(
                              multiSelection: true,
                              options: LibraryViewType.values
                                  .map((element) => ButtonGroupOption(
                                      value: element,
                                      icon: Icon(element.icon),
                                      selected: Icon(element.iconSelected),
                                      child: Text(
                                        element.label(context),
                                      )))
                                  .toList(),
                              selectedValues: viewTypes,
                              onSelected: (value) {
                                ref.read(libraryScreenProvider.notifier).setViewType(value);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: VerticalDivider(),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => showRefreshPopup(context, selectedView.id, selectedView.name),
                              label: Text(context.localized.scanLibrary),
                              icon: const Icon(IconsaxPlusLinear.refresh),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (viewTypes.isEmpty)
                SliverFillRemaining(
                  child: Center(child: Text(context.localized.noResults)),
                ),
              if (viewTypes.contains(LibraryViewType.recommended)) ...[
                if (recommendations.isNotEmpty)
                  ...recommendations.where((element) => element.posters.isNotEmpty).map(
                        (element) => SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PosterRow(
                              contentPadding: padding,
                              posters: element.posters,
                              label: element.type != null
                                  ? "${element.type?.label(context)} - ${element.name.label(context)}"
                                  : element.name.label(context),
                            ),
                          ),
                        ),
                      ),
              ],
              if (viewTypes.contains(LibraryViewType.favourites))
                if (favourites.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PosterRow(
                        contentPadding: padding,
                        onLabelClick: () => context.pushRoute(
                          LibrarySearchRoute(
                            viewModelId: libraryScreenState.selectedViewModel?.id ?? "",
                          ).withFilter(
                            const LibraryFilterModel(
                              favourites: true,
                              recursive: true,
                            ),
                          ),
                        ),
                        posters: favourites,
                        label: context.localized.favorites,
                      ),
                    ),
                  ),
              if (viewTypes.contains(LibraryViewType.genres)) ...[
                if (genres.isNotEmpty)
                  ...genres.where((element) => element.posters.isNotEmpty).map(
                        (element) => SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PosterRow(
                              contentPadding: padding,
                              posters: element.posters,
                              onLabelClick: () => context.pushRoute(
                                LibrarySearchRoute(
                                  viewModelId: libraryScreenState.selectedViewModel?.id ?? "",
                                ).withFilter(
                                  LibraryFilterModel(
                                    recursive: true,
                                    genres: {(element.name as Other).customLabel: true},
                                  ),
                                ),
                              ),
                              label: element.type != null
                                  ? "${element.type?.label(context)} - ${element.name.label(context)}"
                                  : element.name.label(context),
                            ),
                          ),
                        ),
                      )
              ],
              const DefautlSliverBottomPadding(),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryRow extends ConsumerWidget {
  const LibraryRow({
    super.key,
    required this.views,
    this.selectedView,
    required this.padding,
    this.onSelected,
  });

  final List<ViewModel> views;
  final ViewModel? selectedView;
  final EdgeInsets padding;
  final FutureOr Function(ViewModel selected)? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HorizontalList(
      label: context.localized.library(views.length),
      items: views,
      height: 155,
      autoFocus: true,
      startIndex: selectedView != null ? views.indexOf(selectedView!) : null,
      contentPadding: padding,
      itemBuilder: (context, index, selected) {
        final view = views[index];
        final isSelected = selectedView == view;
        final List<ItemActionButton> viewActions = [
          ItemActionButton(
            label: Text(context.localized.search),
            icon: const Icon(IconsaxPlusLinear.search_normal),
            action: () => context.pushRoute(LibrarySearchRoute(viewModelId: view.id)),
          ),
          ItemActionButton(
            label: Text(context.localized.scanLibrary),
            icon: const Icon(IconsaxPlusLinear.refresh),
            action: () => showRefreshPopup(context, view.id, view.name),
          )
        ];
        return FocusButton(
          key: Key(view.id),
          onTap: isSelected ? null : () => onSelected?.call(view),
          onLongPress: () => context.pushRoute(LibrarySearchRoute(viewModelId: view.id)),
          onSecondaryTapDown: (details) async {
            Offset localPosition = details.globalPosition;
            RelativeRect position =
                RelativeRect.fromLTRB(localPosition.dx, localPosition.dy, localPosition.dx, localPosition.dy);
            await showMenu(
              context: context,
              position: position,
              items: viewActions.popupMenuItems(useIcons: true),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: FladderTheme.defaultShape.borderRadius,
                ),
                clipBehavior: Clip.hardEdge,
                width: 200,
                child: ClipRRect(
                  borderRadius: FladderTheme.smallShape.borderRadius,
                  child: AspectRatio(
                    aspectRatio: 1.60,
                    child: FladderImage(
                      image: view.imageData?.primary,
                      fit: BoxFit.cover,
                      placeHolder: Center(
                        child: Text(
                          view.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                view.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              )
            ],
          ),
        );
      },
    );
  }
}
