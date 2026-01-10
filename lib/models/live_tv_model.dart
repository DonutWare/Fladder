import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_tv_model.freezed.dart';
part 'live_tv_model.g.dart';

@freezed
abstract class LiveTvModel with _$LiveTvModel {
  factory LiveTvModel({
    DateTime? startDate,
    DateTime? endDate,
  }) = _LiveTvModel;

  factory LiveTvModel.fromJson(Map<String, dynamic> json) => _$LiveTvModelFromJson(json);
}
