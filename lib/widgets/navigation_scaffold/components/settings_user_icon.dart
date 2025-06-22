import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/update_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/theme_extensions.dart';

class SettingsUserIcon extends ConsumerWidget {
  const SettingsUserIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = 24.0;
    final user = ref.watch(userProvider);
    final hasNewUpdate = ref.watch(hasNewUpdateProvider);
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
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            UserIcon(
              user: user,
              cornerRadius: 200,
            ),
            if (hasNewUpdate)
              Transform.translate(
                offset: Offset(size / 4, size / 4),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: FittedBox(
                      child: Icon(
                        IconsaxPlusBold.information,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
