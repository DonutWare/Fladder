import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/jellyfin_extension.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class UserGeneralTab extends ConsumerWidget {
  final TextEditingController nameController;
  final AccountModel? currentUser;
  final UserPolicy? currentPolicy;
  final List<ViewModel> views;

  const UserGeneralTab({
    required this.nameController,
    required this.currentUser,
    required this.currentPolicy,
    required this.views,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(controlUsersProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.userInformation),
          [
            SettingsListTile(
              label: Text(context.localized.name),
              trailing: OutlinedTextField(
                controller: nameController..text = currentUser?.name ?? "",
                placeHolder: context.localized.userName,
                onSubmitted: (value) {},
              ),
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowManageServer),
              onChanged: (value) => provider.updateSelectedUserPolicy(
                currentPolicy?.copyWith(isAdministrator: value),
              ),
              value: currentPolicy?.isAdministrator ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowCollections),
              onChanged: (value) => provider.updateSelectedUserPolicy(
                currentPolicy?.copyWith(enableCollectionManagement: value),
              ),
              value: currentPolicy?.enableCollectionManagement ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowEditSubtitles),
              onChanged: (value) => provider.updateSelectedUserPolicy(
                currentPolicy?.copyWith(enableSubtitleManagement: value),
              ),
              value: currentPolicy?.enableSubtitleManagement ?? false,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.featureAccess),
          [
            SettingsListTileCheckbox(
              label: Text(context.localized.allowLiveTVAccess),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableLiveTvAccess: value),
                );
              },
              value: currentPolicy?.enableLiveTvAccess ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowLiveTVRecording),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableLiveTvManagement: value),
                );
              },
              value: currentPolicy?.enableLiveTvManagement ?? false,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.mediaPlayback),
          [
            SettingsListTileCheckbox(
              label: Text(context.localized.allowMediaPlayback),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableVideoPlaybackTranscoding: value),
                );
              },
              value: currentPolicy?.enableMediaPlayback ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowVideoTranscoding),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableVideoPlaybackTranscoding: value),
                );
              },
              value: currentPolicy?.enableVideoPlaybackTranscoding ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowAudioTranscoding),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableAudioPlaybackTranscoding: value),
                );
              },
              value: currentPolicy?.enableAudioPlaybackTranscoding ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.allowMediaConversion),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableMediaConversion: value),
                );
              },
              value: currentPolicy?.enableMediaConversion ?? false,
            ),
            SettingsListTileCheckbox(
              label: Text(context.localized.forceRemoteTranscoding),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(forceRemoteSourceTranscoding: value),
                );
              },
              value: currentPolicy?.forceRemoteSourceTranscoding ?? false,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.syncplay),
          [
            SettingsListTile(
              label: Text(context.localized.syncplayAccess),
              trailing: EnumBox(
                current: currentPolicy?.syncPlayAccess?.label(context) ?? context.localized.empty.capitalize(),
                itemBuilder: (context) => SyncPlayUserAccessType.values
                    .whereNot((value) => value == SyncPlayUserAccessType.swaggerGeneratedUnknown)
                    .map(
                      (e) => ItemActionButton(
                        label: Text(e.label(context) ?? ""),
                        action: () {
                          provider.updateSelectedUserPolicy(
                            currentPolicy?.copyWith(syncPlayAccess: e),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.allowMediaDeletion),
          [
            SettingsListTileCheckbox(
              label: Text(context.localized.allLibraries),
              onChanged: (value) {
                provider.updateSelectedUserPolicy(
                  currentPolicy?.copyWith(enableContentDeletion: value),
                );
              },
              value: currentPolicy?.enableContentDeletion ?? false,
            ),
            if (currentPolicy?.enableContentDeletion == false)
              ...views.map(
                (view) => SettingsListTileCheckbox(
                  label: Text(view.name),
                  onChanged: (value) {
                    final updatedFolders = currentPolicy?.enableContentDeletionFromFolders != null
                        ? List<String>.from(currentPolicy!.enableContentDeletionFromFolders!)
                        : <String>[];
                    if (value == true) {
                      updatedFolders.add(view.id);
                    } else {
                      updatedFolders.remove(view.id);
                    }
                    provider.updateSelectedUserPolicy(
                      currentPolicy?.copyWith(
                        enableContentDeletionFromFolders: updatedFolders,
                      ),
                    );
                  },
                  value: (currentPolicy?.enableContentDeletionFromFolders?.contains(view.id) ?? false) ||
                      currentPolicy?.enableContentDeletionFromFolders == null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
