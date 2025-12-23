import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';

class UserAccessTab extends ConsumerWidget {
  final UserPolicy? currentPolicy;
  final List<ViewModel> views;
  final List<DeviceInfoDto> devices;

  const UserAccessTab({
    required this.currentPolicy,
    required this.views,
    required this.devices,
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
          SettingsLabelDivider(label: context.localized.libraryAccess),
          [
            Column(
              children: [
                SettingsListTileCheckbox(
                  label: Text(context.localized.enableAllLibraries),
                  onChanged: (value) => provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(enableAllFolders: value),
                  ),
                  value: currentPolicy?.enableAllFolders ?? false,
                ),
                if (currentPolicy?.enableAllFolders == false)
                  ...views.map(
                    (library) => SettingsListTileCheckbox(
                      label: Text(library.name),
                      onChanged: (value) => provider.updateSelectedUserPolicy(
                        currentPolicy?.copyWith(
                          enabledFolders: currentPolicy?.enabledFolders?.contains(library.id) == true
                              ? (currentPolicy?.enabledFolders ?? []).where((id) => id != library.id).toList()
                              : [...(currentPolicy?.enabledFolders ?? []), library.id],
                        ),
                      ),
                      value: currentPolicy?.enabledFolders?.contains(library.id) ?? false,
                    ),
                  ),
              ],
            ),
            Column(
              children: [
                SettingsListTileCheckbox(
                  label: Text(context.localized.enableAllDevices),
                  onChanged: (value) {
                    if (value == false) {
                      provider.updateSelectedUserPolicy(
                        currentPolicy?.copyWith(
                          enableAllDevices: value,
                          enabledDevices: [],
                        ),
                      );
                    }
                    return provider.updateSelectedUserPolicy(
                      currentPolicy?.copyWith(
                        enableAllDevices: value,
                        enabledDevices: value == false ? devices.map((e) => e.id ?? "").toList() : [],
                      ),
                    );
                  },
                  value: currentPolicy?.enableAllDevices ?? false,
                ),
                if (currentPolicy?.enableAllDevices == false)
                  ...devices.map(
                    (device) => SettingsListTileCheckbox(
                      label: Text("${device.name ?? ""} - ${device.appName ?? ""}"),
                      onChanged: (value) => provider.updateSelectedUserPolicy(
                        currentPolicy?.copyWith(
                          enabledDevices: currentPolicy?.enabledDevices?.contains(device.id) == true
                              ? (currentPolicy?.enabledDevices ?? []).where((id) => id != device.id).toList()
                              : [...(currentPolicy?.enabledDevices ?? []), device.id ?? ""],
                        ),
                      ),
                      value: currentPolicy?.enabledDevices?.contains(device.id) ?? false,
                    ),
                  )
              ],
            )
          ],
        ),
      ],
    );
  }
}
