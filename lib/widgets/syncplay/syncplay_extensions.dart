import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/util/localization_helper.dart';

extension SyncPlayGroupStateExtension on SyncPlayGroupState {
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

extension SyncPlayCommandLabelExtension on SyncPlayCommand? {
  String syncPlayProcessingLabel(BuildContext context) {
    return switch (this) {
      SyncPlayCommand.pause => context.localized.syncPlaySyncingPause,
      SyncPlayCommand.unpause => context.localized.syncPlaySyncingPlay,
      SyncPlayCommand.seek => context.localized.syncPlaySyncingSeek,
      SyncPlayCommand.stop => context.localized.syncPlayStopping,
      null => context.localized.syncPlaySyncing,
    };
  }

  String syncPlayCommandOverlayLabel(BuildContext context) {
    return switch (this) {
      SyncPlayCommand.pause => context.localized.syncPlayCommandPausing,
      SyncPlayCommand.unpause => context.localized.syncPlayCommandPlaying,
      SyncPlayCommand.seek => context.localized.syncPlayCommandSeeking,
      SyncPlayCommand.stop => context.localized.syncPlayCommandStopping,
      null => context.localized.syncPlayCommandSyncing,
    };
  }

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

extension SyncCorrectionStrategyExtension on SyncCorrectionStrategy {
  String label(BuildContext context) {
    return switch (this) {
      SyncCorrectionStrategy.none => context.localized.syncPlaySyncing,
      SyncCorrectionStrategy.speedToSync => 'SpeedToSync',
      SyncCorrectionStrategy.skipToSync => 'SkipToSync',
    };
  }

  (IconData, Color) iconAndColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      SyncCorrectionStrategy.none => (IconsaxPlusBold.refresh, scheme.primary),
      SyncCorrectionStrategy.speedToSync => (IconsaxPlusBold.flash_1, scheme.primary),
      SyncCorrectionStrategy.skipToSync => (IconsaxPlusBold.forward, scheme.tertiary),
    };
  }
}
