import 'package:flutter/material.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/localization_helper.dart';

Future<AccountModel?> showDeepLinkAccountDialog(
  BuildContext context, {
  required AccountModel currentUser,
  required List<AccountModel> accounts,
  bool linkedAccount = false,
}) {
  return showDialog<AccountModel>(
    context: context,
    builder: (context) => _DeepLinkAccountDialog(
      currentUser: currentUser,
      accounts: accounts,
      linkedAccount: linkedAccount,
    ),
  );
}

class _DeepLinkAccountDialog extends StatelessWidget {
  const _DeepLinkAccountDialog({
    required this.currentUser,
    required this.accounts,
    required this.linkedAccount,
  });

  final AccountModel currentUser;
  final List<AccountModel> accounts;
  final bool linkedAccount;

  @override
  Widget build(BuildContext context) {
    final description = linkedAccount && accounts.length == 1
        ? context.localized.deepLinkSwitchAccountDesc(accounts.first.name)
        : context.localized.deepLinkSwitchUserDesc(currentUser.name);
    return AlertDialog(
      title: Text(context.localized.deepLinkSwitchUserTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(description),
              ...accounts.indexed.map(
                (entry) => ListTile(
                  autofocus: entry.$1 == 0,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  leading: SizedBox.square(
                    dimension: 40,
                    child: UserIcon(user: entry.$2, size: const Size.square(40), cornerRadius: 12),
                  ),
                  title: Text(entry.$2.name),
                  subtitle: entry.$2.credentials.serverName.isNotEmpty ? Text(entry.$2.credentials.serverName) : null,
                  onTap: () => Navigator.of(context).pop(entry.$2),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
      ],
    );
  }
}
