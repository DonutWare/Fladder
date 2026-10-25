import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/collections/add_to_collection.dart';
import 'package:fladder/screens/library_search/widgets/library_filter_chips.dart';
import 'package:fladder/screens/library_search/widgets/library_play_options_.dart';
import 'package:fladder/screens/library_search/widgets/library_saved_filters.dart';
import 'package:fladder/screens/library_search/widgets/library_sort_dialogue.dart';
import 'package:fladder/screens/library_search/widgets/library_views.dart';
import 'package:fladder/screens/library_search/widgets/suggestion_search_bar.dart';
import 'package:fladder/screens/playlists/add_to_playlists.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/position_provider.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/bottom_menu_bar.dart';
import 'package:fladder/widgets/shared/fladder_scrollbar.dart';
import 'package:fladder/widgets/shared/hide_on_scroll.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/pinch_poster_zoom.dart';
import 'package:fladder/widgets/shared/poster_size_slider.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';
import 'package:fladder/widgets/shared/scroll_position.dart';

@RoutePage()
class LibrarySearchScreen extends ConsumerStatefulWidget {
  final String? query;
  final List<String>? parentId;
  final bool? favourites;
  final SortingOrder? sortOrder;
  final SortingOptions? sortingOptions;
  final Map<FladderItemType, bool>? types;
  final Map<String, bool>? genres;
  final Map<Studio, bool>? studios;
  final Map<ItemFilter, bool>? itemFilters;
  final Map<String, bool>? tags;
  final Map<int, bool>? years;
  final bool? recursive;
  final bool? isDefault;
  const LibrarySearchScreen({
    @QueryParam("query") this.query,
    @QueryParam("parentId") this.parentId,
    @QueryParam("favourites") this.favourites,
    @QueryParam("sortOrder") this.sortOrder,
    @QueryParam("sortOptions") this.sortingOptions,
    @QueryParam("itemTypes") this.types,
    @QueryParam("genres") this.genres,
    @QueryParam("studios") this.studios,
    @QueryParam("itemFilters") this.itemFilters,
    @QueryParam("tags") this.tags,
    @QueryParam("years") this.years,
    @QueryParam("recursive") this.recursive,
    @QueryParam("isDefault") this.isDefault,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibrarySearchScreenState();
}

class _LibrarySearchScreenState extends ConsumerState<LibrarySearchScreen> {
  final Debouncer debouncer = Debouncer(const Duration(seconds: 1));
  final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController scrollController = ScrollController();
  late double lastScale = 0;

  bool loadOnStart = false;

  Key get uniqueKey => Key(widget.parentId?.join(',').toString() ?? "EmptySearch");
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
    WidgetsBinding.instance.addPostFrameCallback((value) {
      initLibrary();
    });
  }

  Future<void> initLibrary() async {
    await refreshKey.currentState?.show();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [],
    );
    scrollController.addListener(() {
      scrollPosition();
    });
  }

  void scrollPosition() {
    if (scrollController.position.pixels > scrollController.position.maxScrollExtent * 0.65) {
      libraryProvider.loadMore();
    }
  }

