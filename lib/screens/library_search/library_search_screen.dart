import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playlist_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/collections/add_to_collection.dart';
import 'package:fladder/screens/library_search/widgets/library_filter_chips.dart';
import 'package:fladder/screens/library_search/widgets/library_play_options_.dart';
import 'package:fladder/screens/library_search/widgets/library_saved_filters.dart';
import 'package:fladder/screens/library_search/widgets/library_sort_dialogue.dart';
import 'package:fladder/screens/library_search/widgets/library_views.dart';
import 'package:fladder/screens/library_search/widgets/suggestion_search_bar.dart';
import 'package:fladder/screens/playlists/add_to_playlists.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/nested_bottom_appbar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/fab_extended_anim.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/floating_player_bar.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/fladder_scrollbar.dart';
import 'package:fladder/widgets/shared/hide_on_scroll.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/poster_size_slider.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';
import 'package:fladder/widgets/shared/scroll_position.dart';
import 'package:fladder/widgets/shared/shapes.dart';

@RoutePage()
class LibrarySearchScreen extends ConsumerStatefulWidget {
  final String? viewModelId;
  final bool? favourites;
  final List<String>? folderId;
  final SortingOrder? sortOrder;
  final SortingOptions? sortingOptions;
  final PhotoModel? photoToView;
  const LibrarySearchScreen({
    @QueryParam("parentId") this.viewModelId,
    @QueryParam("folderId") this.folderId,
    @QueryParam("favourites") this.favourites,
    @QueryParam("sortOrder") this.sortOrder,
    @QueryParam("sortOptions") this.sortingOptions,
    this.photoToView,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibrarySearchScreenState();
}

class _LibrarySearchScreenState extends ConsumerState<LibrarySearchScreen> {
  final SearchController searchController = SearchController();
  final Debouncer debouncer = Debouncer(const Duration(seconds: 1));
  final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController scrollController = ScrollController();
  late double lastScale = 0;

  bool loadOnStart = false;

  Key get uniqueKey => Key(widget.folderId?.join(',').toString() ?? widget.viewModelId ?? "EmptySearch");
  AutoDisposeStateNotifierProvider<LibrarySearchNotifier, LibrarySearchModel> get providerKey =>
      librarySearchProvider(uniqueKey);
  LibrarySearchNotifier get libraryProvider => ref.read(librarySearchProvider(uniqueKey).notifier);

  @override
  void didUpdateWidget(covariant LibrarySearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kIsWeb && ref.read(librarySearchProvider(uniqueKey)).posters.isEmpty) {
      initLibrary();
    }
  }

  @override
  void initState() {
    super.initState();
    initLibrary();
  }

  void initLibrary() {
    searchController.addListener(() {
      debouncer.run(() {
        ref.read(providerKey.notifier).setSearch(searchController.text);
      });
    });

    Future.microtask(
      () async {
        await refreshKey.currentState?.show();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [],
        );

        if (context.mounted && widget.photoToView != null) {
          libraryProvider.viewGallery(context, selected: widget.photoToView);
        }
        scrollController.addListener(() {
          scrollPosition();
        });
      },
    );
  }

  void scrollPosition() {
    if (scrollController.position.pixels > scrollController.position.maxScrollExtent * 0.65) {
      libraryProvider.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmptySearchScreen = widget.viewModelId == null && widget.favourites == null && widget.folderId == null;
    final librarySearchResults = ref.watch(providerKey);
    final postersList = librarySearchResults.posters.hideEmptyChildren(librarySearchResults.hideEmptyShows);
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));
    final libraryViewType = ref.watch(libraryViewTypeProvider);

    ref.listen(
      providerKey,
      (previous, next) {
        if (previous != next) {
          refreshKey.currentState?.show();
          scrollController.jumpTo(0);
        }
      },
    );

