import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FocusedOutlinedTextField extends ConsumerStatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final int maxLines;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final List<String>? autoFillHints;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final TextStyle? style;
  final double borderWidth;
  final Color? fillColor;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(bool focused)? onFocus;
  final String? errorText;
  final bool? enabled;
  const FocusedOutlinedTextField({
    this.label,
    this.controller,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.style,
    this.borderWidth = 1,
    this.textAlign = TextAlign.start,
    this.autoFillHints,
    this.inputFormatters,
    this.autocorrect = true,
    this.keyboardType,
    this.textInputAction,
    this.onFocus,
    this.errorText,
    this.enabled,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FocuesOutlinedTextFieldState();
}

class FocuesOutlinedTextFieldState extends ConsumerState<FocusedOutlinedTextField> {
  late FocusNode focusNode = FocusNode();
  late bool previousFocus = focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (previousFocus != focusNode.hasFocus) {
        previousFocus = focusNode.hasFocus;
        widget.onFocus?.call(focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedTextField(
      controller: widget.controller,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      focusNode: focusNode,
      keyboardType: widget.keyboardType,
      autocorrect: widget.autocorrect,
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      style: widget.style,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign,
      fillColor: widget.fillColor,
      errorText: widget.errorText,
      autoFillHints: widget.autoFillHints,
      borderWidth: widget.borderWidth,
      enabled: widget.enabled,
      label: widget.label,
    );
  }
}
