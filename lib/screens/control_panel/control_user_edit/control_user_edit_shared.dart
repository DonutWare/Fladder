import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/extensions/day_of_week_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class AccessSchedulesEditor extends StatelessWidget {
  final String label;
  final List<AccessSchedule> schedules;
  final Function(AccessSchedule schedule)? onAddSchedule;
  final Function(AccessSchedule schedule)? onRemoveSchedule;
  const AccessSchedulesEditor({
    required this.label,
    required this.schedules,
    this.onAddSchedule,
    this.onRemoveSchedule,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<TimeOfDay> timesOfDay = List.generate(
      48,
      (index) => TimeOfDay(hour: index ~/ 2, minute: (index % 2) * 30),
    );

    return Container(
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton.filledTonal(
                icon: const Icon(IconsaxPlusBold.add_circle),
                onPressed: () {
                  DynamicDayOfWeek selectedDay = DynamicDayOfWeek.values.first;
                  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
                  TimeOfDay endTime = const TimeOfDay(hour: 20, minute: 0);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(context.localized.addAccessSchedule),
                        content: StatefulBuilder(builder: (context, setState) {
                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 500,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 16,
                              children: [
                                EnumSelection(
                                  label: Text(context.localized.dayOfWeek),
                                  current: selectedDay.label(context).capitalize(),
                                  itemBuilder: (context) => DynamicDayOfWeek.values
                                      .map(
                                        (e) => ItemActionButton(
                                          label: Text(e.label(context).capitalize()),
                                          action: () {
                                            setState(() {
                                              selectedDay = e;
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                                EnumSelection(
                                  label: Text(context.localized.startTime),
                                  current: context.localized
                                      .formattedTime(DateTime(0, 0, 0, startTime.hour, startTime.minute)),
                                  itemBuilder: (context) => timesOfDay
                                      .map(
                                        (e) => ItemActionButton(
                                          label: Text(
                                              context.localized.formattedTime(DateTime(0, 0, 0, e.hour, e.minute))),
                                          action: () {
                                            setState(() {
                                              startTime = e;
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                                EnumSelection(
                                  label: Text(context.localized.endTime),
                                  current:
                                      context.localized.formattedTime(DateTime(0, 0, 0, endTime.hour, endTime.minute)),
                                  itemBuilder: (context) => timesOfDay
                                      .map(
                                        (e) => ItemActionButton(
                                          label: Text(
                                              context.localized.formattedTime(DateTime(0, 0, 0, e.hour, e.minute))),
                                          action: () {
                                            setState(() {
                                              endTime = e;
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          );
                        }),
                        actions: [
                          TextButton(
                            autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(context.localized.cancel),
                          ),
                          FilledButtonAwait(
                            onPressed: () {
                              final schedule = AccessSchedule(
                                dayOfWeek: selectedDay,
                                startHour: startTime.hour.toDouble(),
                                endHour: endTime.hour.toDouble(),
                              );
                              if (startTime.hour > endTime.hour ||
                                  (startTime.hour == endTime.hour && startTime.minute >= endTime.minute)) {
                                FladderSnack.show(context.localized.endTimeMustBeAfter, context: context);
                                return;
                              }
                              onAddSchedule?.call(schedule);
                              Navigator.of(context).pop();
                            },
                            child: Text(context.localized.create),
                          )
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
          if (schedules.isNotEmpty)
            ...schedules.map(
              (schedule) {
                final start = TimeOfDay(hour: schedule.startHour?.toInt() ?? 0, minute: 0);
                final end = TimeOfDay(hour: schedule.endHour?.toInt() ?? 0, minute: 0);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SettingsListChild(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((schedule.dayOfWeek?.label(context) ?? "").capitalize()),
                                Text(
                                  "${context.localized.formattedTime(DateTime(0, 0, 0, start.hour, start.minute))} - ${context.localized.formattedTime(DateTime(0, 0, 0, end.hour, end.minute))}",
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              onRemoveSchedule?.call(schedule);
                            },
                            style: IconButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.error,
                            ),
                            icon: const Icon(IconsaxPlusBold.trash),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          else
            Text(
              context.localized.empty,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(125)),
            )
        ],
      ),
    );
  }
}

class TagsEditor extends StatelessWidget {
  final String label;
  final List<String> tags;
  final Function(String newTag) onTagAdded;
  final Function(String tag)? onTagRemoved;
  const TagsEditor({
    required this.label,
    required this.tags,
    required this.onTagAdded,
    this.onTagRemoved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController tagController = TextEditingController();
                      return AlertDialog(
                        title: Text(context.localized.addTag),
                        content: SizedBox(
                          height: 75,
                          child: OutlinedTextField(
                            controller: tagController,
                            label: context.localized.tag(1),
                            onSubmitted: (value) {
                              onTagAdded(value);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(context.localized.cancel),
                          ),
                          FilledButtonAwait(
                            onPressed: () {
                              onTagAdded(tagController.text);
                              Navigator.of(context).pop();
                            },
                            child: Text(context.localized.create),
                          )
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(IconsaxPlusBold.add_circle),
              )
            ],
          ),
          if (tags.isNotEmpty)
            ...tags.map(
              (tag) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Chip(
                  label: Text(tag),
                  deleteIcon: const Icon(IconsaxPlusBold.close_circle),
                  onDeleted: onTagRemoved != null
                      ? () {
                          onTagRemoved?.call(tag);
                        }
                      : null,
                ),
              ),
            )
          else
            Text(
              context.localized.empty,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(125)),
            )
        ],
      ),
    );
  }
}
