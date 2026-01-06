import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/router_extension.dart';

class SettingsScaffold extends ConsumerWidget {
  final String label;
  final ScrollController? scrollController;
  final double itemSpacing;
  final List<Widget> items;
  final List<Widget> bottomActions;
  final bool showUserIcon;
  final bool showBackButtonNested;
  final Widget? floatingActionButton;
  const SettingsScaffold({
    required this.label,
    this.scrollController,
    this.itemSpacing = 0.0,
    required this.items,
    this.bottomActions = const [],
    this.floatingActionButton,
    this.showUserIcon = false,
    this.showBackButtonNested = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.of(context).padding;
    final singleLayout = AdaptiveLayout.layoutModeOf(context) == LayoutMode.single;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
      body: Column(
        children: [
          Flexible(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                if (singleLayout)
                  SliverAppBar.large(
                    leading: BackButton(
                      onPressed: () => backAction(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(horizontal: 16)
                          .add(EdgeInsets.only(left: padding.left, right: padding.right, bottom: 4)),
                      title: Row(
                        children: [
                          Text(label, style: Theme.of(context).textTheme.headlineLarge),
                          const Spacer(),
                          if (showUserIcon)
                            SizedBox.fromSize(
                              size: const Size.fromRadius(14),
                              child: UserIcon(
                                user: ref.watch(userProvider),
                                cornerRadius: 200,
                              ),
                            )
                        ],
                      ),
                      expandedTitleScale: 1.2,
                    ),
                    expandedHeight: 100,
                    collapsedHeight: 80,
                    pinned: false,
                    floating: true,
                  )
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: MediaQuery.paddingOf(context).copyWith(bottom: 0),
                      child: Row(
                        children: [
                          if (showBackButtonNested && !ref.read(argumentsStateProvider).htpcMode)
                            BackButton(
                              onPressed: () => backAction(context),
                            )
                        ],
                      ),
                    ),
                  ),
                SliverPadding(
                  padding:
                      MediaQuery.paddingOf(context).copyWith(top: 0).add(const EdgeInsets.symmetric(horizontal: 2)),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) => items[index],
                    separatorBuilder: (context, index) => SizedBox(height: itemSpacing / 2),
                    itemCount: items.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: kBottomNavigationBarHeight + 40)),
              ],
            ),
          ),
          if (bottomActions.isNotEmpty) ...{
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                  .add(EdgeInsets.only(left: padding.left, right: padding.right)),
              child: Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.end,
                children: bottomActions,
              ),
            ),
          },
        ],
      ),
    );
  }

  void backAction(BuildContext context) {
    if (kIsWeb) {
      if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single && context.tabsRouter.activeIndex != 0) {
        context.tabsRouter.setActiveIndex(0);
      } else {
        context.router.pop();
      }
    } else {
      context.router.popBack();
    }
  }
}
