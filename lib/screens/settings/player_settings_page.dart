import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_message_box.dart';
import 'package:fladder/screens/settings/widgets/subtitle_editor.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/video_player/components/video_player_options_sheet.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/box_fit_extension.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/option_dialogue.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';

@RoutePage()
class PlayerSettingsPage extends ConsumerStatefulWidget {
  const PlayerSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerSettingsPageState();
}

class _PlayerSettingsPageState extends ConsumerState<PlayerSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final videoSettings = ref.watch(videoPlayerSettingsProvider);
    final provider = ref.read(videoPlayerSettingsProvider.notifier);
    final showBackground = AdaptiveLayout.of(context).layout != LayoutState.phone &&
        AdaptiveLayout.of(context).size != ScreenLayout.single;
    return Card(
      elevation: showBackground ? 2 : 0,
      child: SettingsScaffold(
        label: context.localized.settingsPlayerTitle,
        items: [
          SettingsLabelDivider(label: context.localized.video),
          if (!AdaptiveLayout.of(context).isDesktop && !kIsWeb)
            SettingsListTile(
              label: Text(context.localized.videoScalingFillScreenTitle),
              subLabel: Text(context.localized.videoScalingFillScreenDesc),
              onTap: () => provider.setFillScreen(!videoSettings.fillScreen),
              trailing: Switch(
                value: videoSettings.fillScreen,
                onChanged: (value) => provider.setFillScreen(value),
              ),
            ),
          AnimatedFadeSize(
            child: videoSettings.fillScreen
                ? SettingsMessageBox(
                    context.localized.videoScalingFillScreenNotif,
                    messageType: MessageType.warning,
                  )
                : Container(),
          ),
          SettingsListTile(
            label: Text(context.localized.videoScalingFillScreenTitle),
            subLabel: Text(videoSettings.videoFit.label(context)),
            onTap: () => openOptionDialogue(
              context,
              label: context.localized.videoScalingFillScreenTitle,
              items: BoxFit.values,
              itemBuilder: (type) => RadioListTile.adaptive(
                title: Text(type?.label(context) ?? ""),
                value: type,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: EdgeInsets.zero,
                groupValue: ref.read(videoPlayerSettingsProvider.select((value) => value.videoFit)),
                onChanged: (value) {
                  provider.setFitType(value);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const Divider(),
          SettingsLabelDivider(label: context.localized.advanced),
          SettingsListTile(
            label: Text(context.localized.settingsPlayerVideoHWAccelTitle),
            subLabel: Text(context.localized.settingsPlayerVideoHWAccelDesc),
            onTap: () => provider.setHardwareAccel(!videoSettings.hardwareAccel),
            trailing: Switch(
              value: videoSettings.hardwareAccel,
              onChanged: (value) => provider.setHardwareAccel(value),
            ),
          ),
          if (!kIsWeb) ...[
            SettingsListTile(
              label: Text(context.localized.settingsPlayerNativeLibassAccelTitle),
              subLabel: Text(context.localized.settingsPlayerNativeLibassAccelDesc),
              onTap: () => provider.setUseLibass(!videoSettings.useLibass),
              trailing: Switch(
                value: videoSettings.useLibass,
                onChanged: (value) => provider.setUseLibass(value),
              ),
            ),
            AnimatedFadeSize(
              child: videoSettings.useLibass && videoSettings.hardwareAccel && Platform.isAndroid
                  ? SettingsMessageBox(
                      context.localized.settingsPlayerMobileWarning,
                      messageType: MessageType.warning,
                    )
                  : Container(),
            ),
          ],
          SettingsListTile(
            label: Text(context.localized.settingsAutoNextTitle),
            subLabel: Text(context.localized.settingsAutoNextDesc),
            trailing: EnumBox(
              current: ref.watch(
                videoPlayerSettingsProvider.select(
                  (value) => value.nextVideoType.label(context),
                ),
              ),
              itemBuilder: (context) => AutoNextType.values
                  .map(
                    (entry) => PopupMenuItem(
                      value: entry,
                      child: Text(entry.label(context)),
                      onTap: () => ref.read(videoPlayerSettingsProvider.notifier).state =
                          ref.read(videoPlayerSettingsProvider).copyWith(nextVideoType: entry),
                    ),
                  )
                  .toList(),
            ),
          ),
          AnimatedFadeSize(
            child: switch (ref.watch(videoPlayerSettingsProvider.select((value) => value.nextVideoType))) {
              AutoNextType.smart => SettingsMessageBox(AutoNextType.smart.desc(context)),
              AutoNextType.static => SettingsMessageBox(AutoNextType.static.desc(context)),
              _ => const SizedBox.shrink(),
            },
          ),
          SettingsListTile(
            label: Text(context.localized.settingsPlayerCustomSubtitlesTitle),
            subLabel: Text(context.localized.settingsPlayerCustomSubtitlesDesc),
            onTap: videoSettings.useLibass
                ? null
                : () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      useSafeArea: false,
                      builder: (context) => const SubtitleEditor(),
                    );
                  },
          ),
          if (!AdaptiveLayout.of(context).isDesktop && !kIsWeb)
            SettingsListTile(
              label: Text(context.localized.playerSettingsOrientationTitle),
              subLabel: Text(context.localized.playerSettingsOrientationDesc),
              onTap: () => showOrientationOptions(context, ref),
            ),
        ],
      ),
    );
  }
}
