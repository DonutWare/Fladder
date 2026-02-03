import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_active_tasks_provider.dart';
import 'package:fladder/providers/control_panel/control_livetv_provider.dart';
import 'package:fladder/screens/control_panel/control_livetv/listing_provider_edit_dialog.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';

class RefreshGuideButton extends ConsumerWidget {
  static const String refreshGuideTaskId = 'bea9b218c97bbf98c5dc1303bdb9a0ca';

  const RefreshGuideButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTasks = ref.watch(controlActiveTasksProvider);
    final refreshTask = activeTasks.firstWhere(
      (task) => task.id == refreshGuideTaskId,
      orElse: () => const TaskInfo(),
    );
    final isRunning = refreshTask.state == TaskState.running;
    final progress = refreshTask.currentProgressPercentage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final result = await showDialog<ListingsProviderInfo>(
                  context: context,
                  builder: (context) => const ListingProviderEditDialog(),
                );
                if (result != null && context.mounted) {
                  final response = await fladderSnackbarApiResult<ListingsProviderInfo>(
                    context,
                    ref.read(controlLiveTvProvider.notifier).addListingProvider(result),
                    successTitle: context.localized.epgProviderAddedSuccessfully,
                    errorTitle: (err) => context.localized.failedToAddEpgProvider(err),
                  );
                  if (response.isSuccess && context.mounted) {
                    await context.refreshData();
                  }
                }
              },
              icon: const Icon(IconsaxPlusLinear.add),
              label: Text(context.localized.addProvider),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: isRunning
                  ? null
                  : () {
                      ref.read(controlActiveTasksProvider.notifier).startTask(taskId: refreshGuideTaskId);
                    },
              icon: Icon(isRunning ? Icons.refresh_rounded : IconsaxPlusLinear.refresh),
              label: Text(context.localized.refresh),
            ),
          ],
        ),
        if (isRunning)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress != null ? (progress / 100) : null,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${progress?.toStringAsFixed(1) ?? '0'}%",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                refreshTask.name ?? context.localized.refresh,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
                    ),
              ),
            ],
          ),
      ],
    );
  }
}
