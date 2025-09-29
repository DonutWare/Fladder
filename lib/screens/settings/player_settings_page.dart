import 'dart:io' show Platform;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/key_listener.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/settings/widgets/settings_message_box.dart';
import 'package:fladder/screens/settings/widgets/subtitle_editor.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/screens/video_player/components/video_player_options_sheet.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/box_fit_extension.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

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

    final connectionState = ref.watch(connectivityStatusProvider);

    final userSettings = ref.watch(userProvider.select((value) => value?.userSettings));

    final screenshotsFolder = ref.watch(videoPlayerSettingsProvider.notifier).screenshotsFolder;

    return SettingsScaffold(
      label: context.localized.settingsPlayerTitle,
      items: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.video),
          [
            if (!AdaptiveLayout.of(context).isDesktop && !kIsWeb)
              Column(
                children: [
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
                ],
              ),
            SettingsListTile(
              label: Text(context.localized.videoScaling),
              trailing: EnumBox(
                current: videoSettings.videoFit.label(context),
                itemBuilder: (context) => BoxFit.values
                    .map(
                      (entry) => ItemActionButton(
                        label: Text(entry.label(context)),
                        action: () => ref.read(videoPlayerSettingsProvider.notifier).setFitType(entry),
                      ),
                    )
                    .toList(),
              ),
            ),
            SettingsListTile(
              label: _StatusIndicator(
                homeInternet: connectionState.homeInternet,
                label: Text(context.localized.homeStreamingQualityTitle),
              ),
              subLabel: Text(context.localized.homeStreamingQualityDesc),
              trailing: EnumBox(
                current: ref.watch(
                  videoPlayerSettingsProvider.select((value) => value.maxHomeBitrate.label(context)),
                ),
                itemBuilder: (context) => Bitrate.values
                    .map(
                      (entry) => ItemActionButton(
                        label: Text(entry.label(context)),
                        action: () => ref.read(videoPlayerSettingsProvider.notifier).state =
                            videoSettings.copyWith(maxHomeBitrate: entry),
                      ),
                    )
                    .toList(),
              ),
            ),
            SettingsListTile(
              label: _StatusIndicator(
                homeInternet: !connectionState.homeInternet,
                label: Text(context.localized.internetStreamingQualityTitle),
              ),
              subLabel: Text(context.localized.internetStreamingQualityDesc),
              trailing: EnumBox(
                current: ref.watch(
                  videoPlayerSettingsProvider.select((value) => value.maxInternetBitrate.label(context)),
                ),
                itemBuilder: (context) => Bitrate.values
                    .map(
                      (entry) => ItemActionButton(
                        label: Text(entry.label(context)),
                        action: () => ref.read(videoPlayerSettingsProvider.notifier).state =
                            videoSettings.copyWith(maxInternetBitrate: entry),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...settingsListGroup(context, SettingsLabelDivider(label: context.localized.mediaSegmentActions), [
          SettingsListTile(
            label: Text(context.localized.downloadsPath),
            subLabel: Text(screenshotsFolder ?? "-"),
            onTap: screenshotsFolder != null
                ? () async => await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(context.localized.pathEditTitle),
                        content: Text(context.localized.pathEditDesc),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
                                  dialogTitle: context.localized.pathEditSelect, initialDirectory: screenshotsFolder);
                              if (selectedDirectory != null) {
                                ref.read(videoPlayerSettingsProvider.notifier).setScreenshotsPath(selectedDirectory);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text(context.localized.change),
                          )
                        ],
                      ),
                    )
                : () async {
                    String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
                        dialogTitle: context.localized.pathEditSelect, initialDirectory: screenshotsFolder);
                    if (selectedDirectory != null) {
                      ref.read(videoPlayerSettingsProvider.notifier).setScreenshotsPath(selectedDirectory);
                    }
                  },
            trailing: screenshotsFolder?.isNotEmpty == true
                ? IconButton(
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () async => await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(context.localized.pathClearTitle),
                        content: Text(context.localized.pathEditDesc),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              ref.read(videoPlayerSettingsProvider.notifier).setScreenshotsPath(null);
                              Navigator.of(context).pop();
                            },
                            child: Text(context.localized.clear),
                          )
                        ],
                      ),
                    ),
                    icon: const Icon(IconsaxPlusLinear.folder_minus),
                  )
                : null,
          ),
          SettingsListTile(
            label: const Text("Format"),
            subLabel: Text(context.localized.settingsHomeBannerDescription),
            trailing: EnumBox(
              current: ref.watch(
                videoPlayerSettingsProvider.select(
                  (value) => value.screenshotFormat.label(context),
                ),
              ),
              itemBuilder: (context) => ScreenshotFormat.values
                  .map(
                    (entry) => ItemActionButton(
                      label: Text(entry.label(context)),
                      action: () =>
                          ref
                            .read(videoPlayerSettingsProvider.notifier)
                            .update((context) => context.copyWith(screenshotFormat: entry)),
                    ),
                  )
                  .toList(),
            ),
          ),
          SettingsListTile(
          label: const Text("Name padding"),
          subLabel: const Text("The amount of zeroes to use for padding the file name"),
          trailing: SizedBox(
              width: 100,
              child: IntInputField(
                controller: TextEditingController(text: ref.watch(videoPlayerSettingsProvider.notifier).screenshotNamePadding.toString()),
                onSubmitted: (value) {
                  ref.read(videoPlayerSettingsProvider.notifier).update(
                    (current) => current.copyWith(screenshotNamePadding: value ?? 3),
                  );

                  ref.read(videoPlayerSettingsProvider.notifier).setscreenshotNamePadding(value ?? 3);
                },
              )),
        ),
        ]),
        const SizedBox(height: 12),
        ...settingsListGroup(context, SettingsLabelDivider(label: context.localized.mediaSegmentActions), [
          ...videoSettings.segmentSkipSettings.entries.sorted((a, b) => b.key.index.compareTo(a.key.index)).map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.key.label(context),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      EnumBox(
                        current: entry.value.label(context),
                        itemBuilder: (context) => SegmentSkip.values
                            .map(
                              (value) => ItemActionButton(
                                label: Text(value.label(context)),
                                action: () {
                                  final newEntries = videoSettings.segmentSkipSettings.map(
                                      (key, currentValue) => MapEntry(key, key == entry.key ? value : currentValue));
                                  ref.read(videoPlayerSettingsProvider.notifier).state =
                                      videoSettings.copyWith(segmentSkipSettings: newEntries);
                                },
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
        ]),
        const SizedBox(height: 12),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.shortCuts),
          [
            if (userSettings != null)
              SettingsListTile(
                label: Text(context.localized.skipBackLength),
                trailing: SizedBox(
                    width: 125,
                    child: IntInputField(
                      suffix: context.localized.seconds(10),
                      controller: TextEditingController(text: userSettings.skipBackDuration.inSeconds.toString()),
                      onSubmitted: (value) {
                        if (value != null) {
                          ref.read(userProvider.notifier).setBackwardSpeed(value);
                        }
                      },
                    )),
              ),
            SettingsListTile(
              label: Text(context.localized.skipForwardLength),
              trailing: SizedBox(
                  width: 125,
                  child: IntInputField(
                    suffix: context.localized.seconds(10),
                    controller: TextEditingController(text: userSettings!.skipForwardDuration.inSeconds.toString()),
                    onSubmitted: (value) {
                      if (value != null) {
                        ref.read(userProvider.notifier).setForwardSpeed(value);
                      }
                    },
                  )),
            ),
            if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer)
              ExpansionTile(
                title: Text(
                  context.localized.keyboardShortCuts,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                children: VideoHotKeys.values
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.label(context),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Flexible(
                              child: KeyCombinationWidget(
                                currentKey: videoSettings.hotKeys[entry],
                                defaultKey: videoSettings.defaultShortCuts[entry]!,
                                onChanged: (value) =>
                                    ref.read(videoPlayerSettingsProvider.notifier).setShortcuts(MapEntry(entry, value)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ...settingsListGroup(context, SettingsLabelDivider(label: context.localized.playbackTrackSelection), [
          SettingsListTile(
            label: Text(context.localized.rememberAudioSelections),
            subLabel: Text(context.localized.rememberAudioSelectionsDesc),
            onTap: () => ref.read(userProvider.notifier).setRememberAudioSelections(),
            trailing: Switch(
              value: ref.watch(userProvider.select(
                (value) => value?.userConfiguration?.rememberAudioSelections ?? true,
              )),
              onChanged: (_) => ref.read(userProvider.notifier).setRememberAudioSelections(),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.rememberSubtitleSelections),
            subLabel: Text(context.localized.rememberSubtitleSelectionsDesc),
            onTap: () => ref.read(userProvider.notifier).setRememberSubtitleSelections(),
            trailing: Switch(
              value: ref.watch(userProvider.select(
                (value) => value?.userConfiguration?.rememberSubtitleSelections ?? true,
              )),
              onChanged: (_) => ref.read(userProvider.notifier).setRememberSubtitleSelections(),
            ),
          ),
        ]),
        const SizedBox(height: 12),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.advanced),
          [
            if (PlayerOptions.available.length != 1)
              SettingsListTile(
                label: Text(context.localized.playerSettingsBackendTitle),
                subLabel: Text(context.localized.playerSettingsBackendDesc),
                trailing: Builder(builder: (context) {
                  final wantedPlayer = videoSettings.wantedPlayer;
                  final currentPlayer = videoSettings.playerOptions;
                  return EnumBox(
                    current: currentPlayer == null
                        ? "${context.localized.defaultLabel} (${PlayerOptions.platformDefaults.label(context)})"
                        : wantedPlayer.label(context),
                    itemBuilder: (context) => [
                      ItemActionButton(
                        label: Text(
                            "${context.localized.defaultLabel} (${PlayerOptions.platformDefaults.label(context)})"),
                        action: () => ref.read(videoPlayerSettingsProvider.notifier).state =
                            videoSettings.copyWith(playerOptions: null),
                      ),
                      ...PlayerOptions.available.map(
                        (entry) => ItemActionButton(
                          label: Text(entry.label(context)),
                          action: () => ref.read(videoPlayerSettingsProvider.notifier).state =
                              videoSettings.copyWith(playerOptions: entry),
                        ),
                      )
                    ],
                  );
                }),
              ),
            AnimatedFadeSize(
              child: switch (videoSettings.wantedPlayer) {
                PlayerOptions.libMPV => Column(
                    children: [
                      SettingsListTile(
                        label: Text(context.localized.settingsPlayerVideoHWAccelTitle),
                        subLabel: Text(context.localized.settingsPlayerVideoHWAccelDesc),
                        onTap: () => provider.setHardwareAccel(!videoSettings.hardwareAccel),
                        trailing: Switch(
                          value: videoSettings.hardwareAccel,
                          onChanged: (value) => provider.setHardwareAccel(value),
                        ),
                      ),
                      if (!kIsWeb)
                        SettingsListTile(
                          label: Text(context.localized.settingsPlayerNativeLibassAccelTitle),
                          subLabel: Text(context.localized.settingsPlayerNativeLibassAccelDesc),
                          onTap: () => provider.setUseLibass(!videoSettings.useLibass),
                          trailing: Switch(
                            value: videoSettings.useLibass,
                            onChanged: (value) => provider.setUseLibass(value),
                          ),
                        ),
                      if (!videoSettings.useLibass)
                        SettingsListTile(
                          label: Text(context.localized.settingsPlayerCustomSubtitlesTitle),
                          subLabel: Text(context.localized.settingsPlayerCustomSubtitlesDesc),
                          onTap: videoSettings.useLibass
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    useSafeArea: false,
                                    builder: (context) => const SubtitleEditor(),
                                  );
                                },
                        ),
                      AnimatedFadeSize(
                        child: videoSettings.useLibass && videoSettings.hardwareAccel && Platform.isAndroid
                            ? SettingsMessageBox(
                                context.localized.settingsPlayerMobileWarning,
                                messageType: MessageType.warning,
                              )
                            : Container(),
                      ),
                      SettingsListTile(
                        label: Text(context.localized.settingsPlayerBufferSizeTitle),
                        subLabel: Text(context.localized.settingsPlayerBufferSizeDesc),
                        trailing: SizedBox(
                            width: 70,
                            child: IntInputField(
                              suffix: 'MB',
                              controller: TextEditingController(text: videoSettings.bufferSize.toString()),
                              onSubmitted: (value) {
                                if (value != null) {
                                  provider.setBufferSize(value);
                                }
                              },
                            )),
                      ),
                    ],
                  ),
                PlayerOptions.nativePlayer => Column(
                    children: [
                      SettingsListTile(
                        label: Text(context.localized.mediaTunnelingTitle),
                        subLabel: Text(context.localized.mediaTunnelingDesc),
                        onTap: () => provider.setMediaTunneling(!videoSettings.enableTunneling),
                        trailing: Switch(
                          value: videoSettings.enableTunneling,
                          onChanged: (value) => provider.setMediaTunneling(value),
                        ),
                      ),
                    ],
                  ),
                PlayerOptions.libMDK => SettingsMessageBox(
                    messageType: MessageType.info,
                    "${context.localized.noVideoPlayerOptions}\n${context.localized.mdkExperimental}"),
              },
            ),
            Column(
              children: [
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
                          (entry) => ItemActionButton(
                            label: Text(entry.label(context)),
                            action: () => ref.read(videoPlayerSettingsProvider.notifier).state =
                                videoSettings.copyWith(nextVideoType: entry),
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
              ],
            ),
            if (!AdaptiveLayout.of(context).isDesktop && !kIsWeb && !ref.read(argumentsStateProvider).htpcMode)
              SettingsListTile(
                label: Text(context.localized.playerSettingsOrientationTitle),
                subLabel: Text(context.localized.playerSettingsOrientationDesc),
                onTap: () => showOrientationOptions(context, ref),
              ),
          ],
        ),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final bool homeInternet;
  final Widget label;
  const _StatusIndicator({required this.homeInternet, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (homeInternet) ...[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
        ],
        Flexible(child: label),
      ],
    );
  }
}
