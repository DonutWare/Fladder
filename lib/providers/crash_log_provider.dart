import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

enum ErrorType {
  severe,
  warning,
  shout,
}

class ErrorViewModel {
  final LogRecord rec;

  const ErrorViewModel({required this.rec});

  ErrorType get type {
    if (rec.level == Level.WARNING) {
      return ErrorType.warning;
    }
    if (rec.level == Level.SHOUT) {
      return ErrorType.shout;
    }
    return ErrorType.severe;
  }

  String get label {
    var join = [
      type.name.toUpperCase(),
      "  |  ",
      rec.message,
    ].join();
    if (join.length > 250) {
      return "${join.substring(0, 80)}... \n \nTruncated copy log to see more";
    } else {
      return join;
    }
  }

  String get content => [
        rec.time.toIso8601String(),
        "\n",
        "\n",
        rec.stackTrace,
      ].whereNotNull().join();

  String get clipBoard => [label, content].toString();

  Color get color => switch (type) {
        ErrorType.severe => Colors.redAccent,
        ErrorType.warning => Colors.orange,
        ErrorType.shout => Colors.yellowAccent,
      };
}

final crashLogProvider = StateNotifierProvider<CrashLogNotifier, List<ErrorViewModel>>((ref) => CrashLogNotifier());

class CrashLogNotifier extends StateNotifier<List<ErrorViewModel>> {
  CrashLogNotifier() : super([]) {
    init();
  }

  late final Logger logger;
  final maxLength = 100;

  void init() {
    logger = Logger.root;
    logger.level = Level.ALL;
    logger.onRecord.listen(logPrint);
    FlutterError.onError = (FlutterErrorDetails details) => logFile(details);
    PlatformDispatcher.instance.onError = (error, stack) {
      logFile(FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'Unhandled',
      ));
      return false;
    };
  }

  void clearLogs() {
    state = [];
  }

  void logPrint(LogRecord rec) {
    if (kDebugMode) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
    if (rec.level > Level.INFO) {
      state = [ErrorViewModel(rec: rec), ...state];
      if (state.length >= maxLength) {
        state = state.sublist(0, maxLength);
      }
    }
  }

  void logFile(FlutterErrorDetails details) {
    logger.severe('Flutter error: ${details.exception}', details.exception, details.stack);

    if (details.stack != null && kDebugMode) {
      print('${details.stack}');
    }
  }
}
