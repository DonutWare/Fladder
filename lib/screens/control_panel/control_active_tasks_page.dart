import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_active_tasks_provider.dart';
import 'package:fladder/screens/control_panel/widgets/control_panel_card.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/extensions/day_of_week_extensions.dart';
import 'package:fladder/util/extensions/task_trigger_type_extensions.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

@RoutePage()
class ControlActiveTasksPage extends ConsumerWidget {
  const ControlActiveTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTasks = ref.watch(controlActiveTasksProvider);
    final provider = ref.read(controlActiveTasksProvider.notifier);
    final groupedTasks = activeTasks.groupListsBy((task) => task.category ?? "Uncategorized");

    final dPadMode = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;

    return SettingsScaffold(
      label: context.localized.plannedTasks,
      itemSpacing: 12,
      items: [
        ...groupedTasks.entries.sorted((a, b) => a.key.compareTo(b.key)).map(
              (entry) => ControlPanelCard(
                title: entry.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: entry.value.sorted((a, b) => a.name?.compareTo(b.name ?? "") ?? 0).map(
                    (e) {
                      final timerIcon = e.triggers?.isNotEmpty == true
                          ? IconsaxPlusLinear.timer_start
                          : IconsaxPlusLinear.timer_pause;
                      return FocusButton(
                        onTap: dPadMode
                            ? () {
                                showDialogAdaptive(
                                  context: context,
                                  builder: (context) => _TimerSettings(taskId: e.id ?? ""),
                                );
                              }
                            : null,
                        onFocusChanged: (value) {
                          if (value) {
                            context.ensureVisible();
                          }
                        },
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 50),
                          child: Row(
                            spacing: 12,
                            children: [
                              if (!dPadMode)
                                IconButton.filledTonal(
                                  onPressed: () {
                                    showDialogAdaptive(
                                      context: context,
                                      builder: (context) => _TimerSettings(taskId: e.id ?? ""),
                                    );
                                  },
                                  icon: Icon(timerIcon),
                                )
                              else
                                Icon(timerIcon),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name ?? "",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Row(
                                      spacing: 12,
                                      children: [
                                        if (e.state == TaskState.running) ...[
                                          Flexible(
                                            child: LinearProgressIndicator(
                                              value: (e.currentProgressPercentage != null)
                                                  ? (e.currentProgressPercentage! / 100)
                                                  : null,
                                              minHeight: 8,
                                              borderRadius: BorderRadius.circular(16),
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                              color: Theme.of(context).colorScheme.primaryContainer,
                                            ),
                                          ),
                                          Text("${e.currentProgressPercentage?.toStringAsFixed(2) ?? "0"}%"),
                                        ],
                                      ],
                                    ),
                                    if (e.lastExecutionResult != null)
                                      Builder(builder: (context) {
                                        final lastStartTime = e.lastExecutionResult?.startTimeUtc ?? DateTime.now();
                                        final lastEndTime = e.lastExecutionResult?.endTimeUtc ?? DateTime.now();
                                        final duration = lastEndTime.difference(lastStartTime);
                                        return Text(
                                          context.localized.lastRunTaking(
                                              lastStartTime.timeAgo(context) ?? "",
                                              duration.inMinutes < 1
                                                  ? context.localized.lessThenAMinute.toLowerCase()
                                                  : duration.humanize ?? ""),
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant
                                                    .withValues(alpha: 0.65),
                                              ),
                                        );
                                      }),
                                  ],
                                ),
                              ),
                              if (!dPadMode)
                                ExcludeFocusTraversal(
                                  child: switch (e.state) {
                                    TaskState.running => IconButton(
                                        icon: const Icon(Icons.stop_rounded),
                                        onPressed: () => provider.stopTask(taskId: e.id!),
                                      ),
                                    TaskState.idle => IconButton(
                                        icon: const Icon(Icons.play_arrow_rounded),
                                        onPressed: () => provider.startTask(taskId: e.id!),
                                      ),
                                    _ => const SizedBox.shrink()
                                  },
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            )
      ],
    );
  }
}

class _TimerSettings extends ConsumerWidget {
  final String taskId;
  const _TimerSettings({
    required this.taskId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(controlActiveTasksProvider).firstWhere((element) => element.id == taskId);
    final triggers = task.triggers ?? [];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(task.name ?? "", style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            const Divider(),
            Text(task.description ?? "", style: Theme.of(context).textTheme.bodyMedium),
            FilledButton.icon(
              autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
              onPressed: () {
                showDialogAdaptive(
                  context: context,
                  builder: (context) => _NewTaskTrigger(onCreate: (trigger) {
                    final newTriggers = [...triggers, trigger];
                    ref.read(controlActiveTasksProvider.notifier).updateTaskTriggers(
                          taskId: task.id ?? "",
                          triggers: newTriggers,
                        );
                    Navigator.of(context).pop();
                  }),
                );
              },
              icon: const Icon(IconsaxPlusBold.add),
              label: Text(context.localized.newTrigger),
            ),
            if (triggers.isNotEmpty) ...[
              ...triggers.map(
                (e) => _TaskTriggerItem(
                  trigger: e,
                  onDelete: () async {
                    final newTriggers = triggers.where((element) => element != e).toList();
                    await ref.read(controlActiveTasksProvider.notifier).updateTaskTriggers(
                          taskId: task.id ?? "",
                          triggers: newTriggers,
                        );
                  },
                ),
              ),
            ],
            const Divider(),
            FilledButton.tonal(
              onPressed: () {
                switch (task.state) {
                  case TaskState.running:
                    ref.read(controlActiveTasksProvider.notifier).stopTask(taskId: task.id!);
                    break;
                  case TaskState.idle:
                    ref.read(controlActiveTasksProvider.notifier).startTask(taskId: task.id!);
                    break;
                  default:
                    break;
                }
              },
              child: Text(task.state == TaskState.running ? context.localized.stop : context.localized.start),
            )
          ],
        ),
      ),
    );
  }
}

