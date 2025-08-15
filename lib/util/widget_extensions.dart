import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget padding(EdgeInsets insets) {
    return Padding(
      padding: insets,
      child: this,
    );
  }

  Widget setKey(Key? key) {
    return Center(
      key: key,
      child: this,
    );
  }

  Widget addHeroTag(String? tag) {
    if (tag != null) {
      return Hero(tag: tag, child: this);
    } else {
      return this;
    }
  }

  Widget addVisiblity(bool visible) {
    return AnimatedOpacity(duration: const Duration(milliseconds: 250), opacity: visible ? 1 : 0.10, child: this);
  }
}
