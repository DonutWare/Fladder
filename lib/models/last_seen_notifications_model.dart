import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_seen_notifications_model.freezed.dart';
part 'last_seen_notifications_model.g.dart';

@Freezed(copyWith: true)
abstract class LastSeenNotificationsModel with _$LastSeenNotificationsModel {
  const LastSeenNotificationsModel._();

  const factory LastSeenNotificationsModel({
    @Default([]) List<LastSeenModel> lastSeen,
    DateTime? updatedAt,
  }) = _LastSeenNotificationsModel;

  factory LastSeenNotificationsModel.fromJson(Map<String, dynamic> json) => _$LastSeenNotificationsModelFromJson(json);
}

@Freezed(copyWith: true)
abstract class LastSeenModel with _$LastSeenModel {
  const LastSeenModel._();

  const factory LastSeenModel({
    required String userId,
    @Default(<String>[]) List<String> lastSeenIds,
  }) = _LastSeenModel;

  factory LastSeenModel.fromJson(Map<String, dynamic> json) => _$LastSeenModelFromJson(json);
}
