import 'dart:async';
import 'dart:developer';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';

/// Service for synchronizing client clock with Jellyfin server using NTP-like algorithm
class TimeSyncService {
  TimeSyncService(this._api);

  final JellyfinOpenApi _api;

  final List<TimeSyncMeasurement> _measurements = [];
  static const int _maxMeasurements = 8;

  Timer? _pollingTimer;
  int _pingCount = 0;
  bool _isActive = false;

  // Polling intervals
  static const Duration _greedyInterval = Duration(seconds: 1);
  static const Duration _lowProfileInterval = Duration(seconds: 60);
  static const int _greedyPingCount = 3;

  // Staleness threshold
  static const Duration _staleThreshold = Duration(seconds: 30);
  DateTime? _lastMeasurementTime;

  /// Current best offset estimate
  Duration get offset {
    if (_measurements.isEmpty) return Duration.zero;
    // Use measurement with minimum delay (least network jitter)
    final best = _measurements.reduce(
      (a, b) => a.delay < b.delay ? a : b,
    );
    return best.offset;
  }

  /// Current ping estimate (from best measurement)
  Duration get ping {
    if (_measurements.isEmpty) return Duration.zero;
    final best = _measurements.reduce(
      (a, b) => a.delay < b.delay ? a : b,
    );
    return best.ping;
  }

  /// Whether time sync is stale and needs refresh
  bool get isStale {
    if (_lastMeasurementTime == null) return true;
    return DateTime.now().difference(_lastMeasurementTime!) > _staleThreshold;
  }

  /// Convert server time to local time
  DateTime remoteDateToLocal(DateTime serverTime) {
    return serverTime.subtract(offset);
  }

  /// Convert local time to server time
  DateTime localDateToRemote(DateTime localTime) {
    return localTime.add(offset);
  }

  /// Start time synchronization
  void start() {
    if (_isActive) return;
    _isActive = true;
    _pingCount = 0;
    _poll();
  }

  /// Stop time synchronization
  void stop() {
    _isActive = false;
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Force an immediate sync update
  Future<void> forceUpdate() async {
    await _requestPing();
  }

  /// Force update and wait for completion
  Future<void> forceUpdateAndWait() async {
    await _requestPing();
  }

  void _poll() {
    if (!_isActive) return;

    _requestPing().then((_) {
      if (!_isActive) return;

      _pingCount++;
      final interval = _pingCount <= _greedyPingCount 
          ? _greedyInterval 
          : _lowProfileInterval;

      _pollingTimer?.cancel();
      _pollingTimer = Timer(interval, _poll);
    });
  }

  Future<void> _requestPing() async {
    try {
      // T1: Record local time before request
      final requestSent = DateTime.now().toUtc();

      // Make request to Jellyfin TimeSync API
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
    } catch (e) {
      log('Time sync failed: $e');
    }
  }

  void _addMeasurement(TimeSyncMeasurement measurement) {
    _measurements.add(measurement);
    // Keep only the last N measurements
    while (_measurements.length > _maxMeasurements) {
      _measurements.removeAt(0);
    }
  }

  /// Clear all measurements
  void clear() {
    _measurements.clear();
    _lastMeasurementTime = null;
    _pingCount = 0;
  }

  /// Dispose resources
  void dispose() {
    stop();
    clear();
  }
}
