import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

enum ErrorType {
  severe,
  warning,
  shout,
}

class ErrorLogModel {
  final ErrorType type;
  final String message;
  final DateTime time;
  final StackTrace? stackTrace;

  const ErrorLogModel({
    required this.type,
    required this.message,
    required this.time,
    required this.stackTrace,
  });

  factory ErrorLogModel.fromLogRecord(LogRecord record) {
    late ErrorType type;
    if (record.level == Level.WARNING) {
      type = ErrorType.warning;
    } else if (record.level == Level.SHOUT) {
      type = ErrorType.shout;
    } else {
      type = ErrorType.severe;
    }

    return ErrorLogModel(
      type: type,
      message: record.message,
      time: record.time,
      stackTrace: record.stackTrace,
    );
  }

  String get label {
    var join = _label;
    if (join.length > 250) {
      return "${join.substring(0, 250)}... \n \nTruncated copy log to see more";
    } else {
      return join;
    }
  }

  String get _label {
    return [
      type.name.toUpperCase(),
      "  |  ",
      message,
    ].join();
  }

  String get content => [
        time.toIso8601String(),
        "\n",
        "\n",
        stackTrace,
      ].nonNulls.join();

  String get clipBoard => [_label, content].toString();

  Color get color => switch (type) {
        ErrorType.severe => Colors.redAccent,
        ErrorType.warning => Colors.orange,
        ErrorType.shout => Colors.yellowAccent,
      };

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'level': type.name,
        'message': message,
        'stackTrace': stackTrace?.toString(),
      };

  static ErrorLogModel fromJson(Map<String, dynamic> json) {
    return ErrorLogModel(
      type: ErrorType.values.firstWhereOrNull((level) => level.name == json['level']) ?? ErrorType.warning,
      message: json['message'],
      stackTrace: json['stackTrace'] != null ? StackTrace.fromString(json['stackTrace']) : null,
      time: DateTime.parse(json['time']),
    );
  }
}
