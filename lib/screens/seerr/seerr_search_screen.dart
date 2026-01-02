import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_browse_provider.dart';
import 'package:fladder/providers/seerr_dashboard_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/seerr/widgets/seerr_poster_card.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/sliver_list_padding.dart';
import 'package:fladder/widgets/navigation_scaffold/components/background_image.dart';
import 'package:fladder/widgets/shared/grid_focus_traveler.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class SeerrSearchScreen extends ConsumerStatefulWidget {
  const SeerrSearchScreen({super.key});

  @override
  ConsumerState<SeerrSearchScreen> createState() => _SeerrSearchScreenState();
}

class _SeerrSearchScreenState extends ConsumerState<SeerrSearchScreen> {
  late final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final Debouncer debouncer = Debouncer(const Duration(milliseconds: 300));

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> openRequest(BuildContext context, SeerrDashboardPosterModel poster) async {
    await openSeerrRequestPopup(context, poster);
    await ref.read(seerrDashboardProvider.notifier).fetchDashboard();
    await ref.read(seerrSearchProvider.notifier).submit(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(seerrSearchProvider);
    final surfaceColor = Theme.of(context).colorScheme.surface;
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
      body: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.only(left: AdaptiveLayout.of(context).sideBarWidth),
          child: PullToRefresh(
            onRefresh: () => ref.read(seerrSearchProvider.notifier).submit(controller.text),
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
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 5,
                  titleSpacing: 0,
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
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 55,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                                      autoFocus: true,
                                      controller: controller,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) => ref.read(seerrSearchProvider.notifier).submit(value),
                                      onChanged: (value) {
                                        debouncer.run(() {
                                          ref.read(seerrSearchProvider.notifier).submit(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "${context.localized.search}...",
                                        contentPadding: const EdgeInsets.only(top: 13),
                                        suffixIcon: IconButton(
                                          onPressed: () =>
                                              ref.read(seerrSearchProvider.notifier).submit(controller.text),
                                          icon: const Icon(IconsaxPlusLinear.search_status),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  if (searchState.isLoading)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (searchResults.isEmpty && searchState.query.trim().isEmpty && !searchState.isLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(context.localized.search),
                    ),
                  )
                else if (searchResults.isEmpty && searchState.query.trim().isNotEmpty && !searchState.isLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(context.localized.noResults),
                    ),
                  )
                else ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
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
                              onTap: (poster) => openRequest(context, poster),
                            );
                          },
                        );
                      },
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
