import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/util/localization_helper.dart';

extension DayOfWeekLocalization on DayOfWeek {
  bool get isUnknown => this == DayOfWeek.swaggerGeneratedUnknown;

  int get isoWeekday => switch (this) {
        DayOfWeek.monday => 1,
        DayOfWeek.tuesday => 2,
        DayOfWeek.wednesday => 3,
        DayOfWeek.thursday => 4,
        DayOfWeek.friday => 5,
        DayOfWeek.saturday => 6,
        DayOfWeek.sunday => 7,
        _ => 1,
      };

  String label(BuildContext context) {
    if (isUnknown) return context.localized.unknown;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final date = DateTime.utc(2023, 1, 2 + (isoWeekday - 1));
    return DateFormat('EEEE', localeTag).format(date);
  }
}

extension DynamicDayOfWeekLocalization on DynamicDayOfWeek {
  bool get isUnknown => this == DynamicDayOfWeek.swaggerGeneratedUnknown;

  int get isoWeekday => switch (this) {
        DynamicDayOfWeek.monday => 1,
        DynamicDayOfWeek.tuesday => 2,
        DynamicDayOfWeek.wednesday => 3,
        DynamicDayOfWeek.thursday => 4,
        DynamicDayOfWeek.friday => 5,
        DynamicDayOfWeek.saturday => 6,
        DynamicDayOfWeek.sunday => 7,
        _ => 1,
      };

  String label(BuildContext context) {
    if (isUnknown) return context.localized.unknown;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final date = DateTime.utc(2023, 1, 2 + (isoWeekday - 1));
    return DateFormat('EEEE', localeTag).format(date);
  }
}
