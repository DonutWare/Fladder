import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fladder/models/error_log_model.dart';

final crashLogProvider = StateNotifierProvider<CrashLogNotifier, List<ErrorLogModel>>((ref) => CrashLogNotifier());

class CrashLogNotifier extends StateNotifier<List<ErrorLogModel>> {
  CrashLogNotifier() : super([]) {
    init();
  }

  late final Logger logger;
  final maxLength = 100;
  String? logFilePath;

  Future<void> init() async {
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

    if (!kIsWeb) {
      await _initializeLogFile();
      await _loadLogsFromFile();
    }
  }

  Future<void> _initializeLogFile() async {
    final directory = await getApplicationCacheDirectory();
    logFilePath = '${directory.path}/crash_logs.json';
  }

  Future<void> _loadLogsFromFile() async {
    if (logFilePath == null) return;
    final file = File(logFilePath!);
    if (await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(content);
      state = jsonData.map((json) => ErrorLogModel.fromJson(json)).toList();
    }
  }

  Future<void> _saveLogsToFile() async {
    if (logFilePath == null) return;
    final file = File(logFilePath!);
    final jsonData = state.map((log) => log.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonData));
  }

  void clearLogs() {
    state = [];
    if (!kIsWeb) {
      _saveLogsToFile();
    }
  }

  void logPrint(LogRecord rec) {
    if (kDebugMode) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
    if (rec.level > Level.INFO) {
      state = [ErrorLogModel.fromLogRecord(rec), ...state];
      if (state.length >= maxLength) {
        state = state.sublist(0, maxLength);
      }
      if (!kIsWeb) {
        _saveLogsToFile();
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
