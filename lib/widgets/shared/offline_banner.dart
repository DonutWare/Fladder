import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(connectivityStatusProvider.select((value) => value == ConnectionState.offline));
    final theme = Theme.of(context);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: isOffline ? 1 : 0,
      child: IgnorePointer(
        child: Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconsaxPlusLinear.cloud_cross,
              color: theme.colorScheme.onErrorContainer,
              size: 20,
            ),
            Text(
              context.localized.offline,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