    return PopScope(
      key: uniqueKey,
      canPop: !librarySearchResults.selecteMode,
      onPopInvokedWithResult: (didPop, result) {
        if (librarySearchResults.selecteMode) {
          libraryProvider.toggleSelectMode();
        }
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation:
            playerState == VideoPlayerState.minimized ? FloatingActionButtonLocation.centerFloat : null,
        floatingActionButton: switch (playerState) {
          VideoPlayerState.minimized => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: FloatingPlayerBar(),
            ),
          _ => HideOnScroll(
              controller: scrollController,
              visibleBuilder: (visible) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (librarySearchResults.activePosters.isNotEmpty)
                    FloatingActionButtonAnimated(
                      key: Key(context.localized.playLabel),
                      isExtended: visible,
                      tooltip: context.localized.playVideos,
                      onPressed: () async {
                        if (librarySearchResults.showGalleryButtons && !librarySearchResults.showPlayButtons) {
                          libraryProvider.viewGallery(context);
                          return;
                        } else if (!librarySearchResults.showGalleryButtons && librarySearchResults.showPlayButtons) {
                          libraryProvider.playLibraryItems(context, ref);
                          return;
                        }

                        await showLibraryPlayOptions(
                          context,
                          context.localized.libraryPlayItems,
                          playVideos: librarySearchResults.showPlayButtons
                              ? () => libraryProvider.playLibraryItems(context, ref)
                              : null,
                          viewGallery: librarySearchResults.showGalleryButtons
                              ? () => libraryProvider.viewGallery(context)
                              : null,
                        );
                      },
                      label: Text(context.localized.playLabel),
                      icon: const Icon(IconsaxBold.play),
                    ),
                ].addInBetween(const SizedBox(height: 10)),
              ),
            ),
        },
        bottomNavigationBar: HideOnScroll(
          controller: AdaptiveLayout.of(context).isDesktop ? null : scrollController,
          child: IgnorePointer(
            ignoring: librarySearchResults.fetchingItems,
            child: _LibrarySearchBottomBar(
              uniqueKey: uniqueKey,
              refreshKey: refreshKey,
              scrollController: scrollController,
              libraryProvider: libraryProvider,
              postersList: postersList,
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Card(
                elevation: 1,
                child: PinchPosterZoom(
                  scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference),
                  child: MediaQuery.removeViewInsets(
                    context: context,
                    child: ClipRRect(
                      borderRadius: AdaptiveLayout.of(context).layout == LayoutState.desktop
                          ? BorderRadius.circular(15)
                          : BorderRadius.circular(0),
                      child: FladderScrollbar(
                        visible: AdaptiveLayout.of(context).inputDevice != InputDevice.pointer,
                        controller: scrollController,
                        child: PullToRefresh(
                          refreshKey: refreshKey,
                          autoFocus: false,
                          contextRefresh: false,
                          onRefresh: () async {
                            if (libraryProvider.mounted) {
                              return libraryProvider.initRefresh(
                                widget.folderId,
                                widget.viewModelId,
                                widget.favourites,
                                widget.sortOrder,
                                widget.sortingOptions,
                              );
                            }
                          },
                          refreshOnStart: false,
                          child: CustomScrollView(
                            physics: const AlwaysScrollableNoImplicitScrollPhysics(),
                            controller: scrollController,
                            slivers: [
                              SliverAppBar(
                                floating: !AdaptiveLayout.of(context).isDesktop,
                                collapsedHeight: 80,
                                automaticallyImplyLeading: false,
                                pinned: AdaptiveLayout.of(context).isDesktop,
                                primary: true,
                                elevation: 5,
                                leading: context.router.backButton(),
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                backgroundColor: Theme.of(context).colorScheme.surface,
                                shape: AppBarShape(),
                                titleSpacing: 4,
                                leadingWidth: 48,
                                actions: [
                                  const SizedBox(width: 4),
                                  Builder(builder: (context) {
                                    final isFavorite =
                                        librarySearchResults.nestedCurrentItem?.userData.isFavourite == true;
                                    final itemActions = librarySearchResults.nestedCurrentItem?.generateActions(
                                          context,
                                          ref,
                                          exclude: {
                                            ItemActions.details,
                                            ItemActions.markPlayed,
                                            ItemActions.markUnplayed,
                                          },
                                          onItemUpdated: (item) {
                                            libraryProvider.updateParentItem(item);
                                          },
                                          onUserDataChanged: (userData) {
                                            libraryProvider.updateUserDataMain(userData);
                                          },
                                        ) ??
                                        [];
                                    final itemCountWidget = ItemActionButton(
                                      label: Text(context.localized.itemCount(librarySearchResults.totalItemCount)),
                                      icon: const Icon(IconsaxBold.document_1),
                                    );
                                    final refreshAction = ItemActionButton(
                                      label: Text(context.localized.forceRefresh),
                                      action: () => refreshKey.currentState?.show(),
                                      icon: const Icon(IconsaxOutline.refresh),
                                    );
                                    final showSavedFiltersDialogue = ItemActionButton(
                                      label: Text(context.localized.filter(2)),
                                      action: () => showSavedFilters(context, librarySearchResults, libraryProvider),
                                      icon: const Icon(IconsaxOutline.refresh),
                                    );
                                    final itemViewAction = ItemActionButton(
                                        label: Text(context.localized.selectViewType),
                                        icon: Icon(libraryViewType.icon),
                                        action: () {
                                          showAdaptiveDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Consumer(
                                                builder: (context, ref, child) {
                                                  final currentType = ref.watch(libraryViewTypeProvider);
                                                  return Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text(context.localized.selectViewType,
                                                          style: Theme.of(context).textTheme.titleMedium),
                                                      const SizedBox(height: 12),
                                                      ...LibraryViewTypes.values
                                                          .map(
                                                            (e) => FilledButton.tonal(
                                                              style: FilledButtonTheme.of(context).style?.copyWith(
                                                                    padding: const WidgetStatePropertyAll(
                                                                        EdgeInsets.symmetric(
                                                                            horizontal: 12, vertical: 24)),
                                                                    backgroundColor: WidgetStateProperty.resolveWith(
                                                                      (states) {
                                                                        if (e != currentType) {
                                                                          return Colors.transparent;
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                  ),
                                                              onPressed: () {
                                                                ref.read(libraryViewTypeProvider.notifier).state = e;
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(e.icon),
                                                                  const SizedBox(width: 12),
                                                                  Text(
                                                                    e.label(context),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList()
                                                          .addInBetween(const SizedBox(height: 12)),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                    return Card(
                                      elevation: 0,
                                      child: Tooltip(
                                        message: librarySearchResults.nestedCurrentItem?.type.label(context) ??
                                            context.localized.library(1),
                                        child: InkWell(
                                          onTapUp: (details) async {
                                            if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer) {
                                              double left = details.globalPosition.dx;
                                              double top = details.globalPosition.dy + 20;
                                              await showMenu(
                                                context: context,
                                                position: RelativeRect.fromLTRB(left, top, 40, 100),
                                                items: <PopupMenuEntry>[
                                                  PopupMenuItem(
                                                      child: Text(
                                                          librarySearchResults.nestedCurrentItem?.type.label(context) ??
                                                              context.localized.library(0))),
                                                  itemCountWidget.toPopupMenuItem(useIcons: true),
                                                  refreshAction.toPopupMenuItem(useIcons: true),
                                                  itemViewAction.toPopupMenuItem(useIcons: true),
                                                  if (librarySearchResults.views.hasEnabled == true)
                                                    showSavedFiltersDialogue.toPopupMenuItem(useIcons: true),
                                                  if (itemActions.isNotEmpty) ItemActionDivider().toPopupMenuItem(),
                                                  ...itemActions.popupMenuItems(useIcons: true),
                                                ],
                                                elevation: 8.0,
                                              );
                                            } else {
                                              await showBottomSheetPill(
                                                context: context,
                                                content: (context, scrollController) => ListView(
                                                  shrinkWrap: true,
                                                  controller: scrollController,
                                                  children: [
                                                    itemCountWidget.toListItem(context, useIcons: true),
                                                    refreshAction.toListItem(context, useIcons: true),
                                                    itemViewAction.toListItem(context, useIcons: true),
                                                    if (librarySearchResults.views.hasEnabled == true)
                                                      showSavedFiltersDialogue.toPopupMenuItem(useIcons: true),
                                                    if (itemActions.isNotEmpty) ItemActionDivider().toListItem(context),
                                                    ...itemActions.listTileItems(context, useIcons: true),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Icon(
                                              isFavorite
                                                  ? librarySearchResults.nestedCurrentItem?.type.selectedicon
                                                  : librarySearchResults.nestedCurrentItem?.type.icon ??
                                                      IconsaxOutline.document,
                                              color: isFavorite ? Theme.of(context).colorScheme.primary : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  if (AdaptiveLayout.of(context).layout == LayoutState.phone) ...[
                                    const SizedBox(width: 6),
                                    const SizedBox.square(dimension: 46, child: SettingsUserIcon()),
                                  ],
                                  const SizedBox(width: 12)
                                ],
                                title: Hero(
                                  tag: "PrimarySearch",
                                  child: SuggestionSearchBar(
                                    autoFocus: isEmptySearchScreen,
                                    key: uniqueKey,
                                    title: librarySearchResults.searchBarTitle(context),
                                    debounceDuration: const Duration(seconds: 1),
                                    onItem: (value) async {
                                      await value.navigateTo(context);
                                      refreshKey.currentState?.show();
                                    },
                                    onSubmited: (value) async {
                                      if (librarySearchResults.searchQuery != value) {
                                        libraryProvider.setSearch(value);
                                        refreshKey.currentState?.show();
                                      }
                                    },
                                  ),
                                ),
                                bottom: PreferredSize(
                                  preferredSize: const Size(0, 50),
                                  child: Transform.translate(
                                    offset: Offset(0, AdaptiveLayout.of(context).isDesktop ? -20 : -15),
                                    child: IgnorePointer(
                                      ignoring: librarySearchResults.loading,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Opacity(
                                            opacity: librarySearchResults.loading ? 0.5 : 1,
                                            child: SingleChildScrollView(
                                              padding: const EdgeInsets.all(8),
                                              scrollDirection: Axis.horizontal,
                                              child: LibraryFilterChips(
                                                controller: scrollController,
                                                libraryProvider: libraryProvider,
                                                librarySearchResults: librarySearchResults,
                                                uniqueKey: uniqueKey,
                                                postersList: postersList,
                                                libraryViewType: libraryViewType,
                                              ),
                                            ),
                                          ),
                                          const Row(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (AdaptiveLayout.of(context).isDesktop)
                                const SliverToBoxAdapter(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      PosterSizeWidget(),
                                    ],
                                  ),
                                ),
                              if (postersList.isNotEmpty)
                                SliverPadding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).padding.left,
                                      right: MediaQuery.of(context).padding.right),
                                  sliver: LibraryViews(
                                    key: uniqueKey,
                                    items: postersList,
                                    groupByType: librarySearchResults.groupBy,
                                  ),
                                )
                              else
                                SliverToBoxAdapter(
                                  child: Center(
                                    child: Text(context.localized.noItemsToShow),
                                  ),
                                ),
                              const DefautlSliverBottomPadding(),
                              const SliverPadding(padding: EdgeInsets.only(bottom: 80))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (librarySearchResults.fetchingItems) ...[
              Container(
                color: Colors.black.withOpacity(0.1),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator.adaptive(),
                        Text(context.localized.fetchingLibrary, style: Theme.of(context).textTheme.titleMedium),
                        IconButton(
                          onPressed: () => libraryProvider.cancelFetch(),
                          icon: const Icon(IconsaxOutline.close_square),
                        )
                      ].addInBetween(const SizedBox(width: 16)),
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}

class AlwaysScrollableNoImplicitScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that always lets the user scroll.
  const AlwaysScrollableNoImplicitScrollPhysics({super.parent});

  @override
  AlwaysScrollableNoImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AlwaysScrollableNoImplicitScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool get allowImplicitScrolling => false;

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;

  @override
  bool recommendDeferredLoading(double velocity, ScrollMetrics metrics, BuildContext context) => false;
}

class _LibrarySearchBottomBar extends ConsumerWidget {
  final Key uniqueKey;
  final ScrollController scrollController;
  final LibrarySearchNotifier libraryProvider;
  final List<ItemBaseModel> postersList;
  final GlobalKey<RefreshIndicatorState> refreshKey;
  const _LibrarySearchBottomBar({
    required this.uniqueKey,
    required this.scrollController,
    required this.libraryProvider,
    required this.postersList,
    required this.refreshKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final librarySearchResults = ref.watch(librarySearchProvider(uniqueKey));
    final actions = [
      ItemActionButton(
        action: () async {
          await libraryProvider.setSelectedAsFavorite(true);
          if (context.mounted) context.refreshData();
        },
        label: Text(context.localized.addAsFavorite),
        icon: const Icon(IconsaxOutline.heart_add),
      ),
      ItemActionButton(
        action: () async {
          await libraryProvider.setSelectedAsFavorite(false);
          if (context.mounted) context.refreshData();
        },
        label: Text(context.localized.removeAsFavorite),
        icon: const Icon(IconsaxOutline.heart_remove),
      ),
      ItemActionButton(
        action: () async {
          await libraryProvider.setSelectedAsWatched(true);
          if (context.mounted) context.refreshData();
        },
        label: Text(context.localized.markAsWatched),
        icon: const Icon(IconsaxOutline.eye),
      ),
      ItemActionButton(
        action: () async {
          await libraryProvider.setSelectedAsWatched(false);
          if (context.mounted) context.refreshData();
        },
        label: Text(context.localized.markAsUnwatched),
        icon: const Icon(IconsaxOutline.eye_slash),
      ),
      if (librarySearchResults.nestedCurrentItem is BoxSetModel)
        ItemActionButton(
            action: () async {
              await libraryProvider.removeSelectedFromCollection();
              if (context.mounted) context.refreshData();
            },
            label: Text(context.localized.removeFromCollection),
            icon: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.onPrimary, borderRadius: BorderRadius.circular(6)),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(IconsaxOutline.save_remove, size: 20),
              ),
            )),
      if (librarySearchResults.nestedCurrentItem is PlaylistModel)
        ItemActionButton(
          action: () async {
            await libraryProvider.removeSelectedFromPlaylist();
            if (context.mounted) context.refreshData();
          },
          label: Text(context.localized.removeFromPlaylist),
          icon: const Icon(IconsaxOutline.save_remove),
        ),
      ItemActionButton(
        action: () async {
          await addItemToCollection(context, librarySearchResults.selectedPosters);
          if (context.mounted) context.refreshData();
        },
        label: Text(context.localized.addToCollection),
        icon: const Icon(
          IconsaxOutline.save_add,
          size: 20,
        ),
      ),
      ItemActionButton(
        action: () async {
          await addItemToPlaylist(context, librarySearchResults.selectedPosters);
          if (context.mounted) context.refreshData();
        },
        label: Text(context.localized.addToPlaylist),
        icon: const Icon(IconsaxOutline.save_add),
      ),
    ];
    return NestedBottomAppBar(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ScrollStatePosition(
                controller: scrollController,
                positionBuilder: (state) => AnimatedFadeSize(
                  child: state != ScrollState.top
                      ? Tooltip(
                          message: context.localized.scrollToTop,
                          child: FlatButton(
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            borderRadiusGeometry: BorderRadius.circular(6),
                            onTap: () => scrollController.animateTo(0,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                IconsaxOutline.arrow_up_3,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
              const SizedBox(width: 6),
              if (!librarySearchResults.selecteMode) ...{
                const SizedBox(width: 6),
                IconButton(
                  tooltip: context.localized.sortBy,
                  onPressed: () async {
                    final newOptions = await openSortByDialogue(
                      context,
                      libraryProvider: libraryProvider,
                      uniqueKey: uniqueKey,
                      options: (librarySearchResults.sortingOption, librarySearchResults.sortOrder),
                    );
                    if (newOptions != null) {
                      if (newOptions.$1 != null) {
                        libraryProvider.setSortBy(newOptions.$1!);
                      }
                      if (newOptions.$2 != null) {
                        libraryProvider.setSortOrder(newOptions.$2!);
                      }
                    }
                  },
                  icon: const Icon(IconsaxOutline.sort),
                ),
                if (librarySearchResults.hasActiveFilters) ...{
                  const SizedBox(width: 6),
                  IconButton(
                    tooltip: context.localized.disableFilters,
                    onPressed: disableFilters(librarySearchResults, libraryProvider),
                    icon: const Icon(IconsaxOutline.filter_remove),
                  ),
                },
              },
              const SizedBox(width: 6),
              IconButton(
                onPressed: () => libraryProvider.toggleSelectMode(),
                color: librarySearchResults.selecteMode ? Theme.of(context).colorScheme.primary : null,
                icon: const Icon(IconsaxOutline.category_2),
              ),
              const SizedBox(width: 6),
              AnimatedFadeSize(
                child: librarySearchResults.selecteMode
                    ? Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Tooltip(
                              message: context.localized.selectAll,
                              child: IconButton(
                                onPressed: () => libraryProvider.selectAll(true),
                                icon: const Icon(IconsaxOutline.box_add),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Tooltip(
                              message: context.localized.clearSelection,
                              child: IconButton(
                                onPressed: () => libraryProvider.selectAll(false),
                                icon: const Icon(IconsaxOutline.box_remove),
                              ),
                            ),
                            const SizedBox(width: 6),
                            if (librarySearchResults.selectedPosters.isNotEmpty) ...{
                              if (AdaptiveLayout.of(context).isDesktop)
                                PopupMenuButton(
                                  itemBuilder: (context) => actions.popupMenuItems(useIcons: true),
                                )
                              else
                                IconButton(
                                    onPressed: () {
                                      showBottomSheetPill(
                                        context: context,
                                        content: (context, scrollController) => ListView(
                                          shrinkWrap: true,
                                          controller: scrollController,
                                          children: actions.listTileItems(context, useIcons: true),
                                        ),
                                      );
                                    },
                                    icon: const Icon(IconsaxOutline.more))
                            },
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
              const Spacer(),
              if (librarySearchResults.activePosters.isNotEmpty)
                IconButton(
                  tooltip: context.localized.random,
                  onPressed: () => libraryProvider.openRandom(context),
                  icon: Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        IconsaxBold.arrow_up_1,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              if (librarySearchResults.activePosters.isNotEmpty)
                IconButton(
                  tooltip: context.localized.shuffleVideos,
                  onPressed: () async {
                    if (librarySearchResults.showGalleryButtons && !librarySearchResults.showPlayButtons) {
                      libraryProvider.viewGallery(context, shuffle: true);
                      return;
                    } else if (!librarySearchResults.showGalleryButtons && librarySearchResults.showPlayButtons) {
                      libraryProvider.playLibraryItems(context, ref, shuffle: true);
                      return;
                    }

                    await showLibraryPlayOptions(
                      context,
                      context.localized.libraryShuffleAndPlayItems,
                      playVideos: librarySearchResults.showPlayButtons
                          ? () => libraryProvider.playLibraryItems(context, ref, shuffle: true)
                          : null,
                      viewGallery: librarySearchResults.showGalleryButtons
                          ? () => libraryProvider.viewGallery(context, shuffle: true)
                          : null,
                    );
                  },
                  icon: const Icon(IconsaxOutline.shuffle),
                ),
            ],
          ),
          if (AdaptiveLayout.of(context).isDesktop) const SizedBox(height: 8),
        ],
      ),
    );
  }

  void Function()? disableFilters(LibrarySearchModel librarySearchResults, LibrarySearchNotifier libraryProvider) {
    return () {
      libraryProvider.clearAllFilters();
      refreshKey.currentState?.show();
    };
  }
}
