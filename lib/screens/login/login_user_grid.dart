import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/list_padding.dart';

class LoginUserGrid extends ConsumerWidget {
  final List<AccountModel> users;
  final bool editMode;
  final ValueChanged<AccountModel>? onPressed;
  final ValueChanged<AccountModel>? onLongPress;
  const LoginUserGrid({
    this.users = const [],
    this.onPressed,
    this.editMode = false,
    this.onLongPress,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainAxisExtent = 175.0;
    final maxCount = (MediaQuery.of(context).size.width / mainAxisExtent).floor().clamp(1, 3);

    final crossAxisCount = users.length == 1 ? 1 : maxCount;

    final neededWidth = crossAxisCount * mainAxisExtent + (crossAxisCount - 1) * 24.0;

    final lastUsedAccount = users.sorted((a, b) => a.lastUsed.compareTo(b.lastUsed)).lastOrNull;

    return SizedBox(
      width: neededWidth,
      child: ReorderableGridView.builder(
        onReorder: (oldIndex, newIndex) => ref.read(authProvider.notifier).reOrderUsers(oldIndex, newIndex),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        autoScroll: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (users.length == 1 ? 1 : maxCount).toInt(),
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          mainAxisExtent: mainAxisExtent,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Center(
            key: Key(user.id),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: FocusButton(
                autoFocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad && lastUsedAccount != null
                    ? user.sameIdentity(lastUsedAccount)
                    : false,
                onTap: () => editMode ? onLongPress?.call(user) : onPressed?.call(user),
                onLongPress: switch (AdaptiveLayout.inputDeviceOf(context)) {
                  InputDevice.dPad || InputDevice.pointer => () => onLongPress?.call(user),
                  InputDevice.touch => null,
                },
                darkOverlay: false,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: UserIcon(
                              labelStyle: Theme.of(context).textTheme.headlineMedium,
                              user: user,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                user.authMethod.icon,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                  child: Text(
                                user.name,
                                maxLines: 2,
                                softWrap: true,
                              )),
                            ],
                          ),
                          if (user.credentials.serverName.isNotEmpty)
                            Opacity(
                              opacity: 0.75,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Icon(
                                    IconsaxPlusBold.driver_2,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      user.credentials.serverName,
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ].addInBetween(const SizedBox(width: 4, height: 4)),
                      ),
                    ),
                    if (editMode)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconsaxPlusBold.edit_2,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
