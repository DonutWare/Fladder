import 'package:collection/collection.dart';

extension ListExtensions<T> on List<T> {
  List<T> replace(T entry) {
    var tempList = toList();
    final index = indexOf(entry);
    tempList.removeAt(index);
    tempList.insert(index, entry);
    return tempList;
  }

  List<T> toggle(T entry) {
    var tempList = toList();
    if (contains(entry)) {
      return tempList..remove(entry);
    } else {
      return tempList..add(entry);
    }
  }

  bool containsAny(Iterable<T> entries) {
    for (var value in entries) {
      if (contains(value)) {
        return true;
      }
    }
    return false;
  }

  List<T> toggleUnique(T entry) => toggle(entry).toSet().toList();

  List<T> random() {
    List<T> tempList = this;
    tempList.shuffle();
    return tempList;
  }

  List<T> uniqueBy(dynamic Function(T value) keySelector) {
    final Map<dynamic, T> uniqueMap = {};

    for (var item in this) {
      final key = keySelector(item);
      if (!uniqueMap.containsKey(key)) {
        uniqueMap[key] = item;
      }
    }

    return uniqueMap.values.toList();
  }

  List<R> mapWithLast<R>(R Function(T value, bool last) mapper) {
    return mapIndexed((index, e) => mapper(e, index == length - 1)).toList();
  }

  Iterable<List<T>> chunk(int size) sync* {
    if (size <= 0) {
      throw ArgumentError('Chunk size must be greater than zero.');
    }

    final iterator = this.iterator;
    while (iterator.moveNext()) {
      final chunk = <T>[];
      for (var i = 0; i < size; i++) {
        if (!iterator.moveNext()) {
          break;
        }
        chunk.add(iterator.current);
      }
      yield chunk;
    }
  }

  T? nextOrNull(T item) {
    int indexOf = this.indexOf(item);
    if (indexOf + 1 >= length) return null;
    return elementAtOrNull(indexOf + 1);
  }

  T? previousOrNull(T item) {
    int indexOf = this.indexOf(item);
    if (indexOf - 1 < 0) return null;
    return elementAtOrNull(indexOf - 1);
  }

  T? nextWhereOrNull(bool Function(T element) test) {
    final indexOf = indexWhere((element) => test(element));
    if (indexOf + 1 < length) return null;
    return elementAtOrNull(indexOf + 1);
  }

  T? previousWhereOrNull(bool Function(T element) test) {
    final indexOf = indexWhere((element) => test(element));
    if (indexOf - 1 < length) return null;
    return elementAtOrNull(indexOf - 1);
  }
}
