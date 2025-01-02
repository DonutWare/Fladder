import 'package:collection/collection.dart';

extension DurationExtensions on Duration? {
  String? get humanize {
    if (this == null) return null;
    final duration = this!;
    final hours = duration.inHours != 0 ? '${duration.inHours.toString()}h' : null;
    final minutes = duration.inMinutes % 60 != 0 ? '${duration.inMinutes % 60}m'.padLeft(3, '0') : null;
    final seconds = duration.inSeconds % 60 != 0 ? '${duration.inSeconds % 60}s'.padLeft(3, '0') : null;
    final result = [hours, minutes, seconds].whereNotNull().map((e) => e).join(' ');
    return result.isNotEmpty ? result : null;
  }

  String? get humanizeSmall {
    if (this == null) return null;
    final duration = this!;
    final hours = (duration.inHours != 0 ? duration.inHours : null)?.toString();
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inHours == 0 ? duration.inSeconds % 60 : null)?.toString().padLeft(2, '0');

    final result = [hours, minutes, seconds].whereNotNull().map((e) => e).join(':');
    return result.isNotEmpty ? result : null;
  }

  String get simpleTime {
    return toString().split('.').first.padLeft(8, "0");
  }
}
