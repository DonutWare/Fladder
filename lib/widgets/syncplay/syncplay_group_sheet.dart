import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

/// Bottom sheet for managing SyncPlay groups
class SyncPlayGroupSheet extends ConsumerStatefulWidget {
  const SyncPlayGroupSheet({super.key});

  @override
  ConsumerState<SyncPlayGroupSheet> createState() => _SyncPlayGroupSheetState();
}

class _SyncPlayGroupSheetState extends ConsumerState<SyncPlayGroupSheet> {
  @override
  void initState() {
    super.initState();
    // Defer so we don't modify a provider during the widget lifecycle (Riverpod disallows this).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(syncPlayGroupsProvider.notifier).loadGroups();
      }
    });
  }

  Future<void> _createGroup() async {
    final name = await _showCreateGroupDialog();
    if (name == null || name.isEmpty) return;

    ref.read(syncPlayGroupsProvider.notifier).setLoading(true);

    final group = await ref.read(syncPlayProvider.notifier).createGroup(name);
    if (group != null && mounted) {
      FladderSnack.show(context.localized.syncPlayCreatedGroup(group.groupName ?? ''), context: context);
      Navigator.of(context).pop();
    } else {
      if (mounted) {
        ref.read(syncPlayGroupsProvider.notifier).setLoading(false);
        FladderSnack.show(context.localized.syncPlayFailedToCreateGroup, context: context);
      }
    }
  }

  Future<String?> _showCreateGroupDialog() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localized.syncPlayCreateGroup),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.localized.syncPlayGroupName,
            hintText: context.localized.syncPlayGroupNameHint,
          ),
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.localized.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(context.localized.create),
          ),
        ],
      ),
    );
  }

  Future<void> _joinGroup(GroupInfoDto group) async {
    ref.read(syncPlayGroupsProvider.notifier).setLoading(true);

    final success = await ref.read(syncPlayProvider.notifier).joinGroup(group.groupId ?? '');
    if (success && mounted) {
      FladderSnack.show(context.localized.syncPlayJoinedGroup(group.groupName ?? ''), context: context);
      Navigator.of(context).pop();
    } else {
      if (mounted) {
        ref.read(syncPlayGroupsProvider.notifier).setLoading(false);
        FladderSnack.show(context.localized.syncPlayFailedToJoinGroup, context: context);
      }
    }
  }

  Future<void> _leaveGroup() async {
    await ref.read(syncPlayProvider.notifier).leaveGroup();
    if (mounted) {
      FladderSnack.show(context.localized.syncPlayLeftGroup, context: context);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncPlayState = ref.watch(syncPlayProvider);
    final groupsState = ref.watch(syncPlayGroupsProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8).add(MediaQuery.paddingOf(context)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: FladderTheme.largeShape.borderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.touch)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    height: 8,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: FladderTheme.largeShape.borderRadius,
                    ),
                  ),
                )
              else
                const SizedBox(height: 8),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.people,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        context.localized.syncPlay,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (syncPlayState.isInGroup)
                      TextButton.icon(
                        onPressed: _leaveGroup,
                        icon: const Icon(IconsaxPlusLinear.logout),
                        label: Text(context.localized.leave),
                      )
                    else
                      IconButton(
                        onPressed: _createGroup,
                        icon: const Icon(IconsaxPlusLinear.add),
                        tooltip: context.localized.create,
                      ),
                  ],
                ),
              ),

              const Divider(),

              // Content
              Flexible(
                child: _SyncPlaySheetContent(
                  syncPlayState: syncPlayState,
                  groupsState: groupsState,
                  onCreateGroup: _createGroup,
                  onJoinGroup: _joinGroup,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Content area of the SyncPlay group sheet (loading, error, empty, list, or active group).
class _SyncPlaySheetContent extends ConsumerWidget {
  const _SyncPlaySheetContent({
    required this.syncPlayState,
    required this.groupsState,
    required this.onCreateGroup,
    required this.onJoinGroup,
  });

  final SyncPlayState syncPlayState;
  final SyncPlayGroupsState groupsState;
  final VoidCallback onCreateGroup;
  final void Function(GroupInfoDto) onJoinGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (syncPlayState.isInGroup) {
      return _ActiveGroupView(state: syncPlayState);
    }
    if (groupsState.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (groupsState.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                IconsaxPlusLinear.warning_2,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                context.localized.syncPlayFailedToLoadGroups,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.read(syncPlayGroupsProvider.notifier).loadGroups(),
                child: Text(context.localized.retry),
              ),
            ],
          ),
        ),
      );
    }
    if (groupsState.groups == null || groupsState.groups!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                IconsaxPlusLinear.people,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                context.localized.syncPlayNoActiveGroups,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                context.localized.syncPlayCreateGroupHint,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                autofocus: true,
                onPressed: onCreateGroup,
                icon: const Icon(IconsaxPlusLinear.add),
                label: Text(context.localized.syncPlayCreateGroupButton),
              ),
            ],
          ),
        ),
      );
    }
    final groups = groupsState.groups!;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: groups.length,
      padding: const EdgeInsets.only(bottom: 16),
      itemBuilder: (context, index) {
        final group = groups[index];
        return _GroupListTile(
          group: group,
          onTap: () => onJoinGroup(group),
          autofocus: index == 0,
        );
      },
    );
  }
}

class _ActiveGroupView extends StatelessWidget {
  const _ActiveGroupView({required this.state});

  final SyncPlayState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  IconsaxPlusBold.people,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.groupName ?? context.localized.syncPlayGroupFallback,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      context.localized.syncPlayParticipants(state.participants.length),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _StateIndicator(state: state),
          const SizedBox(height: 16),
          Text(
            context.localized.syncPlayInstructions,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _StateIndicator extends StatelessWidget {
  const _StateIndicator({required this.state});

  final SyncPlayState state;

  @override
  Widget build(BuildContext context) {
    final (icon, label, color) = switch (state.groupState) {
      SyncPlayGroupState.idle => (
          IconsaxPlusLinear.pause_circle,
          context.localized.syncPlayStateIdle,
          Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      SyncPlayGroupState.waiting => (
          IconsaxPlusLinear.timer_1,
          context.localized.syncPlayStateWaiting,
          Theme.of(context).colorScheme.tertiary,
        ),
      SyncPlayGroupState.paused => (
          IconsaxPlusLinear.pause,
          context.localized.syncPlayStatePaused,
          Theme.of(context).colorScheme.secondary,
        ),
      SyncPlayGroupState.playing => (
          IconsaxPlusLinear.play,
          context.localized.syncPlayStatePlaying,
          Theme.of(context).colorScheme.primary,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _GroupListTile extends StatelessWidget {
  final GroupInfoDto group;
  final VoidCallback onTap;
  final bool autofocus;

  const _GroupListTile({
    required this.group,
    required this.onTap,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: autofocus,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          IconsaxPlusLinear.people,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(group.groupName ?? context.localized.syncPlayUnnamedGroup),
      subtitle: Text(
        context.localized.syncPlayParticipants(group.participants?.length ?? 0),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(IconsaxPlusLinear.arrow_right_3),
      onTap: onTap,
    );
  }
}
