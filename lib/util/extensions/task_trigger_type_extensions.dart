import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/util/localization_helper.dart';

extension TaskTriggerTypeExtensions on TaskTriggerInfoType {
  bool get isUnknown => this == TaskTriggerInfoType.swaggerGeneratedUnknown;

  String label(BuildContext context) {
    if (isUnknown) return context.localized.unknown;
    switch (this) {
      case TaskTriggerInfoType.intervaltrigger:
        return context.localized.taskTriggerTypeInterval;
      case TaskTriggerInfoType.dailytrigger:
        return context.localized.taskTriggerTypeDaily;
      case TaskTriggerInfoType.weeklytrigger:
        return context.localized.taskTriggerTypeWeekly;
      case TaskTriggerInfoType.startuptrigger:
        return context.localized.taskTriggerTypeStartup;
      default:
        return context.localized.unknown;
    }
  }
}
