import 'package:flutter/material.dart' hide ConnectionState;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/incognito_mode_provider.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

class StatusBanners extends ConsumerWidget {
  const StatusBanners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offlineMode = ref.watch(offlineStateProvider);
    final incognitoMode = ref.watch(incognitoProvider);
    final statusBarHeight = AdaptiveLayout.of(context).statusBarHeight;

    final visible = offlineMode || incognitoMode;

    final theme = Theme.of(context);
    final offlineBackground = theme.colorScheme.errorContainer;
    final incognitoBackground = theme.colorScheme.secondaryContainer;

    final lerpFactor = offlineMode && incognitoMode ? 0.5 : (offlineMode ? 0.0 : 1.0);

    final mergeColor = Color.lerp(offlineBackground, incognitoBackground, lerpFactor) ?? theme.colorScheme.surface;

    return IgnorePointer(
      child: IntrinsicHeight(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          constraints: BoxConstraints(minHeight: AdaptiveLayout.of(context).statusBarHeight),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4).add(EdgeInsets.only(top: statusBarHeight)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                mergeColor.withValues(alpha: visible ? 0.8 : 0.0),
                mergeColor.withValues(alpha: 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              AnimatedFadeSize(
                child: offlineMode ? const OfflineBanner() : const SizedBox.shrink(key: ValueKey('offline_banner')),
              ),
              AnimatedFadeSize(
                child: incognitoMode ? const IncognitoMode() : const SizedBox.shrink(key: ValueKey('incognito_banner')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncognitoMode extends ConsumerWidget {
  const IncognitoMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.secondaryContainer;
    final foregroundColor = theme.colorScheme.onSecondaryContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusBold.eye_slash,
            color: foregroundColor,
            size: 20,
          ),
          Text(
            context.localized.incognito,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.errorContainer;
    final foregroundColor = theme.colorScheme.onErrorContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusBold.cloud_cross,
            color: foregroundColor,
            size: 20,
          ),
          Text(
            context.localized.offline,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
