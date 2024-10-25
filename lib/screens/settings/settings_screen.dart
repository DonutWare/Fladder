import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/settings/quick_connect_window.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/shared/fladder_icon.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/theme_extensions.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final scrollController = ScrollController();
  final minVerticalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    if (AdaptiveLayout.of(context).size == ScreenLayout.single) {
      return Card(
        elevation: 0,
        child: _leftPane(context),
      );
    } else {
      return AutoRouter(
        builder: (context, content) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 1, child: _leftPane(context)),
              Expanded(
                flex: 2,
                child: content,
              ),
            ],
          );
        },
      );
    }
  }

  IconData get deviceIcon {
    if (AdaptiveLayout.of(context).isDesktop) {
      return IconsaxOutline.monitor;
    }
    switch (AdaptiveLayout.of(context).layout) {
      case LayoutState.phone:
        return IconsaxOutline.mobile;
      case LayoutState.tablet:
        return IconsaxOutline.monitor;
      case LayoutState.desktop:
        return IconsaxOutline.monitor;
    }
  }

  Widget _leftPane(BuildContext context) {
    void navigateTo(PageRouteInfo route) {
      AdaptiveLayout.of(context).size == ScreenLayout.single
          ? context.router.navigate(route)
          : context.router.replace(route);
    }

    bool containsRoute(PageRouteInfo route) {
      return context.router.current.name == route.routeName;
    }

    final quickConnectAvailable =
        ref.watch(userProvider.select((value) => value?.serverConfiguration?.quickConnectAvailable ?? false));
    return Container(
      color: context.colors.surface,
      child: SettingsScaffold(
        label: context.localized.settings,
        scrollController: scrollController,
        showUserIcon: true,
        items: [
          if (context.router.canNavigateBack && AdaptiveLayout.of(context).size == ScreenLayout.dual)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  ),
                  onPressed: () => context.router.popBack(),
                  icon: Padding(
                    padding: EdgeInsets.all(AdaptiveLayout.of(context).inputDevice == InputDevice.pointer ? 0 : 4),
                    child: const Icon(IconsaxOutline.arrow_left_2),
                  ),
                ),
              ),
            ),
          SettingsListTile(
            label: Text(context.localized.settingsClientTitle),
            subLabel: Text(context.localized.settingsClientDesc),
            selected: containsRoute(const ClientSettingsRoute()),
            icon: deviceIcon,
            onTap: () => navigateTo(const ClientSettingsRoute()),
          ),
          if (quickConnectAvailable)
            SettingsListTile(
              label: Text(context.localized.settingsQuickConnectTitle),
              icon: IconsaxOutline.password_check,
              onTap: () => openQuickConnectDialog(context),
            ),
          SettingsListTile(
            label: Text(context.localized.settingsProfileTitle),
            subLabel: Text(context.localized.settingsProfileDesc),
            selected: containsRoute(const SecuritySettingsRoute()),
            icon: IconsaxOutline.security_user,
            onTap: () => navigateTo(const SecuritySettingsRoute()),
          ),
          SettingsListTile(
            label: Text(context.localized.settingsPlayerTitle),
            subLabel: Text(context.localized.settingsPlayerDesc),
            selected: containsRoute(const PlayerSettingsRoute()),
            icon: IconsaxOutline.video_play,
            onTap: () => navigateTo(const PlayerSettingsRoute()),
          ),
          SettingsListTile(
            label: Text(context.localized.about),
            subLabel: const Text("Fladder"),
            selected: containsRoute(const AboutSettingsRoute()),
            suffix: Opacity(
              opacity: 1,
              child: FladderIconOutlined(
                size: 24,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            onTap: () => navigateTo(const AboutSettingsRoute()),
          ),
        ],
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.paddingOf(context).horizontal),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                FloatingActionButton(
                  key: Key(context.localized.switchUser),
                  tooltip: context.localized.switchUser,
                  onPressed: () async {
                    await ref.read(userProvider.notifier).logoutUser();
                    context.router.replaceAll([const LoginRoute()]);
                  },
                  child: const Icon(
                    IconsaxOutline.arrow_swap_horizontal,
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: context.localized.logout,
                  key: Key(context.localized.logout),
                  tooltip: context.localized.logout,
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  onPressed: () {
                    final user = ref.read(userProvider);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(context.localized.logoutUserPopupTitle(user?.name ?? "")),
                        scrollable: true,
                        content: Text(
                          context.localized.logoutUserPopupContent(user?.name ?? "", user?.server ?? ""),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(context.localized.cancel),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom().copyWith(
                              foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
                              backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
                            ),
                            onPressed: () async {
                              await ref.read(authProvider.notifier).logOutUser();
                              if (context.mounted) {
                                context.router.replaceAll([const LoginRoute()]);
                              }
                            },
                            child: Text(context.localized.logout),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(
                    IconsaxOutline.logout,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