class _NewTaskTrigger extends StatefulWidget {
  final Function(TaskTriggerInfo trigger) onCreate;
  const _NewTaskTrigger({
    required this.onCreate,
  });

  @override
  State<_NewTaskTrigger> createState() => _NewTaskTriggerState();
}

class _NewTaskTriggerState extends State<_NewTaskTrigger> {
  TaskTriggerInfoType _selectedType = TaskTriggerInfoType.intervaltrigger;

  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);
  DayOfWeek _selectedDay = DayOfWeek.monday;

  List<TimeOfDay> get _timeOptions {
    return List.generate(48, (index) => TimeOfDay(hour: index ~/ 2, minute: (index % 2) * 30));
  }

  int? timeLimitInHours;

  Duration _selectedInterval = const Duration(minutes: 15);
  List<Duration> get _intervalOptions => [
        const Duration(minutes: 5),
        const Duration(minutes: 15),
        const Duration(minutes: 30),
        const Duration(hours: 1),
        const Duration(hours: 6),
        const Duration(hours: 12),
        const Duration(days: 1),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 450, maxHeight: 800),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.localized.newTaskTrigger, style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          const Divider(),
          EnumSelection(
            label: Text(context.localized.taskTriggerTypeName),
            current: _selectedType.label(context),
            itemBuilder: (context) {
              return TaskTriggerInfoType.values
                  .whereNot((element) => element == TaskTriggerInfoType.swaggerGeneratedUnknown)
                  .map(
                    (e) => ItemActionButton(
                      label: Text(e.label(context)),
                      action: () => setState(() => _selectedType = e),
                    ),
                  )
                  .toList();
            },
          ),
          if (_selectedType == TaskTriggerInfoType.weeklytrigger)
            EnumSelection(
              label: Text(context.localized.dayOfTheWeek),
              current: _selectedDay.label(context).capitalize(),
              itemBuilder: (context) {
                return DayOfWeek.values
                    .whereNot((element) => element == DayOfWeek.swaggerGeneratedUnknown)
                    .map(
                      (e) => ItemActionButton(
                        label: Text(e.label(context).capitalize()),
                        action: () => setState(() => _selectedDay = e),
                      ),
                    )
                    .toList();
              },
            ),
          if (_selectedType != TaskTriggerInfoType.intervaltrigger)
            EnumSelection(
              label: Text(context.localized.time),
              current: _selectedTime.format(context),
              itemBuilder: (context) {
                return _timeOptions
                    .map(
                      (e) => ItemActionButton(
                        label: Text(e.format(context)),
                        action: () {
                          setState(() {
                            _selectedTime = e;
                          });
                        },
                      ),
                    )
                    .toList();
              },
            )
          else
            EnumSelection(
              label: Text(context.localized.interval),
              current: _selectedInterval.toLogicalDuration(context),
              itemBuilder: (context) {
                return _intervalOptions
                    .map(
                      (e) => ItemActionButton(
                        label: Text(e.toLogicalDuration(context)),
                        action: () {
                          setState(() {
                            _selectedInterval = e;
                          });
                        },
                      ),
                    )
                    .toList();
              },
            ),
          OutlinedTextField(
            label: context.localized.taskTimeLimitInHours,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                timeLimitInHours = int.tryParse(value);
              });
            },
          ),
          FilledButton(
            onPressed: () {
              final trigger = TaskTriggerInfo(
                type: _selectedType,
                dayOfWeek: _selectedType == TaskTriggerInfoType.weeklytrigger ? _selectedDay : null,
                timeOfDayTicks: _selectedType != TaskTriggerInfoType.intervaltrigger
                    ? (_selectedTime.hour * 60 + _selectedTime.minute) * 600000000
                    : null,
                maxRuntimeTicks: timeLimitInHours != null ? Duration(hours: timeLimitInHours!).toRuntimeTicks : null,
                intervalTicks:
                    _selectedType == TaskTriggerInfoType.intervaltrigger ? _selectedInterval.toRuntimeTicks : null,
              );
              widget.onCreate(trigger);
            },
            child: Text(context.localized.create),
          )
        ],
      ),
    );
  }
}

