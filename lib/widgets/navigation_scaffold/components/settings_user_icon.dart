import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

class SettingsUserIcon extends ConsumerWidget {
  final bool expanded;
  const SettingsUserIcon({this.expanded = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Tooltip(
      message: context.localized.settings,
      waitDuration: const Duration(seconds: 1),
      child: FlatButton(
        onLongPress: () => context.router.push(const LockRoute()),
        onTap: () {
          if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single) {
            context.router.push(const SettingsRoute());
          } else {
            context.router.push(const ClientSettingsRoute());
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: expanded ? 24 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              UserIcon(
                user: user,
                cornerRadius: 200,
              ),
              if (expanded && user?.name != null)
                Expanded(
                  child: Text(
                    user!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
