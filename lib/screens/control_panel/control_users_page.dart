import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/control_panel/widgets/control_users_create.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class ControlUsersPage extends ConsumerWidget {
  const ControlUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(controlUsersProvider.select((value) => value.users));
    final provider = ref.read(controlUsersProvider.notifier);
    return PullToRefresh(
      child: SettingsScaffold(
        label: context.localized.users,
        itemSpacing: 12,
        items: [
          SettingsLabelDivider(label: context.localized.users),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: users.mapIndexed(
                (index, user) {
                  final userActions = [
                    ItemActionButton(
                      action: user.id == ref.read(userProvider)?.id
                          ? null
                          : () {
                              showDefaultAlertDialog(
                                context,
                                context.localized.deleteUserTitle(user.name),
                                context.localized.deleteUserDesc(user.name),
                                (context) async {
                                  provider.deleteUser(user.id);
                                  Navigator.of(context).pop();
                                },
                                context.localized.delete,
                                (context) => context.pop(),
                                context.localized.cancel,
                              );
                            },
                      label: Text(context.localized.delete),
                      icon: const Icon(IconsaxPlusBold.profile_delete),
                    ),
                  ];
                  return FocusButton(
                    autoFocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad && index == 0,
                    onTap: () => context.tabsRouter.navigate(ControlUserEditRoute(userId: user.id)),
                    onLongPress: () {
                      showBottomSheetPill(
                        context: context,
                        content: (context, controller) {
                          return ListView(
                            controller: controller,
                            shrinkWrap: true,
                            children: userActions.listTileItems(
                              context,
                              useIcons: true,
                            ),
                          );
                        },
                      );
                    },
                    onSecondaryTapDown: (globalPos) =>
                        _showContextMenu(context, ref, globalPos.globalPosition, userActions),
                    child: SizedBox(
                      width: 200,
                      child: _UserListItem(user: user),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const Divider(
            indent: 32,
            endIndent: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Builder(builder: (context) {
              return FilledButton.icon(
                onPressed: () async {
                  await openUserCreateDialog(context);
                  context.refreshData();
                },
                icon: const Icon(Icons.add),
                label: Text(context.localized.createNewUser),
              );
            }),
          )
        ],
      ),
      onRefresh: () => provider.fetchUsers(),
    );
  }

  Future<void> _showContextMenu(
      BuildContext context, WidgetRef ref, Offset globalPos, List<ItemAction> otherActions) async {
    final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
    await showMenu(
      context: context,
      position: position,
      items: otherActions.popupMenuItems(useIcons: true),
    );
  }
}

class _UserListItem extends StatelessWidget {
  final AccountModel user;
  const _UserListItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 280,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Column(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: UserIcon(
                      labelStyle: Theme.of(context).textTheme.headlineMedium,
                      user: user,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                user.name,
                maxLines: 2,
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Flexible(
              child: Text(
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                "${context.localized.lastActivity} ${user.lastUsed.timeAgo(context) ?? ""}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