class _TaskTriggerItem extends StatelessWidget {
  final TaskTriggerInfo trigger;
  final Function() onDelete;
  const _TaskTriggerItem({
    required this.trigger,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final intervalTime = trigger.intervalTicks?.fromRuntimeTicks ?? Duration.zero;

    TimeOfDay tickToTimeOfDay(int ticks) {
      final duration = ticks.fromRuntimeTicks;
      return TimeOfDay(hour: duration.inHours % 24, minute: duration.inMinutes % 60);
    }

    final label = switch (trigger.type) {
      TaskTriggerInfoType.intervaltrigger =>
        context.localized.taskTriggerIntervalDesc(intervalTime.toLogicalDuration(context)),
      TaskTriggerInfoType.dailytrigger =>
        context.localized.taskTriggerDailyDesc(tickToTimeOfDay(trigger.timeOfDayTicks ?? 0).format(context)),
      TaskTriggerInfoType.weeklytrigger => context.localized.taskTriggerWeeklyDesc(
          trigger.dayOfWeek?.label(context) ?? "", tickToTimeOfDay(trigger.timeOfDayTicks ?? 0).format(context)),
      TaskTriggerInfoType.startuptrigger => context.localized.taskTriggerTypeStartup,
      _ => context.localized.unknown
    };
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(128),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (trigger.maxRuntimeTicks != null && trigger.maxRuntimeTicks! > 0)
                Text(
                  context.localized.taskTriggerTimeLimitSub(
                      trigger.maxRuntimeTicks?.fromRuntimeTicks.toLogicalDuration(context) ?? ""),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
                      ),
                ),
            ],
          ),
          IconButton.filled(
            onPressed: onDelete,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
            icon: const Icon(
              IconsaxPlusBold.trash,
            ),
          )
        ],
      ),
    );
  }
}
