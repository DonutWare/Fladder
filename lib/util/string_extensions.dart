import 'package:fladder/models/items/item_shared_models.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String rtrim([String? chars]) {
    var pattern = chars != null ? RegExp('[$chars]+\$') : RegExp(r'\s+$');
    return replaceAll(pattern, '');
  }

  String maxLength({int limitTo = 75}) {
    if (isEmpty) return this;
    if (length > limitTo) {
      return "${substring(0, limitTo.clamp(0, length))}...";
    } else {
      return substring(0, limitTo.clamp(0, length));
    }
  }

  String getInitials({int limitTo = 2}) {
    if (isEmpty) return "";
    var buffer = StringBuffer();
    var split = this.split(' ');
    for (var i = 0; i < (limitTo.clamp(0, split.length)); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  String toUpperCaseSplit() {
    String result = '';

    for (int i = 0; i < length; i++) {
      if (i == 0) {
        result += this[i].toUpperCase();
      } else if ((i > 0 && this[i].toUpperCase() == this[i])) {
        result += ' ${this[i].toUpperCase()}';
      } else {
        result += this[i];
      }
    }

    return result;
  }
}

extension ListExtensions on List<String> {
  String flatString({int count = 3}) {
    return take(3).map((e) => e.capitalize()).join(" | ");
  }
}

extension GenreExtensions on List<GenreItems> {
  String flatString({int count = 3}) {
    return take(3).map((e) => e.name.capitalize()).join(" | ");
  }
}

extension StringListExtension on List<String?> {
  String get detailsTitle {
    return nonNulls.join(" ● ");
  }
}
