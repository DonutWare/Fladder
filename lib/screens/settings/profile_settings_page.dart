import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/models/seerr_credentials_model.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/cultures_provider.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/update_notifications_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/password_reset_dialog.dart';
import 'package:fladder/screens/settings/widgets/seerr_connection_dialog.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/settings/widgets/settings_message_box.dart';
import 'package:fladder/screens/shared/authenticate_button_options.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/services/notification_service.dart';
import 'package:fladder/util/jellyfin_extension.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/simple_duration_picker.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

@RoutePage()
class ProfileSettingsPage extends ConsumerStatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends ConsumerState<ProfileSettingsPage> {
  String _seerrStatusLabel(
    BuildContext context,
    SeerrCredentialsModel? credentials,
    SeerrUserModel? seerrUser,
  ) {
    if (credentials == null || credentials.serverUrl.isEmpty) return context.localized.seerrNotConfigured;

    if (credentials.sessionCookie.isNotEmpty || credentials.apiKey.isNotEmpty) {
      if (seerrUser == null) {
        return context.localized.seerrLoadingUser;
      }
      final displayName =
          seerrUser.displayName ?? seerrUser.username ?? seerrUser.email ?? context.localized.seerrUnknownUser;
      return context.localized.loggedInAs(displayName);
    }

    return context.localized.none;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final seerrUser = ref.watch(seerrUserProvider);
    final cultures = ref.watch(culturesProvider);
    final clientSettings = ref.watch(clientSettingsProvider);

    final allowedSubModes = {
      enums.SubtitlePlaybackMode.$default,
      enums.SubtitlePlaybackMode.smart,
      enums.SubtitlePlaybackMode.onlyforced,
      enums.SubtitlePlaybackMode.always,
      enums.SubtitlePlaybackMode.none,
    };
    return SettingsScaffold(
      label: context.localized.settingsProfileTitle,
      items: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.settingsSecurity),
          [
            SettingsListTile(
              label: Text(context.localized.settingSecurityApplockTitle),
              subLabel: Text(user?.authMethod.name(context) ?? ""),
              onTap: () => showAuthOptionsDialogue(
                context,
                user!,
                (newUser) {
                  ref.read(userProvider.notifier).updateUser(newUser);
                },
              ),
            ),
            SettingsListTile(
              label: Text(context.localized.password),
              onTap: () => openPasswordResetDialog(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.subtitles),
          [
            SettingsListTile(
              label: Text(context.localized.settingsProfileSubtitleLanguage),
              trailing: Builder(
                builder: (context) {
                  final currentCulture = cultures.firstWhereOrNull(
                    (element) =>
                        element.threeLetterISOLanguageName?.toLowerCase() ==
                        user?.userConfiguration?.subtitleLanguagePreference?.toLowerCase(),
                  );
                  return EnumBox(
                    current: user?.userConfiguration?.subtitleLanguagePreference == null
                        ? context.localized.none
                        : currentCulture?.displayName ?? context.localized.unknown,
                    itemBuilder: (context) => [
                      ItemActionButton(
                        selected: user?.userConfiguration?.subtitleLanguagePreference == null,
                        label: Text(context.localized.none),
                        action: () {
                          ref.read(userProvider.notifier).updateSubtitleLanguagePreference(null);
                        },
                      ),
                      ...cultures.map(
                        (e) => ItemActionButton(
                          selected: e.threeLetterISOLanguageName?.toLowerCase() ==
                              user?.userConfiguration?.subtitleLanguagePreference?.toLowerCase(),
                          label: Text(e.displayName ?? e.name ?? context.localized.unknown),
                          action: () {
                            ref
                                .read(userProvider.notifier)
                                .updateSubtitleLanguagePreference(e.threeLetterISOLanguageName?.toLowerCase());
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SettingsListTile(
              label: Text(context.localized.settingsProfileSubtitleMode),
              trailing: EnumBox(
                current: user?.userConfiguration?.subtitleMode?.label(context) ?? context.localized.none,
                itemBuilder: (context) => allowedSubModes
                    .map(
                      (mode) => ItemActionButton(
                        selected: user?.userConfiguration?.subtitleMode == mode,
                        label: Text(mode.label(context)),
                        action: () {
                          ref.read(userProvider.notifier).updateSubtitleMode(mode);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        if (ref.read(supportsNotificationsProvider)) ...[
          const SizedBox(height: 16),
          ...settingsListGroup(
            context,
            SettingsLabelDivider(label: context.localized.notifications),
            [
              Column(
                children: [
                  SettingsListTile(
                    label: Text(context.localized.updateCheckInterval),
                    subLabel: Text(context.localized.updateCheckIntervalDesc),
                    trailing: EnumBox(
                      current: timePickerString(context, clientSettings.updateNotificationsInterval),
                      itemBuilder: (context) {
                        final durations = const [
                          Duration(minutes: 15),
                          Duration(minutes: 30),
                          Duration(hours: 1),
                          Duration(hours: 3),
                          Duration(hours: 6),
                          Duration(hours: 12),
                          Duration(days: 1),
                        ];
                        return durations.map((duration) {
                          return ItemActionButton(
                            label: Text(timePickerString(context, duration)),
                            action: () =>
                                ref.read(clientSettingsProvider.notifier).setUpdateNotificationsInterval(duration),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  SettingsMessageBox(
                    context.localized.notificationsIntervalClientReminder,
                    messageType: MessageType.info,
                  ),
                  if (!kIsWeb && Platform.isIOS)
                    SettingsMessageBox(
                      context.localized.notificationTimerIOSWarning,
                      messageType: MessageType.info,
                    ),
                ],
              ),
              SettingsListTileCheckbox(
                label: Text(context.localized.showNewItemNotificationTitle),
                value: user?.updateNotificationsEnabled ?? false,
                onChanged: (val) async {
                  final current = ref.read(userProvider);
                  if (current == null || val == null) return;

                  ref.read(userProvider.notifier).userState = current.copyWith(updateNotificationsEnabled: val);

                  if (val) {
                    await NotificationService.requestPermission();
                    await ref.read(updateNotificationsProvider).registerBackgroundTask();
                  } else {
                    await ref.read(updateNotificationsProvider).unregisterBackgroundTask();
                  }
                },
              ),
              if (kDebugMode)
                SettingsListTile(
                  label: const Text('Show notification (debug)'),
                  subLabel: const Text('Show a native notification with the latest ~5 items for the active account'),
                  onTap: () async => await ref.read(updateNotificationsProvider).executeBackgroundTask(),
                ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.advanced),
          [
            SettingsListTile(
              label: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  if (user?.credentials.localUrl?.isNotEmpty == true)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: ref.watch(localConnectionAvailableProvider)
                            ? Colors.greenAccent
                            : Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(context.localized.settingsLocalUrlTitle),
                ],
              ),
              subLabel: Text(user?.credentials.localUrl ?? context.localized.none),
              onTap: () {
                openSimpleTextInput(
                  context,
                  user?.credentials.localUrl,
                  (value) => ref.read(userProvider.notifier).setLocalURL(value),
                  context.localized.settingsLocalUrlSetTitle,
                  context.localized.settingsLocalUrlSetDesc,
                );
              },
            ),
            SettingsListTile(
              label: Text(context.localized.seerr),
              subLabel: Text(_seerrStatusLabel(context, user?.seerrCredentials, seerrUser)),
              onTap: () => showSeerrConnectionDialog(context),
            ),
          ],
        ),
      ],
    );
  }
}
