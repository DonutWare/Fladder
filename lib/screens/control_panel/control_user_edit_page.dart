import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/screens/control_panel/control_user_edit_access.dart';
import 'package:fladder/screens/control_panel/control_user_edit_general.dart';
import 'package:fladder/screens/control_panel/control_user_edit_parental_control.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

enum EditOptions {
  general,
  access,
  parentalControl,
  password,
}

@RoutePage()
class ControlUserEditPage extends ConsumerStatefulWidget {
  final String? userId;
  const ControlUserEditPage({
    @QueryParam('userId') this.userId,
    super.key,
  });

  @override
  ConsumerState<ControlUserEditPage> createState() => _ControlUserEditPageState();
}

class _ControlUserEditPageState extends ConsumerState<ControlUserEditPage> {
  TextEditingController nameController = TextEditingController();
  EditOptions selectedOption = EditOptions.general;

  @override
  Widget build(BuildContext context) {
    final userEditor = ref.watch(controlUsersProvider);
    final provider = ref.read(controlUsersProvider.notifier);
    final currentUser = userEditor.selectedUser;
    final currentPolicy = userEditor.editingPolicy;
    final views = ref.watch(viewsProvider.select((value) => value.views));
    final devices = userEditor.availableDevices ?? [];
    final parentalRatings = (userEditor.parentalRatings ?? []).groupListsBy((element) => element.ratingScore);

    return PullToRefresh(
      onRefresh: () => ref.read(controlUsersProvider.notifier).fetchSpecificUser(widget.userId),
      child: SettingsScaffold(
        label: context.localized.editUser,
        bottomActions: [
          FilledButtonAwait.tonal(
            onPressed: () async => await provider.fetchSpecificUser(widget.userId),
            child: Text(context.localized.cancel),
          ),
          const SizedBox(width: 8),
          FilledButtonAwait(
            onPressed: () async => await provider.saveUserPolicy(),
            child: Text(context.localized.save),
          )
        ],
        items: currentUser == null
            ? []
            : [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Text(
                        currentUser.name.isNotEmpty ? currentUser.name.substring(0, 1).toUpperCase() : "?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                SegmentedButton(
                    segments: EditOptions.values
                        .map(
                          (e) => ButtonSegment<EditOptions>(
                            value: e,
                            label: Text(
                              switch (e) {
                                EditOptions.general => context.localized.general,
                                EditOptions.access => context.localized.access,
                                EditOptions.parentalControl => context.localized.parentalControl,
                                EditOptions.password => context.localized.password,
                              },
                            ),
                          ),
                        )
                        .toList(),
                    selected: {selectedOption},
                    showSelectedIcon: false,
                    multiSelectionEnabled: false,
                    onSelectionChanged: (value) {
                      setState(() {
                        selectedOption = value.first;
                      });
                    }),
                const Divider(),
                ...switch (selectedOption) {
                  EditOptions.general => [
                      UserGeneralTab(
                        nameController: nameController,
                        currentUser: currentUser,
                        currentPolicy: currentPolicy,
                        views: views,
                      )
                    ],
                  EditOptions.access => [
                      UserAccessTab(
                        currentPolicy: currentPolicy,
                        views: views,
                        devices: devices,
                      )
                    ],
                  EditOptions.parentalControl => [
                      UserParentalControlTab(
                        currentUser: currentUser,
                        currentPolicy: currentPolicy,
                        views: views,
                        parentalRatings: parentalRatings,
                      )
                    ],
                  EditOptions.password => [Text(context.localized.passwordSettingsComing)],
                },
              ],
      ),
    );
  }
}
