import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;

extension DurationExtensions on Duration {
  int get toRuntimeTicks => inMilliseconds * 10000;

  String get readAbleDuration {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${inHours != 0 ? '${twoDigits(inHours)}:' : ''}${twoDigits(inMinutes.remainder(60))}:${twoDigits(inSeconds.remainder(60))}";
  }
}

extension IntExtension on int {
  Duration get fromRuntimeTicks {
    return Duration(milliseconds: this ~/ 10000);
  }
}

extension BaseItemDtoExtension on dto.BaseItemDto {
  Duration? get runTimeDuration {
    if (runTimeTicks == null) return null;
    return Duration(milliseconds: (runTimeTicks! ~/ 10000));
  }
}
