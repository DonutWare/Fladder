import 'package:freezed_annotation/freezed_annotation.dart';

part 'arguments_model.freezed.dart';

@freezed
class ArgumentsModel with _$ArgumentsModel {
  const ArgumentsModel._();

  factory ArgumentsModel({
    @Default(false) bool htpcMode,
  }) = _ArgumentsModel;

  factory ArgumentsModel.fromArguments(List<String> arguments) {
    arguments = arguments.map((e) => e.trim()).toList();
    return ArgumentsModel(
      htpcMode: arguments.contains('--htpc'),
    );
  }
}
