/// Runs an asynchronous initializer once and shares the in-flight operation.
///
/// A failed attempt is not cached, so a later call can retry safely.
class SingleFlightInitializer<T> {
  Future<T>? _active;
  T? _value;
  bool _hasValue = false;

  bool get isRunning => _active != null;
  bool get hasValue => _hasValue;

  Future<T> run(Future<T> Function() initialize) {
    if (_hasValue) return Future.value(_value as T);

    final active = _active;
    if (active != null) return active;

    late final Future<T> operation;
    operation = Future<T>.sync(initialize).then((value) {
      _value = value;
      _hasValue = true;
      return value;
    }).whenComplete(() {
      if (identical(_active, operation)) {
        _active = null;
      }
    });
    _active = operation;
    return operation;
  }
}
