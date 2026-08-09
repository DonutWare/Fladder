class SingleFlightInitializer<T> {
  Future<T>? _activeInitialization;
  T? _value;
  bool _hasValue = false;

  bool get isRunning => _activeInitialization != null;
  bool get hasValue => _hasValue;

  Future<T> run(Future<T> Function() initialize) {
    if (_hasValue) return Future<T>.value(_value as T);

    final activeInitialization = _activeInitialization;
    if (activeInitialization != null) return activeInitialization;

    late final Future<T> operation;
    operation = Future<T>.sync(initialize).then((value) {
      _value = value;
      _hasValue = true;
      return value;
    }).whenComplete(() {
      if (identical(_activeInitialization, operation)) {
        _activeInitialization = null;
      }
    });
    _activeInitialization = operation;
    return operation;
  }
}
