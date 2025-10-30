import 'package:freezed_annotation/freezed_annotation.dart';

part 'arguments_model.freezed.dart';

/// Prefer using the arguments provider over this boolean
bool leanBackMode = false;

@freezed
abstract class ArgumentsModel with _$ArgumentsModel {
  const ArgumentsModel._();

  factory ArgumentsModel({
    @Default(false) bool htpcMode,
    @Default(false) bool leanBackMode,
  }) = _ArgumentsModel;

  factory ArgumentsModel.fromArguments(List<String> arguments, bool leanBackEnabled) {
    arguments = arguments.map((e) => e.trim()).toList();
    leanBackMode = leanBackEnabled;
    return ArgumentsModel(
      htpcMode: arguments.contains('--htpc') || leanBackEnabled,
      leanBackMode: leanBackEnabled,
    );
  }
}
