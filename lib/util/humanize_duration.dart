import 'package:flutter/material.dart';

import 'package:fladder/util/localization_helper.dart';

extension DurationExtensions on Duration? {
  String? get humanize {
    if (this == null) return null;
    final duration = this!;
    final hours = duration.inHours != 0 ? '${duration.inHours.toString()}h' : null;
    final minutes = duration.inMinutes % 60 != 0 ? '${duration.inMinutes % 60}m'.padLeft(3, '0') : null;
    final seconds = duration.inSeconds % 60 != 0 ? '${duration.inSeconds % 60}s'.padLeft(3, '0') : null;
    final result = [hours, minutes, seconds].nonNulls.map((e) => e).join(' ');
    return result.isNotEmpty ? result : null;
  }

  String? get humanizeSmall {
    if (this == null) return null;
    final duration = this!;
    final hours = (duration.inHours != 0 ? duration.inHours : null)?.toString();
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inHours == 0 ? duration.inSeconds % 60 : null)?.toString().padLeft(2, '0');

    final result = [hours, minutes, seconds].nonNulls.map((e) => e).join(':');
    return result.isNotEmpty ? result : null;
  }

  String get simpleTime {
    return toString().split('.').first.padLeft(8, "0");
  }

  String toLogicalDuration(BuildContext context) {
    if (this == null) return '';
    final duration = this!;
    final parts = <String>[];
    if (duration.inHours > 0) {
      final h = duration.inHours;
      parts.add('$h ${context.localized.hours(h)}');
    }
    if (duration.inMinutes.remainder(60) > 0) {
      final m = duration.inMinutes.remainder(60);
      parts.add('$m ${context.localized.minutes(m)}');
    }
    if (duration.inSeconds.remainder(60) > 0) {
      final s = duration.inSeconds.remainder(60);
      parts.add('$s ${context.localized.seconds(s)}');
    }
    return parts.join(' ');
  }
}

extension DateTimeExtension on DateTime? {
  String? timeAgo(BuildContext context, {DateTime? reference}) {
    if (this == null) return null;
    final now = reference ?? DateTime.now();
    final difference = now.difference(this!);
    if (difference.inSeconds < 60) {
      final s = difference.inSeconds;
      return context.localized.timeAgo('$s ${context.localized.seconds(s).toLowerCase()}');
    }
    if (difference.inMinutes < 60) {
      final m = difference.inMinutes;
      return context.localized.timeAgo('$m ${context.localized.minutes(m).toLowerCase()}');
    }
    if (difference.inHours < 24) {
      final h = difference.inHours;
      return context.localized.timeAgo('$h ${context.localized.hours(h).toLowerCase()}');
    }
    if (difference.inDays < 7) {
      final d = difference.inDays;
      return context.localized.timeAgo('$d ${context.localized.days(d).toLowerCase()}');
    }
    if (difference.inDays < 30) {
      final w = (difference.inDays / 7).floor();
      return context.localized.timeAgo('$w ${context.localized.weeks(w).toLowerCase()}');
    }
    if (difference.inDays < 365) {
      final mo = (difference.inDays / 30).floor();
      return context.localized.timeAgo('$mo ${context.localized.months(mo).toLowerCase()}');
    }
    final y = (difference.inDays / 365).floor();
    return context.localized.timeAgo('$y ${context.localized.years(y).toLowerCase()}');
  }
}
