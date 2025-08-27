extension MapExtensions<T> on Map<T, bool> {
  Map<T, bool> toggleKey(T wantedKey) {
    return map((key, value) => MapEntry(key, wantedKey == key ? !value : value));
  }

  Map<T, bool> setKey(T? wantedKey, bool enable) {
    return map((key, value) => MapEntry(key, wantedKey == key ? enable : value));
  }

  Map<T, bool> setKeys(Iterable<T?> wantedKey, bool enable) {
    var tempMap = map((key, value) => MapEntry(key, value));
    for (var element in wantedKey) {
      tempMap = tempMap.setKey(element, enable);
    }
    return tempMap;
  }

  Map<T, bool> setAll(bool toggle) {
    return map((key, value) => MapEntry(key, toggle));
  }

  List<T> get included {
    return entries.where((entry) => entry.value).map((entry) => entry.key).toList();
  }

  List<T> get notIncluded {
    return entries.where((entry) => !entry.value).map((entry) => entry.key).toList();
  }

  Map<T, bool> get enabledFirst {
    final enabled = Map<T, bool>.from(this)..removeWhere((key, value) => !value);
    final disabled = Map<T, bool>.from(this)..removeWhere((key, value) => value);

    return enabled..addAll(disabled);
  }

  bool get hasEnabled => values.any((element) => element == true);

  //Replaces only keys that exist with the new values
  Map<T, bool> replaceMap(Map<T, bool> oldMap, {bool enabledOnly = false}) {
    Map<T, bool> result = {};

    forEach((key, value) {
      if (enabledOnly) {
        if (oldMap[key] == true) {
          result[key] = true;
        } else {
          result[key] = value;
        }
      } else {
        result[key] = oldMap[key] ?? false;
      }
    });

    return result;
  }

  Map<T, bool> sortByKey(String Function(T value) keySelector) {
    final sortedEntries = entries.toList()..sort((a, b) => keySelector(a.key).compareTo(keySelector(b.key)));
    return Map<T, bool>.fromEntries(sortedEntries);
  }
}

extension MapExtensionsGeneric<K, V> on Map<K, V> {
  Map<K, V> setKey(K? wantedKey, V newValue) {
    return map((key, value) => MapEntry(key, key == wantedKey ? newValue : value));
  }

  Map<K, V> setKeys(Iterable<K?> wantedKey, V value) {
    var tempMap = map((key, value) => MapEntry(key, value));
    for (var element in wantedKey) {
      tempMap = tempMap.setKey(element, value);
    }
    return tempMap;
  }
}
