import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/focus_provider.dart';

class OutlinedTextField extends ConsumerStatefulWidget {
  final String? label;
  final FocusNode? focusNode;
  final bool autoFocus;
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
  final InputDecoration? decoration;
  final String? placeHolder;
  final String? suffix;
  final String? errorText;
  final bool? enabled;

  const OutlinedTextField({
    this.label,
    this.focusNode,
    this.autoFocus = false,
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
    this.errorText,
    this.placeHolder,
    this.decoration,
    this.suffix,
    this.enabled,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends ConsumerState<OutlinedTextField> {
  late final FocusNode _textFocus = widget.focusNode ?? FocusNode();
  late final FocusNode _wrapperFocus = FocusNode()
    ..addListener(() {
      setState(() {
        hasFocus = _wrapperFocus.hasFocus;
        if (hasFocus) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 250),
            alignment: 0.5,
            curve: Curves.easeOut,
          );
        }
      });
    });

  bool hasFocus = false;

  @override
  void dispose() {
    _textFocus.dispose();
    _wrapperFocus.dispose();
    super.dispose();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Color getColor() {
    if (widget.errorText != null) return Theme.of(context).colorScheme.errorContainer;
    return Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35);
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.keyboardType == TextInputType.visiblePassword;
    final leanBackMode = ref.watch(argumentsStateProvider).leanBackMode;
    if (widget.autoFocus) {
      if (leanBackMode) {
        _wrapperFocus.requestFocus();
      } else {
        _textFocus.requestFocus();
      }
    }
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 175),
          decoration: BoxDecoration(
            color: widget.decoration == null ? widget.fillColor ?? getColor() : null,
            borderRadius: FladderTheme.smallShape.borderRadius,
            border: BoxBorder.all(
              width: 2,
              color: hasFocus ? Theme.of(context).colorScheme.primaryFixed : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IgnorePointer(
              ignoring: widget.enabled == false,
              child: KeyboardListener(
                focusNode: _wrapperFocus,
                onKeyEvent: (KeyEvent event) {
                  if (event is KeyUpEvent && acceptKeys.contains(event.logicalKey)) {
                    if (_textFocus.hasFocus) {
                      _textFocus.unfocus();
                      _wrapperFocus.requestFocus();
                    } else if (_wrapperFocus.hasFocus) {
                      _textFocus.requestFocus();
                    }
                  }
                },
                child: ExcludeFocusTraversal(
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    focusNode: _textFocus,
                    onTap: widget.onTap,
                    autofillHints: widget.autoFillHints,
                    keyboardType: widget.keyboardType,
                    autocorrect: widget.autocorrect,
                    onSubmitted: widget.onSubmitted != null
                        ? (value) {
                            widget.onSubmitted?.call(value);
                            Future.microtask(() async {
                              await Future.delayed(const Duration(milliseconds: 125));
                              _wrapperFocus.requestFocus();
                            });
                          }
                        : null,
                    textInputAction: widget.textInputAction,
                    obscureText: isPasswordField ? _obscureText : false,
                    style: widget.style,
                    maxLines: widget.maxLines,
                    inputFormatters: widget.inputFormatters,
                    textAlign: widget.textAlign,
                    canRequestFocus: true,
                    decoration: widget.decoration ??
                        InputDecoration(
                          border: InputBorder.none,
                          filled: widget.fillColor != null,
                          fillColor: widget.fillColor,
                          labelText: widget.label,
                          suffix: widget.suffix != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Text(widget.suffix!),
                                )
                              : null,
                          hintText: widget.placeHolder,
                          // errorText: widget.errorText,
                          suffixIcon: isPasswordField
                              ? InkWell(
                                  onTap: _toggle,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    size: 16.0,
                                  ),
                                )
                              : null,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedFadeSize(
          child: widget.errorText != null
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.errorText ?? "",
                    style:
                        Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
