import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/util/list_padding.dart';

class LoginEditUser extends ConsumerWidget {
  final AccountModel user;
  final ValueChanged<String>? onTapServer;
  const LoginEditUser({required this.user, this.onTapServer, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Center(child: Text(user.name)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(),
          if (user.credentials.serverName.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.dns_rounded),
                const SizedBox(width: 8),
                Text(user.credentials.serverName),
              ],
            ),
          if (user.credentials.server.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.http_rounded),
                const SizedBox(width: 8),
                Text(user.credentials.server),
                if (onTapServer != null) ...{
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    onPressed: () {
                      onTapServer?.call(user.credentials.server);
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                    ),
                  )
                }
              ],
            ),
          Row(
            children: [
              Icon(user.authMethod.icon),
              const SizedBox(width: 8),
              Text(user.authMethod.name(context)),
            ],
          ),
          Row(
            children: [
              const Icon(IconsaxPlusBold.clock),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMEd().format(user.lastUsed)),
                  Text(DateFormat.Hms().format(user.lastUsed)),
                ],
              ),
            ],
          ),
          const Divider(),
          Tooltip(
            message: "Removes the user and forces a logout",
            waitDuration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await ref.read(sharedUtilityProvider).removeAccount(user);
                  ref.read(authProvider.notifier).getSavedAccounts();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.remove_rounded),
                label: const Text("Remove user"),
              ),
            ),
          ),
        ].addPadding(const EdgeInsets.symmetric(vertical: 8)),
      ),
    );
  }
}
