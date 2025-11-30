import 'package:flutter/material.dart';

bool isEditableTextFocused() {
  final focus = FocusManager.instance.primaryFocus;
  if (focus == null) return false;
  final ctx = focus.context;
  if (ctx == null) return false;

  if (ctx.widget is EditableText) return true;
  return ctx.findAncestorWidgetOfExactType<EditableText>() != null;
}
