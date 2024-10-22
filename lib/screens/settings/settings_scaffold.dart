import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/router_extension.dart';

class SettingsScaffold extends ConsumerWidget {
  final String label;
  final bool showUserIcon;
  final ScrollController? scrollController;
  final List<Widget> items;
  final List<Widget> bottomActions;
  final Widget? floatingActionButton;
  const SettingsScaffold({
    required this.label,
    this.showUserIcon = false,
    this.scrollController,
    required this.items,
    this.bottomActions = const [],
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: AdaptiveLayout.of(context).size == ScreenLayout.dual ? Colors.transparent : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
      body: Column(
        children: [
          Flexible(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                if (AdaptiveLayout.of(context).size == ScreenLayout.single)
                  SliverAppBar.large(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: context.router.backButton(),
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
                                ))
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
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(AdaptiveLayout.of(context).size == ScreenLayout.single ? label : "",
                          style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  ),
                SliverPadding(
                  padding: MediaQuery.paddingOf(context).copyWith(top: AdaptiveLayout.of(context).isDesktop ? 0 : 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(items),
                  ),
                ),
                if (bottomActions.isEmpty)
                  const SliverToBoxAdapter(child: SizedBox(height: kBottomNavigationBarHeight + 40)),
              ],
            ),
          ),
          if (bottomActions.isNotEmpty) ...{
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32)
                  .add(EdgeInsets.only(left: padding.left, right: padding.right)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: bottomActions,
              ),
            ),
            const SizedBox(height: kBottomNavigationBarHeight + 40),
          },
        ],
      ),
    );
  }
}
