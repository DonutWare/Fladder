import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/list_padding.dart';

class LoginIcon extends ConsumerWidget {
  final AccountModel user;
  final Function()? onPressed;
  final Function()? onLongPress;
  final Function()? onNewPressed;
  const LoginIcon({
    required this.user,
    this.onPressed,
    this.onLongPress,
    this.onNewPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 4,
                    child: UserIcon(
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      size: const Size(125, 125),
                      user: user,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (onNewPressed != null)
                          Icon(
                            user.authMethod.icon,
                            size: 26,
                          ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            user.name,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.titleLarge,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (user.credentials.serverName.isNotEmpty)
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.dns_rounded,
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
                ].addInBetween(const SizedBox(width: 8, height: 8)),
              ),
            ),
            FlatButton(
              onTap: onPressed,
              onLongPress: onLongPress,
            )
          ],
        ),
      ),
    );
  }
}
