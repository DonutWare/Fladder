import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/seerr/seerr_request_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/screens/seerr/widgets/seerr_user_label.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class RequestConfigurationSection extends ConsumerWidget {
  final SeerrRequestModel requestState;

  const RequestConfigurationSection({
    required this.requestState,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableProfiles = requestState.availableProfiles;
    final availableTags = requestState.availableTags;
    final availableRootFolders = requestState.availableRootFolders;
    final availableServers = requestState.availableServers;
    final currentServer = requestState.activeServer;
    final defaultRootFolder = requestState.defaultRootFolder;

    final hasConfigSection =
        availableServers.isNotEmpty || availableProfiles.isNotEmpty || availableRootFolders.isNotEmpty;

    if (!hasConfigSection) {
      return const SizedBox.shrink();
    }

    final notifier = ref.read(seerrRequestProvider.notifier);

    String rootFolderLabel(BuildContext context, String folder, String? defaultFolder) {
      if (defaultFolder != null && folder == defaultFolder) {
        return context.localized.rootFolderDefaultLabel(folder);
      }
      return folder;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          context.localized.requestConfiguration,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (availableServers.isNotEmpty && availableServers.length > 1)
          EnumSelection(
            label: Text(context.localized.server),
            current: requestState.serverLabel(currentServer),
            itemBuilder: (context) => availableServers
                .map(
                  (server) => ItemActionButton(
                    label: Text(requestState.serverLabel(server)),
                    action: () => notifier.selectServer(server),
                  ),
                )
                .toList(),
          ),
        if (availableProfiles.isNotEmpty)
          EnumSelection(
            label: Text(context.localized.qualityProfile),
            current: requestState.selectedProfile?.name ?? context.localized.selectProfile,
            itemBuilder: (context) => availableProfiles
                .map((profile) => ItemActionButton(
                      label: Text(profile.name ?? context.localized.unknown),
                      action: () => notifier.selectProfile(profile),
                    ))
                .toList(),
          ),
        if (availableRootFolders.isNotEmpty)
          EnumSelection(
            label: Text(context.localized.rootFolder),
            current: requestState.selectedRootFolder != null
                ? rootFolderLabel(context, requestState.selectedRootFolder!, defaultRootFolder)
                : context.localized.selectFolder,
            itemBuilder: (context) => availableRootFolders
                .map((folder) => ItemActionButton(
                      label: Text(rootFolderLabel(context, folder, defaultRootFolder)),
                      action: () => notifier.selectRootFolder(folder),
                    ))
                .toList(),
          ),
        if (availableTags.isNotEmpty)
          EnumSelection(
            label: Text(context.localized.tags),
            current: requestState.selectedTags.isEmpty
                ? context.localized.noTags
                : requestState.selectedTags.map((t) => t.label).join(', '),
            itemBuilder: (context) => [
              ItemActionButton(
                label: Text(context.localized.noTags),
                action: () => notifier.selectTags([]),
              ),
              ...availableTags.map((tag) => ItemActionButton(
                    label: Text(tag.label ?? context.localized.unknown),
                    selected: requestState.selectedTags.any((t) => t.id == tag.id),
                    action: () {
                      final current = List<SeerrServiceTag>.from(requestState.selectedTags);
                      if (current.any((t) => t.id == tag.id)) {
                        current.removeWhere((t) => t.id == tag.id);
                      } else {
                        current.add(tag);
                      }
                      notifier.selectTags(current);
                    },
                  )),
            ],
          ),
        if (requestState.currentUser != null)
          EnumSelection(
            label: Text(context.localized.requestAs),
            current: requestState.selectedUser?.label ?? requestState.currentUser?.label ?? context.localized.unknown,
            currentWidget: SeerrUserLabel(user: requestState.selectedUser ?? requestState.currentUser),
            itemBuilder: (context) {
              if (requestState.availableUsers.isEmpty) {
                Future.microtask(() => notifier.loadUsers());
              }

              final baseUser = requestState.currentUser!;
              final others = requestState.availableUsers.where((u) => u.id != baseUser.id).toList();

              return [
                ItemActionButton(
                  label: SeerrUserLabel(user: baseUser),
                  action: () => notifier.selectUser(baseUser),
                ),
                ...others.map(
                  (user) => ItemActionButton(
                    label: SeerrUserLabel(user: user),
                    action: () => notifier.selectUser(user),
                  ),
                ),
              ];
            },
          ),
      ],
    );
  }
}
