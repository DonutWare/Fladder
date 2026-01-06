import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_tizen/flutter_tizen.dart';

part 'arguments_model.freezed.dart';

/// Prefer using the arguments provider over this boolean
bool leanBackMode = false;

@freezed
abstract class ArgumentsModel with _$ArgumentsModel {
  const ArgumentsModel._();

  factory ArgumentsModel({
    @Default(false) bool htpcMode,
    @Default(false) bool leanBackMode,
    @Default(false) bool newWindow,
  }) = _ArgumentsModel;

  factory ArgumentsModel.fromArguments(List<String> arguments, String windowArguments, bool leanBackEnabled) {
    arguments = arguments.map((e) => e.trim()).toList();
    leanBackMode = leanBackEnabled || isTizen;
    final parsedWindowArgs = windowArguments.split(',');
    return ArgumentsModel(
      htpcMode: arguments.contains('--htpc') || leanBackEnabled || isTizen,
      leanBackMode: leanBackEnabled || isTizen,
      newWindow: parsedWindowArgs.contains('--newWindow'),
    );
  }
}
