import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/util/localization_helper.dart';

/// Extension on [SyncPlayGroupState] for badge/indicator icon and color.
extension SyncPlayGroupStateExtension on SyncPlayGroupState {
  /// Returns (icon, color) for the current group state.
  (IconData, Color) iconAndColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      SyncPlayGroupState.idle => (
          IconsaxPlusLinear.pause_circle,
          scheme.onSurfaceVariant,
        ),
      SyncPlayGroupState.waiting => (
          IconsaxPlusLinear.timer_1,
          scheme.tertiary,
        ),
      SyncPlayGroupState.paused => (
          IconsaxPlusLinear.pause,
          scheme.secondary,
        ),
      SyncPlayGroupState.playing => (
          IconsaxPlusLinear.play,
          scheme.primary,
        ),
    };
  }

  /// Returns the color only (for compact indicator).
  Color color(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      SyncPlayGroupState.idle => scheme.onSurfaceVariant,
      SyncPlayGroupState.waiting => scheme.tertiary,
      SyncPlayGroupState.paused => scheme.secondary,
      SyncPlayGroupState.playing => scheme.primary,
    };
  }
}

/// Extension for localized SyncPlay command processing label (command type string).
extension SyncPlayCommandLabelExtension on String? {
  /// Returns the localized "Syncing..." text for this command type.
  String syncPlayProcessingLabel(BuildContext context) {
    return switch (this) {
      'Pause' => context.localized.syncPlaySyncingPause,
      'Unpause' => context.localized.syncPlaySyncingPlay,
      'Seek' => context.localized.syncPlaySyncingSeek,
      'Stop' => context.localized.syncPlayStopping,
      _ => context.localized.syncPlaySyncing,
    };
  }

  /// Returns the short command label for overlay (e.g. "Pausing", "Seeking").
  String syncPlayCommandOverlayLabel(BuildContext context) {
    return switch (this) {
      'Pause' => context.localized.syncPlayCommandPausing,
      'Unpause' => context.localized.syncPlayCommandPlaying,
      'Seek' => context.localized.syncPlayCommandSeeking,
      'Stop' => context.localized.syncPlayCommandStopping,
      _ => context.localized.syncPlayCommandSyncing,
    };
  }

  /// Returns (icon, color) for the command overlay.
  (IconData, Color) syncPlayCommandIconAndColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      'Pause' => (IconsaxPlusBold.pause, scheme.secondary),
      'Unpause' => (IconsaxPlusBold.play, scheme.primary),
      'Seek' => (IconsaxPlusBold.forward, scheme.tertiary),
      'Stop' => (IconsaxPlusBold.stop, scheme.error),
      _ => (IconsaxPlusBold.refresh, scheme.primary),
    };
  }
}
