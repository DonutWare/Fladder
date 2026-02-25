import 'package:freezed_annotation/freezed_annotation.dart';

part 'arguments_model.freezed.dart';

/// Prefer using the arguments provider over this boolean
bool leanBackMode = false;

class NotificationKeys {
  static const String skipNotifications = '--skipNotifications';
  static const String newWindow = '--newWindow';
  static const String htpcMode = '--htpc';
}

@freezed
abstract class ArgumentsModel with _$ArgumentsModel {
  const ArgumentsModel._();

  factory ArgumentsModel({
    @Default(false) bool htpcMode,
    @Default(false) bool leanBackMode,
    @Default(false) bool newWindow,
    @Default(false) bool skipNotifications,
  }) = _ArgumentsModel;

  factory ArgumentsModel.fromArguments(List<String> arguments, String windowArguments, bool leanBackEnabled) {
    arguments = arguments.map((e) => e.trim()).toList();
    leanBackMode = leanBackEnabled;
    final parsedWindowArgs = windowArguments.split(',');
    final shouldSkipNotifications = arguments.contains(NotificationKeys.skipNotifications) ||
        parsedWindowArgs.contains(NotificationKeys.skipNotifications) ||
        parsedWindowArgs.contains(NotificationKeys.newWindow);
    return ArgumentsModel(
      htpcMode: arguments.contains(NotificationKeys.htpcMode) || leanBackEnabled,
      leanBackMode: leanBackEnabled,
      newWindow: parsedWindowArgs.contains(NotificationKeys.newWindow),
      skipNotifications: shouldSkipNotifications,
    );
  }
}
