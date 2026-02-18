import 'dart:developer';
import 'dart:io';

import 'package:fladder/src/battery_optimization_pigeon.g.dart' as pigeon;

class BatteryOptimization {
  static final _api = pigeon.BatteryOptimizationPigeon();

  static Future<bool> isIgnoringBatteryOptimizations() async {
    if (!Platform.isAndroid) return true;
    try {
      return await _api.isIgnoringBatteryOptimizations();
    } catch (e, st) {
      log('isIgnoringBatteryOptimizations failed: $e', error: e, stackTrace: st);
      return false;
    }
  }

  static Future<void> openBatteryOptimizationSettings() async {
    if (!Platform.isAndroid) return;
    try {
      await _api.openBatteryOptimizationSettings();
    } catch (e, st) {
      log('openBatteryOptimizationSettings failed: $e', error: e, stackTrace: st);
      return;
    }
  }
}
