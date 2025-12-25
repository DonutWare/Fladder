import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/screens/control_panel/control_user_edit/control_user_edit_shared.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class UserParentalControlTab extends ConsumerWidget {
  final AccountModel? currentUser;
  final UserPolicy? currentPolicy;
  final Map<ParentalRatingScore?, List<ParentalRating>> parentalRatings;

  const UserParentalControlTab({
    required this.currentUser,
    required this.currentPolicy,
    required this.parentalRatings,
    super.key,
  });

  Set<UnratedItem> get unratedItems => {
        UnratedItem.book,
        UnratedItem.channelcontent,
        UnratedItem.livetvprogram,
        UnratedItem.movie,
        UnratedItem.music,
        UnratedItem.trailer,
        UnratedItem.series,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(controlUsersProvider.notifier);

    final currentRating = parentalRatings.entries.firstWhereOrNull(
          (element) {
            if (currentPolicy?.maxParentalRating == -1 && currentPolicy?.maxParentalSubRating == -1) {
              return false;
            }
            if (currentPolicy?.maxParentalSubRating == -1) {
              return element.key?.score == currentPolicy?.maxParentalRating;
            }
            return element.key?.score == currentPolicy?.maxParentalRating &&
                element.key?.subScore == currentPolicy?.maxParentalSubRating;
          },
        ) ??
        parentalRatings.entries.firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.parentalControl),
          [
            SettingsListTile(
              label: Text(context.localized.maxParentalRating),
              trailing: EnumBox(
                current: currentRating?.value.map((e) => e.name).join('/') ?? "",
                itemBuilder: (BuildContext context) => parentalRatings.entries
                    .map(
                      (rating) => ItemActionButton(
                        label: Text(rating.value.map((e) => e.name).join('/')),
                        action: () {
                          provider.updateSelectedUserPolicy(
                            currentPolicy?.copyWith(
                              maxParentalRating: rating.key?.score ?? -1,
                              maxParentalSubRating: rating.key?.subScore ?? -1,
                            ),
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
          SettingsLabelDivider(label: context.localized.blockedItemsNoRating),
          [
            ...unratedItems.map(
              (rating) => SettingsListTileCheckbox(
                label: Text(rating.name.capitalize()),
                onChanged: (value) {
                  final updatedRatings = currentPolicy?.blockUnratedItems != null
                      ? List<UnratedItem>.from(currentPolicy!.blockUnratedItems!)
                      : <UnratedItem>[];
                  if (value == true) {
                    updatedRatings.add(rating);
                  } else {
                    updatedRatings.removeWhere((id) => rating.value == id.value);
                  }
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      blockUnratedItems: updatedRatings,
                    ),
                  );
                },
                value: currentPolicy?.blockUnratedItems?.contains(rating) ?? false,
              ),
            ),
            SettingsListChild(
              child: TagsEditor(
                label: context.localized.allowItemsTags,
                tags: currentPolicy?.allowedTags ?? [],
                onTagRemoved: (tag) {
                  final updatedTags =
                      currentPolicy?.allowedTags != null ? List<String>.from(currentPolicy!.allowedTags!) : <String>[];
                  updatedTags.remove(tag);
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      allowedTags: updatedTags,
                    ),
                  );
                },
                onTagAdded: (newTag) {
                  final updatedTags =
                      currentPolicy?.allowedTags != null ? List<String>.from(currentPolicy!.allowedTags!) : <String>[];
                  updatedTags.add(newTag);
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      allowedTags: updatedTags,
                    ),
                  );
                },
              ),
            ),
            SettingsListChild(
              child: TagsEditor(
                label: context.localized.blockItemsTags,
                tags: currentPolicy?.blockedTags ?? [],
                onTagRemoved: (tag) {
                  final updatedTags =
                      currentPolicy?.blockedTags != null ? List<String>.from(currentPolicy!.blockedTags!) : <String>[];
                  updatedTags.remove(tag);
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      blockedTags: updatedTags,
                    ),
                  );
                },
                onTagAdded: (newTag) {
                  final updatedTags =
                      currentPolicy?.blockedTags != null ? List<String>.from(currentPolicy!.blockedTags!) : <String>[];
                  updatedTags.add(newTag);
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      blockedTags: updatedTags,
                    ),
                  );
                },
              ),
            ),
            SettingsListChild(
              child: AccessSchedulesEditor(
                label: context.localized.accessSchedules,
                schedules: currentPolicy?.accessSchedules ?? [],
                onAddSchedule: (schedule) {
                  final updatedSchedules = currentPolicy?.accessSchedules != null
                      ? List<AccessSchedule>.from(currentPolicy!.accessSchedules!)
                      : <AccessSchedule>[];
                  updatedSchedules.add(schedule.copyWith(
                    userId: currentUser?.id,
                  ));
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      accessSchedules: updatedSchedules,
                    ),
                  );
                },
                onRemoveSchedule: (schedule) {
                  final updatedSchedules = currentPolicy?.accessSchedules != null
                      ? List<AccessSchedule>.from(currentPolicy!.accessSchedules!)
                      : <AccessSchedule>[];
                  updatedSchedules.removeWhere((id) => id == schedule);
                  provider.updateSelectedUserPolicy(
                    currentPolicy?.copyWith(
                      accessSchedules: updatedSchedules,
                    ),
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
