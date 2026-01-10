import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
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
  List<GroupInfoDto>? _groups;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Ensure we're connected first
      await ref.read(syncPlayProvider.notifier).connect();
      final groups = await ref.read(syncPlayProvider.notifier).listGroups();
      if (mounted) {
        setState(() {
          _groups = groups;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _createGroup() async {
    final name = await _showCreateGroupDialog();
    if (name == null || name.isEmpty) return;

    setState(() => _isLoading = true);

    final group = await ref.read(syncPlayProvider.notifier).createGroup(name);
    if (group != null && mounted) {
      fladderSnackbar(context, title: 'Created group "${group.groupName}"');
      Navigator.of(context).pop();
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        fladderSnackbar(context, title: 'Failed to create group');
      }
    }
  }

  Future<String?> _showCreateGroupDialog() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create SyncPlay Group'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Group Name',
            hintText: 'Movie Night',
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
    setState(() => _isLoading = true);

    final success = await ref.read(syncPlayProvider.notifier).joinGroup(group.groupId ?? '');
    if (success && mounted) {
      fladderSnackbar(context, title: 'Joined "${group.groupName}"');
      Navigator.of(context).pop();
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        fladderSnackbar(context, title: 'Failed to join group');
      }
    }
  }

  Future<void> _leaveGroup() async {
    await ref.read(syncPlayProvider.notifier).leaveGroup();
    if (mounted) {
      fladderSnackbar(context, title: 'Left SyncPlay group');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncPlayState = ref.watch(syncPlayProvider);

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
                        'SyncPlay',
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
                child: _buildContent(syncPlayState),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(SyncPlayState syncPlayState) {
    // If already in a group, show group info
    if (syncPlayState.isInGroup) {
      return _buildActiveGroupView(syncPlayState);
    }

    // Loading state
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Error state
    if (_error != null) {
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
                'Failed to load groups',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _loadGroups,
                child: Text(context.localized.retry),
              ),
            ],
          ),
        ),
      );
    }

    // Empty state
    if (_groups == null || _groups!.isEmpty) {
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
                'No active groups',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Create a group to watch together',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _createGroup,
                icon: const Icon(IconsaxPlusLinear.add),
                label: const Text('Create Group'),
              ),
            ],
          ),
        ),
      );
    }

    // Group list
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _groups!.length,
      padding: const EdgeInsets.only(bottom: 16),
      itemBuilder: (context, index) {
        final group = _groups![index];
        return _GroupListTile(
          group: group,
          onTap: () => _joinGroup(group),
        );
      },
    );
  }

  Widget _buildActiveGroupView(SyncPlayState state) {
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
                      state.groupName ?? 'SyncPlay Group',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${state.participants.length} participants',
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

          // State indicator
          _buildStateIndicator(state),

          const SizedBox(height: 16),

          // Instructions
          Text(
            'Browse your library and start playing something to sync with the group.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateIndicator(SyncPlayState state) {
    final (icon, label, color) = switch (state.groupState) {
      SyncPlayGroupState.idle => (
          IconsaxPlusLinear.pause_circle,
          'Idle',
          Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      SyncPlayGroupState.waiting => (
          IconsaxPlusLinear.timer_1,
          'Waiting for others...',
          Theme.of(context).colorScheme.tertiary,
        ),
      SyncPlayGroupState.paused => (
          IconsaxPlusLinear.pause,
          'Paused',
          Theme.of(context).colorScheme.secondary,
        ),
      SyncPlayGroupState.playing => (
          IconsaxPlusLinear.play,
          'Playing',
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

  const _GroupListTile({
    required this.group,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          IconsaxPlusLinear.people,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(group.groupName ?? 'Unnamed Group'),
      subtitle: Text(
        '${group.participants?.length ?? 0} participants',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(IconsaxPlusLinear.arrow_right_3),
      onTap: onTap,
    );
  }
}
