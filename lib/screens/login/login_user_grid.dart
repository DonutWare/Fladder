import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/list_padding.dart';

class LoginUserGrid extends ConsumerWidget {
  final List<AccountModel> users;
  final bool editMode;
  final ValueChanged<AccountModel>? onPressed;
  final ValueChanged<AccountModel>? onLongPress;
  const LoginUserGrid({this.users = const [], this.onPressed, this.editMode = false, this.onLongPress, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainAxisExtent = 175.0;
    final maxCount = (MediaQuery.of(context).size.width ~/ mainAxisExtent).clamp(1, 3);

    return ReorderableGridView.builder(
      onReorder: (oldIndex, newIndex) => ref.read(authProvider.notifier).reOrderUsers(oldIndex, newIndex),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      autoScroll: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: users.length == 1 ? 1 : maxCount,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        mainAxisExtent: mainAxisExtent,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return FlatButton(
          key: Key(user.id),
          onTap: () => editMode ? onLongPress?.call(user) : onPressed?.call(user),
          onLongPress: () => onLongPress?.call(user),
          child: _CardHolder(
            content: Stack(
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
                                IconsaxBold.driver_2,
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
                            IconsaxBold.edit_2,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CardHolder extends StatelessWidget {
  final Widget content;

  const _CardHolder({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150, maxWidth: 150),
        child: content,
      ),
    );
  }
}
