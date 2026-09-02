import 'dart:async';
import 'dart:developer';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';

/// Minimal clock contract so handler tests can substitute a fake clock without a Chopper client.
abstract class SyncPlayClock {
  /// True once at least one measurement has been taken; commands must not be scheduled before this.
  bool get isReady;

  /// One-way ping estimate from the best measurement.
  Duration get ping;

  DateTime remoteDateToLocal(DateTime serverTime);

  DateTime localDateToRemote(DateTime localTime);
}

/// NTP-style clock sync against the server's `/GetUtcTime`.
class TimeSyncService implements SyncPlayClock {
  TimeSyncService(this._api);

  final JellyfinOpenApi _api;

  /// Invoked after every successful measurement with the current best offset and ping.
  void Function(Duration offset, Duration ping)? onMeasurement;

  @override
  bool get isReady => _measurements.isNotEmpty;

  final List<TimeSyncMeasurement> _measurements = [];
  static const int _maxMeasurements = 8;

  Timer? _pollingTimer;
  int _pingCount = 0;
  bool _isActive = false;

  static const Duration _greedyInterval = Duration(seconds: 1);
  static const Duration _lowProfileInterval = Duration(seconds: 60);
  static const int _greedyPingCount = 3;

  static const Duration _staleThreshold = Duration(seconds: 30);
  DateTime? _lastMeasurementTime;

  Duration get offset {
    if (_measurements.isEmpty) {
      return Duration.zero;
    }
    // Use measurement with minimum delay (least network jitter)
    final best = _measurements.reduce(
      (a, b) => a.delay < b.delay ? a : b,
    );
    return best.offset;
  }

  @override
  Duration get ping {
    if (_measurements.isEmpty) {
      return Duration.zero;
    }
    final best = _measurements.reduce(
      (a, b) => a.delay < b.delay ? a : b,
    );
    return best.ping;
  }

  bool get isStale {
    if (_lastMeasurementTime == null) {
      return true;
    }
    return DateTime.now().difference(_lastMeasurementTime!) > _staleThreshold;
  }

  @override
  DateTime remoteDateToLocal(DateTime serverTime) {
    return serverTime.subtract(offset);
  }

  @override
  DateTime localDateToRemote(DateTime localTime) {
    return localTime.add(offset);
  }

  void start() {
    if (_isActive) {
      return;
    }
    _isActive = true;
    _pingCount = 0;
    _poll();
  }

  void stop() {
    _isActive = false;
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> forceUpdate() async {
    await _requestPing();
  }

  Future<void> forceUpdateAndWait() async {
    await _requestPing();
  }

  void _poll() {
    if (!_isActive) {
      return;
    }

    _requestPing().then((_) {
      if (!_isActive) {
        return;
      }

      _pingCount++;
      final interval = _pingCount <= _greedyPingCount ? _greedyInterval : _lowProfileInterval;

      _pollingTimer?.cancel();
      _pollingTimer = Timer(interval, _poll);
    });
  }

  Future<void> _requestPing() async {
    try {
      // T1: Record local time before request
      final requestSent = DateTime.now().toUtc();

      final response = await _api.getUtcTimeGet();

      // T4: Record local time after response
      final responseReceived = DateTime.now().toUtc();

      final data = response.body;
      if (data == null) {
        log('Time sync: No response body');
        return;
      }

      // T2 and T3 from server
      final requestReceived = data.requestReceptionTime;
      final responseSent = data.responseTransmissionTime;

      if (requestReceived == null || responseSent == null) {
        log('Time sync: Missing server timestamps');
        return;
      }

      final measurement = TimeSyncMeasurement(
        requestSent: requestSent,
        requestReceived: requestReceived,
        responseSent: responseSent,
        responseReceived: responseReceived,
      );

      _addMeasurement(measurement);
      _lastMeasurementTime = DateTime.now();

      log('Time sync: offset=${offset.inMilliseconds}ms, ping=${ping.inMilliseconds}ms');
      onMeasurement?.call(offset, ping);
    } catch (e) {
      log('Time sync failed: $e');
    }
  }

  void _addMeasurement(TimeSyncMeasurement measurement) {
    _measurements.add(measurement);
    while (_measurements.length > _maxMeasurements) {
      _measurements.removeAt(0);
    }
  }

  void clear() {
    _measurements.clear();
    _lastMeasurementTime = null;
    _pingCount = 0;
  }

  void dispose() {
    stop();
    clear();
  }
}
