import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/screens/control_panel/control_user_edit/control_user_edit_access.dart';
import 'package:fladder/screens/control_panel/control_user_edit/control_user_edit_general.dart';
import 'package:fladder/screens/control_panel/control_user_edit/control_user_edit_parental_control.dart';
import 'package:fladder/screens/control_panel/control_user_edit/control_user_edit_password.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/user_icon.dart';
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
    final views = userEditor.views;
    final devices = userEditor.availableDevices ?? [];
    final parentalRatings = (userEditor.parentalRatings ?? []).groupListsBy((element) => element.ratingScore);

    return PullToRefresh(
      onRefresh: () => ref.read(controlUsersProvider.notifier).fetchSpecificUser(widget.userId),
      child: (context) => SettingsScaffold(
        label: context.localized.editUser,
        bottomActions: selectedOption == EditOptions.password
            ? []
            : [
                FilledButtonAwait.tonal(
                  onPressed: () async => await provider.fetchSpecificUser(widget.userId),
                  child: Text(context.localized.cancel),
                ),
                FilledButtonAwait(
                  onPressed: () async {
                    final response = await provider.saveUserPolicy();
                    if (response == null) {
                      FladderSnack.show(context.localized.saved, context: context);
                    } else {
                      FladderSnack.show(response, context: context);
                    }
                  },
                  child: Text(context.localized.save),
                )
              ],
        items: currentUser == null
            ? []
            : [
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 42,
                      child: UserIcon(user: currentUser),
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
                switch (selectedOption) {
                  EditOptions.general => UserGeneralTab(
                      nameController: nameController,
                      currentUser: currentUser,
                      currentPolicy: currentPolicy,
                      views: views,
                    ),
                  EditOptions.access => UserAccessTab(
                      currentPolicy: currentPolicy,
                      views: views,
                      devices: devices,
                    ),
                  EditOptions.parentalControl => UserParentalControlTab(
                      currentUser: currentUser,
                      currentPolicy: currentPolicy,
                      parentalRatings: parentalRatings,
                    ),
                  EditOptions.password => const ControlUserEditPassword(),
                },
              ],
      ),
    );
  }
}
