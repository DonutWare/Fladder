import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_search_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/seerr/widgets/seerr_filter_chips.dart';
import 'package:fladder/screens/seerr/widgets/seerr_filter_dialogs.dart';
import 'package:fladder/screens/seerr/widgets/seerr_poster_card.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/screens/shared/nested_bottom_appbar.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/grid_focus_traveler.dart';
import 'package:fladder/widgets/shared/hide_on_scroll.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class SeerrSearchScreen extends ConsumerStatefulWidget {
  final SeerrSearchMode? mode;
  final int? yearGte;
  const SeerrSearchScreen({
    @QueryParam("mode") this.mode,
    @QueryParam("yearGte") this.yearGte,
    super.key,
  });

  @override
  ConsumerState<SeerrSearchScreen> createState() => _SeerrSearchScreenState();
}

class _SeerrSearchScreenState extends ConsumerState<SeerrSearchScreen> {
  late final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final Debouncer debouncer = Debouncer(const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(seerrSearchProvider.notifier);
      notifier.init();
      if (widget.mode != null) {
        notifier.setSearchMode(widget.mode!);
      }
      if (widget.yearGte != null) {
        notifier.setYearRange(minYear: widget.yearGte);
      }
    });
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels > scrollController.position.maxScrollExtent * 0.65) {
      ref.read(seerrSearchProvider.notifier).loadMore();
    }
  }

  void _maybeTriggerLoadMore(SeerrSearchModel state) {
    if (!mounted) return;
    if (state.isLoading || state.isLoadingMore) return;
    if (state.totalPages == null || state.currentPage >= state.totalPages!) return;
    if (!scrollController.hasClients) return;

    final position = scrollController.position;
    final notScrollable = position.maxScrollExtent <= 0;
    final nearBottom = position.extentAfter < position.viewportDimension * 0.2;

    if (notScrollable || nearBottom) {
      ref.read(seerrSearchProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> openRequest(BuildContext context, SeerrDashboardPosterModel poster) async {
    await openSeerrRequestPopup(context, poster);
    await ref.read(seerrSearchProvider.notifier).submit();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(seerrSearchProvider);
    final surfaceColor = Theme.of(context).colorScheme.surface;
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeTriggerLoadMore(searchState));
    ref.listen(
      seerrSearchProvider.select((value) => value.query),
      (previous, next) {
        if (controller.text != next) {
          controller.text = next;
        }
      },
    );

    final searchResults = searchState.results;
    final backgroundImages = searchResults.map((e) => e.images).toList(growable: false);

    final floatingAppBar = AdaptiveLayout.layoutModeOf(context) != LayoutMode.single;

    return NestedScaffold(
      background: BackgroundImage(images: backgroundImages),
      body: Padding(
        padding: EdgeInsets.only(left: AdaptiveLayout.of(context).sideBarWidth),
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad
              ? HideOnScroll(
                  controller: scrollController,
                  canHide: !floatingAppBar,
                  child: IgnorePointer(
                    ignoring: searchState.isLoading,
                    child: _SeerrSearchBottomBar(
                      searchState: searchState,
                      notifier: ref.read(seerrSearchProvider.notifier),
                    ),
                  ),
                )
              : null,
          body: PullToRefresh(
            onRefresh: () => ref.read(seerrSearchProvider.notifier).submit(),
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: !floatingAppBar,
                  collapsedHeight: 80,
                  automaticallyImplyLeading: false,
                  primary: true,
                  pinned: floatingAppBar,
                  elevation: 5,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  titleSpacing: 4,
                  flexibleSpace: AdaptiveLayout.layoutModeOf(context) != LayoutMode.dual
                      ? Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              surfaceColor.withValues(alpha: 0.8),
                              surfaceColor.withValues(alpha: 0.75),
                              surfaceColor.withValues(alpha: 0.5),
                              surfaceColor.withValues(alpha: 0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                        )
                      : null,
                  title: SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        spacing: 8,
                        children: [
                          if (AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad)
                            Center(
                              child: SizedBox.square(
                                dimension: 55,
                                child: Card(
                                  elevation: 0,
                                  child: context.router.backButton(),
                                ),
                              ),
                            ),
                          Expanded(
                            child: Card(
                              elevation: 6,
                              child: Row(
                                spacing: 8,
                                children: [
                                  Expanded(
                                    child: OutlinedTextField(
                                      autoFocus: searchState.searchMode == SeerrSearchMode.search,
                                      controller: controller,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) => ref.read(seerrSearchProvider.notifier).submit(value),
                                      onChanged: (value) {
                                        ref.read(seerrSearchProvider.notifier).setQuery(value);
                                        if (searchState.searchMode == SeerrSearchMode.search) {
                                          debouncer.run(() {
                                            ref.read(seerrSearchProvider.notifier).submit(value);
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "${context.localized.search}...",
                                        contentPadding: const EdgeInsets.only(top: 6),
                                        icon: IconButton(
                                          onPressed: () =>
                                              ref.read(seerrSearchProvider.notifier).submit(controller.text),
                                          icon: const Icon(IconsaxPlusLinear.search_status),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single) ...[
                            const SizedBox.square(dimension: 55.0 - 3.0, child: SettingsUserIcon()),
                          ],
                        ],
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(0, AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? 105 : 50),
                    child: Transform.translate(
                      offset: Offset(0, AdaptiveLayout.of(context).isDesktop ? -20 : -15),
                      child: IgnorePointer(
                        ignoring: searchState.isLoading,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 50,
                              child: Opacity(
                                opacity: searchState.isLoading ? 0.5 : 1,
                                child: const SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  scrollDirection: Axis.horizontal,
                                  child: SeerrFilterChips(),
                                ),
                              ),
                            ),
                            if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad)
                              _SeerrSearchBottomBar(
                                searchState: searchState,
                                notifier: ref.read(seerrSearchProvider.notifier),
                                isDPadBar: true,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (searchResults.isEmpty && !searchState.isLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(context.localized.noResults),
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: Builder(
                      builder: (context) {
                        final posterSize = MediaQuery.sizeOf(context).width /
                            (AdaptiveLayout.poster(context).gridRatio *
                                ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
                        final width = MediaQuery.of(context).size.width;
                        final cellWidth = (width / posterSize).floorToDouble();
                        final crossAxisCount = ((width / cellWidth).floor()).clamp(2, 10);

                        return GridFocusTraveler(
                          itemCount: searchResults.length,
                          crossAxisCount: crossAxisCount,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.55,
                          ),
                          itemBuilder: (context, selectedIndex, index) {
                            final poster = searchResults[index];
                            return SeerrPosterCard(
                              key: Key(poster.id),
                              poster: poster,
                              onFocusChanged: (value) {
                                if (value) {
                                  context.ensureVisible();
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (searchState.isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
                const DefautlSliverBottomPadding(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SeerrSearchBottomBar extends StatelessWidget {
  final SeerrSearchModel searchState;
  final SeerrSearch notifier;
  final bool isDPadBar;
  const _SeerrSearchBottomBar({
    required this.searchState,
    required this.notifier,
    this.isDPadBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasFilters = searchState.filters.genres.values.any((v) => v) ||
        searchState.filters.watchProviders.values.any((v) => v) ||
        searchState.filters.certifications.values.any((v) => v) ||
        searchState.filters.yearGte != null ||
        searchState.filters.yearLte != null ||
        searchState.filters.voteAverageGte != null ||
        searchState.filters.voteAverageLte != null ||
        searchState.filters.runtimeGte != null ||
        searchState.filters.runtimeLte != null ||
        searchState.filters.studio != null;

    final paddingOf = MediaQuery.paddingOf(context);
    final barContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          IconButton(
            tooltip: context.localized.sortBy,
            icon: const Icon(IconsaxPlusLinear.sort),
            onPressed: () => openSortDialog(context, notifier, searchState.filters),
          ),
          IconButton(
            tooltip: context.localized.clear,
            icon: const Icon(IconsaxPlusLinear.filter_remove),
            onPressed: hasFilters
                ? () async {
                    notifier.clearFilters();
                    await notifier.submit();
                  }
                : null,
          ),
          const Spacer(),
        ],
      ),
    );

    if (isDPadBar) {
      return barContent;
    }

    return NestedBottomAppBar(
      child: Padding(
        padding: EdgeInsets.only(left: paddingOf.left, right: paddingOf.right),
        child: barContent,
      ),
    );
  }
}
