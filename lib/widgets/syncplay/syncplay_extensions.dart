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

/// Extension for localized SyncPlay command processing label (typed
/// against [SyncPlayCommand] instead of raw strings - see AGENTS.md
/// SyncPlay rule 6 about centralizing repeated display logic).
extension SyncPlayCommandLabelExtension on SyncPlayCommand? {
  /// Returns the localized "Syncing..." text for this command type.
  String syncPlayProcessingLabel(BuildContext context) {
    return switch (this) {
      SyncPlayCommand.pause => context.localized.syncPlaySyncingPause,
      SyncPlayCommand.unpause => context.localized.syncPlaySyncingPlay,
      SyncPlayCommand.seek => context.localized.syncPlaySyncingSeek,
      SyncPlayCommand.stop => context.localized.syncPlayStopping,
      null => context.localized.syncPlaySyncing,
    };
  }

  /// Returns the short command label for overlay (e.g. "Pausing").
  String syncPlayCommandOverlayLabel(BuildContext context) {
    return switch (this) {
      SyncPlayCommand.pause => context.localized.syncPlayCommandPausing,
      SyncPlayCommand.unpause => context.localized.syncPlayCommandPlaying,
      SyncPlayCommand.seek => context.localized.syncPlayCommandSeeking,
      SyncPlayCommand.stop => context.localized.syncPlayCommandStopping,
      null => context.localized.syncPlayCommandSyncing,
    };
  }

  /// Returns (icon, color) for the command overlay.
  (IconData, Color) syncPlayCommandIconAndColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      SyncPlayCommand.pause => (IconsaxPlusBold.pause, scheme.secondary),
      SyncPlayCommand.unpause => (IconsaxPlusBold.play, scheme.primary),
      SyncPlayCommand.seek => (IconsaxPlusBold.forward, scheme.tertiary),
      SyncPlayCommand.stop => (IconsaxPlusBold.stop, scheme.error),
      null => (IconsaxPlusBold.refresh, scheme.primary),
    };
  }
}

/// Extension for correction strategy UI mapping.
extension SyncCorrectionStrategyExtension on SyncCorrectionStrategy {
  /// Returns short label for active correction strategy.
  String label(BuildContext context) {
    return switch (this) {
      SyncCorrectionStrategy.none => context.localized.syncPlaySyncing,
      SyncCorrectionStrategy.speedToSync => 'SpeedToSync',
      SyncCorrectionStrategy.skipToSync => 'SkipToSync',
    };
  }

  /// Returns icon and color for active correction strategy.
  (IconData, Color) iconAndColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      SyncCorrectionStrategy.none => (IconsaxPlusBold.refresh, scheme.primary),
      SyncCorrectionStrategy.speedToSync => (IconsaxPlusBold.flash_1, scheme.primary),
      SyncCorrectionStrategy.skipToSync => (IconsaxPlusBold.forward, scheme.tertiary),
    };
  }
}
