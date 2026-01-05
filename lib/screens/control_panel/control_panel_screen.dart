import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/theme_extensions.dart';

@RoutePage()
class ControlPanelScreen extends ConsumerStatefulWidget {
  const ControlPanelScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends ConsumerState<ControlPanelScreen> {
  final scrollController = ScrollController();
  final minVerticalPadding = 20.0;
  late LayoutMode lastAdaptiveLayout = AdaptiveLayout.layoutModeOf(context);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      builder: (context, content) {
        checkForNullIndex(context);
        return PopScope(
          canPop: context.tabsRouter.activeIndex == 0 || AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              context.tabsRouter.setActiveIndex(0);
            }
          },
          child: AdaptiveLayout.layoutModeOf(context) == LayoutMode.single
              ? Card(
                  elevation: 0,
                  child: Stack(
                    children: [_leftPane(context), content],
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 2, child: _leftPane(context)),
                    Expanded(
                      flex: 3,
                      child: content,
                    ),
                  ],
                ),
        );
      },
    );
  }

  //We have to navigate to the first screen after switching layouts && index == 0 otherwise the dual-layout is empty
  void checkForNullIndex(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 125));
      if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual && context.tabsRouter.activeIndex == 0) {
        const ControlDashboardRoute().navigate(context);
      }
    });
  }

  Widget _leftPane(BuildContext context) {
    void navigateTo(PageRouteInfo route) => context.tabsRouter.navigate(route);

    bool containsRoute(PageRouteInfo route) =>
        AdaptiveLayout.layoutModeOf(context) == LayoutMode.dual && context.tabsRouter.current.name == route.routeName;

    return Padding(
      padding: EdgeInsets.only(left: AdaptiveLayout.of(context).sideBarWidth),
      child: Container(
        color: context.colors.surface,
        child: SettingsScaffold(
          label: context.localized.controlPanel,
          scrollController: scrollController,
          showBackButtonNested: true,
          showUserIcon: true,
          items: [
            SettingsLabelDivider(label: context.localized.server),
            SettingsListTile(
              label: Text(context.localized.dashboard),
              subLabel: Text(context.localized.dashboardDesc),
              autoFocus: true,
              selected: containsRoute(const ControlDashboardRoute()),
              icon: IconsaxPlusLinear.data_2,
              onTap: () => navigateTo(const ControlDashboardRoute()),
            ),
            SettingsListTile(
              label: Text(context.localized.server),
              subLabel: Text(context.localized.controlPanelServerDesc),
              selected: containsRoute(const ControlServerRoute()),
              icon: IconsaxPlusLinear.barcode,
              onTap: () => navigateTo(const ControlServerRoute()),
            ),
            SettingsListTile(
              label: Text(context.localized.users),
              selected: containsRoute(const ControlUsersRoute()),
              icon: IconsaxPlusLinear.user,
              onTap: () => navigateTo(const ControlUsersRoute()),
            ),
            SettingsLabelDivider(label: context.localized.library(2)),
            SettingsListTile(
              label: Text(context.localized.library(2)),
              selected: containsRoute(const ControlLibrariesRoute()),
              icon: IconsaxPlusLinear.book,
              onTap: () => navigateTo(const ControlLibrariesRoute()),
            ),
            SettingsLabelDivider(label: context.localized.advanced),
            SettingsListTile(
              label: Text(context.localized.plannedTasks),
              selected: containsRoute(const ControlActiveTasksRoute()),
              icon: IconsaxPlusLinear.timer_1,
              onTap: () => navigateTo(const ControlActiveTasksRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