  Future<void> refreshSearch() async {
    await refreshKey.currentState?.show();
    scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final isEmptySearchScreen = widget.parentId == null && widget.favourites == null;
    final librarySearchResults = ref.watch(providerKey);
    final postersList = librarySearchResults.posters.hideEmptyChildren(librarySearchResults.filters.hideEmptyShows);
    final libraryViewType = ref.watch(libraryViewTypeProvider);

    final floatingAppBar = AdaptiveLayout.layoutModeOf(context) != LayoutMode.single;

    final toolbarHeight = 55.0;

    ref.listen(
      providerKey,
      (previous, next) {
        if (previous?.shouldRefresh(next) == true) {
          refreshSearch();
        }
      },
    );

    final adaptiveLayout = AdaptiveLayout.of(context);

    final mediaQuery = MediaQuery.of(context);

    final useBlurredBackground = ref.watch(clientSettingsProvider.select(
      (value) => value.backgroundImage == BackgroundType.blurred && value.enableBlurEffects,
    ));

    List<ItemAction>? itemActions = librarySearchResults.folderOverwrite.included.firstOrNull?.generateActions(
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
    );

    List<ItemAction> menuActions = [
      ItemActionButton(
        label: Text(context.localized.itemCount(librarySearchResults.totalItemCount)),
        icon: const Icon(IconsaxPlusBold.document_1),
      ),
      ItemActionButton(
        label: Text(context.localized.forceRefresh),
        action: () => refreshKey.currentState?.show(),
        icon: const Icon(IconsaxPlusLinear.refresh),
      ),
      ItemActionButton(
        label: Text(context.localized.filter(2)),
        action: () => showSavedFilters(context, uniqueKey),
        icon: const Icon(IconsaxPlusLinear.filter_edit),
      ),
      ItemActionButton(
        label: Text(context.localized.selectViewType),
        icon: Icon(libraryViewType.icon),
        action: () {
          showAdaptiveDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              content: Consumer(
                builder: (context, ref, child) {
                  final currentType = ref.watch(libraryViewTypeProvider);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(context.localized.selectViewType, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      ...LibraryViewTypes.values
                          .map(
                            (e) => FilledButton.tonal(
                              style: FilledButtonTheme.of(context).style?.copyWith(
                                    padding: const WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 12, vertical: 24)),
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
        },
      ),
      if (itemActions?.isNotEmpty == true) ItemActionDivider(),
      ...?itemActions,
    ];

    Future<void> playLibrary(bool shuffle) async {
      if (librarySearchResults.showGalleryButtons &&
          !librarySearchResults.showPlayButtons &&
          !librarySearchResults.showMusicButtons) {
        libraryProvider.viewGallery(context, ref, shuffle: shuffle);
        return;
      } else if (!librarySearchResults.showGalleryButtons &&
          librarySearchResults.showPlayButtons &&
          !librarySearchResults.showMusicButtons) {
        libraryProvider.playLibraryItems(context, ref, shuffle: shuffle);
        return;
      } else if (!librarySearchResults.showGalleryButtons &&
          !librarySearchResults.showPlayButtons &&
          librarySearchResults.showMusicButtons) {
        libraryProvider.playMusicItems(context, ref, shuffle: shuffle);
        return;
      }

      await showLibraryPlayOptions(
        context,
        context.localized.libraryShuffleAndPlayItems,
        playVideos: librarySearchResults.showPlayButtons
            ? () => libraryProvider.playLibraryItems(context, ref, shuffle: shuffle)
            : null,
        playMusic: librarySearchResults.showMusicButtons
            ? () => libraryProvider.playMusicItems(context, ref, shuffle: shuffle)
            : null,
        viewGallery: librarySearchResults.showGalleryButtons
            ? () => libraryProvider.viewGallery(context, ref, shuffle: shuffle)
            : null,
      );
    }

    List<ItemAction> generateQuickActions(
      bool inlinedPlayButtons,
    ) {
      final isSelectMode = librarySearchResults.selecteMode;
      final selectedCount = librarySearchResults.selectedPosters.length;
      void disableFilters(LibrarySearchModel librarySearchResults, LibrarySearchNotifier libraryProvider) {
        libraryProvider.clearAllFilters();
        refreshKey.currentState?.show();
      }

      final playButton = ItemActionButton(
        action: () => playLibrary(false),
        label: Text(context.localized.libraryPlayItems),
        icon: const Icon(IconsaxPlusBold.play),
      );
      final shuffleButton = ItemActionButton(
        action: () => playLibrary(true),
        label: Text(context.localized.libraryShuffleAndPlayItems),
        icon: const Icon(IconsaxPlusBold.shuffle),
      );

      final hasSelection = librarySearchResults.selectedPosters.isNotEmpty;

      final selectedPostersId = librarySearchResults.selectedPosters.map((e) => e.id).toList();

      if (isSelectMode) {
        return [
          if (inlinedPlayButtons) playButton,
          shuffleButton,
          if (librarySearchResults.showOpenMultiple)
            ItemActionButton(
              action: () {
                LibrarySearchRoute(
                  parentId: selectedPostersId,
                  key: Key(selectedPostersId.join(',')),
                ).push(context);
              },
              label: Text(context.localized.openSelected),
              icon: const Icon(IconsaxPlusLinear.folder_open),
            ),
          ItemActionDivider(),
          ItemActionButton(
            action: () {
              libraryProvider.toggleSelectMode();
            },
            label: Text(context.localized.stopSelection(selectedCount)),
            icon: selectedCount != 0
                ? Badge(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      selectedCount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    child: const Icon(IconsaxPlusLinear.category_2),
                  )
                : const Icon(IconsaxPlusLinear.category_2),
          ),
          ItemActionDivider(),
          ItemActionButton(
            action: () => libraryProvider.selectAll(true),
            label: Text(context.localized.selectAll),
            icon: const Icon(IconsaxPlusLinear.tick_square),
          ),
          ItemActionButton(
            action: () => libraryProvider.selectAll(false),
            label: Text(context.localized.clearSelection),
            icon: const Icon(IconsaxPlusLinear.minus_square),
          ),
          ItemActionDivider(),
          ItemActionButton(
            action: hasSelection
                ? () async {
                    await libraryProvider.setSelectedAsFavorite(true);
                    if (context.mounted) context.refreshData();
                  }
                : null,
            label: Text(context.localized.addAsFavorite),
            icon: const Icon(IconsaxPlusLinear.heart_add),
          ),
          ItemActionButton(
            action: hasSelection
                ? () async {
                    await libraryProvider.setSelectedAsFavorite(false);
                    if (context.mounted) context.refreshData();
                  }
                : null,
            label: Text(context.localized.removeAsFavorite),
            icon: const Icon(IconsaxPlusLinear.heart_remove),
          ),
          ItemActionButton(
            action: hasSelection
                ? () async {
                    await libraryProvider.setSelectedAsWatched(true);
                    if (context.mounted) context.refreshData();
                  }
                : null,
            label: Text(context.localized.markAsWatched),
            icon: const Icon(IconsaxPlusLinear.eye),
          ),
          ItemActionButton(
            action: hasSelection
                ? () async {
                    await libraryProvider.setSelectedAsWatched(false);
                    if (context.mounted) context.refreshData();
                  }
                : null,
            label: Text(context.localized.markAsUnwatched),
            icon: const Icon(IconsaxPlusLinear.eye_slash),
          ),
          if (librarySearchResults.folderOverwrite.included.firstOrNull is BoxSetModel)
            ItemActionButton(
                action: hasSelection
                    ? () async {
                        await libraryProvider.removeSelectedFromCollection();
                        if (context.mounted) context.refreshData();
                      }
                    : null,
                label: Text(context.localized.removeFromCollection),
                icon: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary, borderRadius: BorderRadius.circular(6)),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(IconsaxPlusLinear.save_remove, size: 20),
                  ),
                )),
          if (librarySearchResults.folderOverwrite.included.firstOrNull is PlaylistModel)
            ItemActionButton(
              action: hasSelection
                  ? () async {
                      await libraryProvider.removeSelectedFromPlaylist();
                      if (context.mounted) context.refreshData();
                    }
                  : null,
              label: Text(context.localized.removeFromPlaylist),
              icon: const Icon(IconsaxPlusLinear.save_remove),
            ),
          ItemActionButton(
            action: hasSelection
                ? () async {
                    await addItemToCollection(context, librarySearchResults.selectedPosters);
                    if (context.mounted) context.refreshData();
                  }
                : null,
            label: Text(context.localized.addToCollection),
            icon: const Icon(
              IconsaxPlusLinear.save_add,
              size: 20,
            ),
          ),
          ItemActionButton(
            action: hasSelection
                ? () async {
                    await addItemToPlaylist(context, librarySearchResults.selectedPosters);
                    if (context.mounted) context.refreshData();
                  }
                : null,
            label: Text(context.localized.addToPlaylist),
            icon: const Icon(IconsaxPlusLinear.save_add),
          ),
        ];
      } else {
        return [
          if (inlinedPlayButtons) playButton,
          shuffleButton,
          ItemActionDivider(),
          ItemActionButton(
            action: () {
              libraryProvider.toggleSelectMode();
            },
            label: Text(context.localized.select),
            icon: const Icon(IconsaxPlusLinear.category_2),
          ),
          ItemActionDivider(),
          ItemActionButton(
            action: () async {
              final newOptions = await openSortByDialogue(
                context,
                libraryProvider: libraryProvider,
                uniqueKey: uniqueKey,
                options: (librarySearchResults.filters.sortingOption, librarySearchResults.filters.sortOrder),
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
            label: Text(context.localized.sortBy),
            icon: const Icon(IconsaxPlusLinear.sort),
          ),
          if (librarySearchResults.hasActiveFilters) ...{
            ItemActionButton(
              action: () {
                disableFilters(librarySearchResults, libraryProvider);
              },
              label: Text(context.localized.disableFilters),
              icon: const Icon(IconsaxPlusLinear.filter_remove),
            ),
          },
          if (librarySearchResults.activePosters.isNotEmpty)
            ItemActionButton(
              action: () {
                return libraryProvider.openRandom(context);
              },
              label: Text(context.localized.selectRandom),
              icon: const Icon(
                IconsaxPlusBold.slider_vertical,
              ),
            ),
        ];
      }
    }

    LibraryFilterModel? incomingFilter() {
      if (widget.favourites != null ||
          widget.sortOrder != null ||
          widget.sortingOptions != null ||
          widget.types != null ||
          widget.genres != null ||
          widget.itemFilters != null ||
          widget.studios != null ||
          widget.years != null ||
          widget.tags != null ||
          widget.recursive != null ||
          widget.query != null) {
        final defaultFilter = const LibraryFilterModel();

        return defaultFilter.copyWith(
          searchQuery: widget.query ?? "",
          favourites: widget.favourites,
          sortOrder: widget.sortOrder ?? defaultFilter.sortOrder,
          sortingOption: widget.sortingOptions ?? defaultFilter.sortingOption,
          types: widget.types ?? {},
          genres: widget.genres ?? {},
          itemFilters: widget.itemFilters ?? {},
          studios: widget.studios ?? {},
          years: widget.years ?? {},
          tags: widget.tags ?? {},
          recursive: widget.recursive,
          isDefault: widget.isDefault ?? false,
        );
      } else {
        return null;
      }
    }

    return MediaQuery(
      data: mediaQuery.copyWith(
        padding: mediaQuery.padding.copyWith(top: mediaQuery.padding.top + adaptiveLayout.topBarHeight),
        viewPadding: mediaQuery.viewPadding.copyWith(top: mediaQuery.viewPadding.top + adaptiveLayout.topBarHeight),
      ),
      child: PopScope(
        key: uniqueKey,
        canPop: !librarySearchResults.selecteMode,
        onPopInvokedWithResult: (didPop, result) {
          if (librarySearchResults.selecteMode) {
            libraryProvider.toggleSelectMode();
          }
        },
        child: NestedScaffold(
          background: BackgroundImage(images: postersList.map((e) => e.images).nonNulls.toList()),
          body: Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            bottomNavigationBar: AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad
                ? HideOnScroll(
                    controller: scrollController,
                    visibleBuilder: (visible) => BottomMenuBar(
                      actions: generateQuickActions(false),
                      combined: true,
                      extended: visible,
                      sticky: librarySearchResults.selecteMode,
                      fabAction: FloatingActionButton(
                        onPressed: () => playLibrary(false),
                        tooltip: context.localized.libraryPlayItems,
                        child: const Icon(IconsaxPlusBold.play),
                      ),
                    ),
                  )
                : null,
            body: PinchPosterZoom(
              scaleDifference: (difference) => ref.read(clientSettingsProvider.notifier).addPosterSize(difference),
              child: FladderScrollbar(
                visible: AdaptiveLayout.inputDeviceOf(context) != InputDevice.pointer,
                controller: scrollController,
                child: PullToRefresh(
                  refreshKey: refreshKey,
                  autoFocus: false,
                  contextRefresh: false,
                  onRefresh: () async {
                    final filter = incomingFilter();
                    if (libraryProvider.mounted) {
                      return libraryProvider.initRefresh(
                        parentIds: widget.parentId ?? [],
                        filters: filter,
                      );
                    }
                  },
                  refreshOnStart: false,
                  child: (context) {
                    return CustomScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        PinnedHeaderSliver(
                          child: HideOnScroll(
                            controller: scrollController,
                            visibleBuilder: (visible) => Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? 160 : 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Theme.of(context).colorScheme.surface.withAlpha(255),
                                        Theme.of(context).colorScheme.surface.withAlpha(0),
                                      ],
                                    ),
                                  ),
                                  child: useBlurredBackground
                                      ? ShaderMask(
                                          shaderCallback: (bounds) {
                                            return LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white.withAlpha(255),
                                                Colors.white.withAlpha(0),
                                              ],
                                            ).createShader(
                                              Rect.fromLTRB(0, 10, bounds.width, bounds.height),
                                            );
                                          },
                                          blendMode: BlendMode.dstIn,
                                          child: const BackgroundImage(),
                                        )
                                      : null,
                                ),
                                AnimatedSlide(
                                  duration: const Duration(milliseconds: 250),
                                  offset: visible || floatingAppBar ? Offset.zero : const Offset(0, -1),
                                  child: LibraryAppBar(
                                    toolbarHeight: toolbarHeight,
                                    menuActions: menuActions,
                                    librarySearchResults: librarySearchResults,
                                    quickActions: generateQuickActions(true),
                                    isEmptySearchScreen: isEmptySearchScreen,
                                    refreshKey: refreshKey,
                                    uniqueKey: uniqueKey,
                                    libraryProvider: libraryProvider,
                                    scrollController: scrollController,
                                  ),
                                )
                              ],
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
                              left: mediaQuery.padding.left,
                              right: mediaQuery.padding.right,
                            ).add(
                              EdgeInsetsDirectional.only(start: adaptiveLayout.sideBarWidth),
                            ),
                            sliver: LibraryViews(
                              key: uniqueKey,
                              items: postersList,
                              groupByType: librarySearchResults.filters.groupBy,
                            ),
                          )
                        else
                          SliverFillRemaining(
                            child: Center(
                              child: Text(context.localized.noItemsToShow),
                            ),
                          ),
                        SliverPadding(padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.20))
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LibraryAppBar extends ConsumerWidget {
  final double toolbarHeight;
  final List<ItemAction> menuActions;
  final LibrarySearchModel librarySearchResults;
  final List<ItemAction> quickActions;
  final bool isEmptySearchScreen;
  final GlobalKey<RefreshIndicatorState> refreshKey;
  final Key uniqueKey;
  final LibrarySearchNotifier libraryProvider;
  final ScrollController scrollController;

  const LibraryAppBar({
    required this.toolbarHeight,
    required this.menuActions,
    required this.librarySearchResults,
    this.quickActions = const [],
    required this.isEmptySearchScreen,
    required this.refreshKey,
    required this.uniqueKey,
    required this.libraryProvider,
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top,
        left: AdaptiveLayout.adaptivePadding(context).left,
        bottom: 16,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                right: AdaptiveLayout.adaptivePadding(context).right,
              ),
              child: Row(
                spacing: 4,
                children: [
                  if (AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad)
                    SizedBox.square(
                      dimension: toolbarHeight,
                      child: PositionRoundedClip(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                          ),
                          child: context.router.backButton(),
                        ),
                      ),
                    ),
                  Expanded(
                    child: PositionRoundedClip(
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
                          if (librarySearchResults.filters.searchQuery != value) {
                            libraryProvider.setSearch(value);
                            refreshKey.currentState?.show();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox.square(
                    dimension: toolbarHeight,
                    child: PositionRoundedClip(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                        ),
                        child: Tooltip(
                          message: librarySearchResults.folderOverwrite.included.firstOrNull?.type
                                  .label(context.localized) ??
                              context.localized.library(1),
                          child: AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer
                              ? PopupMenuButton(
                                  tooltip: context.localized.library(1),
                                  icon: Icon(librarySearchResults.folderOverwrite.included.firstOrNull?.type.icon ??
                                      IconsaxPlusLinear.document),
                                  itemBuilder: (context) => menuActions.toList().popupMenuItems(useIcons: true),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    await showBottomSheetPill(
                                      context: context,
                                      content: (context, scrollController) => ListView(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        children: menuActions
                                            .map(
                                              (e) => e.toListItem(context, useIcons: true, shouldPop: true),
                                            )
                                            .toList(),
                                      ),
                                    );
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      librarySearchResults.folderOverwrite.included.firstOrNull?.type.icon ??
                                          IconsaxPlusLinear.document,
                                      color: librarySearchResults
                                                  .folderOverwrite.included.firstOrNull?.userData.isFavourite ==
                                              true
                                          ? Theme.of(context).colorScheme.primary
                                          : null,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single)
                    SizedBox.square(
                      dimension: toolbarHeight,
                      child: const PositionRoundedClip(
                        child: SettingsUserIcon(),
                      ),
                    ),
                ].withPositionProvider(),
              ),
            ),
          ),
          Row(
            spacing: 6,
            children: [
              if (AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad)
                ScrollStatePosition(
                  controller: scrollController,
                  positionBuilder: (state) => AnimatedFadeSize(
                    child: state != ScrollState.top
                        ? Tooltip(
                            message: context.localized.scrollToTop,
                            child: IconButton.filled(
                              onPressed: () => scrollController.animateTo(0,
                                  duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                              icon: const Icon(
                                IconsaxPlusLinear.arrow_up,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 8).add(EdgeInsets.only(
                    right: AdaptiveLayout.adaptivePadding(context).right,
                  )),
                  scrollDirection: Axis.horizontal,
                  child: LibraryFilterChips(
                    key: uniqueKey,
                  ),
                ),
              ),
            ],
          ),
          if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad)
            Container(
              padding: EdgeInsets.only(
                right: AdaptiveLayout.adaptivePadding(context).right,
              ),
              child: Row(
                spacing: 4,
                children: quickActions.map((e) => e.toButton()).toList(),
              ),
            )
        ],
      ),
    );
  }
}
