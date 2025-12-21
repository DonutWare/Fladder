import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/keyboard/slide_in_keyboard.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class OutlinedTextField extends ConsumerStatefulWidget {
  final String? label;
  final FocusNode? focusNode;
  final bool autoFocus;
  final TextEditingController? controller;
  final int maxLines;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final FutureOr<List<String>> Function(String query)? searchQuery;
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
    this.searchQuery,
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
  late final controller = widget.controller ?? TextEditingController();
  late final FocusNode _textFocus = widget.focusNode ?? FocusNode();
  late final FocusNode _wrapperFocus = FocusNode()
    ..addListener(() {
      setState(() {
        hasFocus = _wrapperFocus.hasFocus;
        if (hasFocus) {
          context.ensureVisible();
          if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer) {
            _textFocus.requestFocus();
          }
        }
      });
    });

  bool hasFocus = false;
  bool keyboardFocus = false;

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final useCustomKeyboard = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad &&
          ref.read(clientSettingsProvider.select((value) => !value.useSystemIME));
      if (widget.autoFocus) {
        if (useCustomKeyboard) {
          _wrapperFocus.requestFocus();
        } else {
          _textFocus.requestFocus();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.keyboardType == TextInputType.visiblePassword;
    final useCustomKeyboard = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad &&
        ref.watch(clientSettingsProvider.select((value) => !value.useSystemIME));

    final textField = TextField(
      controller: controller,
      onChanged: widget.onChanged,
      focusNode: _textFocus,
      onTap: widget.onTap,
      readOnly: useCustomKeyboard,
      autofillHints: widget.autoFillHints,
      keyboardType: widget.keyboardType,
      autocorrect: widget.autocorrect,
      onSubmitted: widget.onSubmitted != null
          ? (value) {
              widget.onSubmitted?.call(value);
              if (AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad) return;
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
    );

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 175),
          decoration: BoxDecoration(
            color: widget.decoration == null ? widget.fillColor ?? getColor() : null,
            borderRadius: FladderTheme.smallShape.borderRadius,
            border: BoxBorder.all(
              width: 2,
              color: hasFocus || keyboardFocus ? Theme.of(context).colorScheme.primaryFixed : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IgnorePointer(
              ignoring: widget.enabled == false,
              child: KeyboardListener(
                focusNode: _wrapperFocus,
                onKeyEvent: (KeyEvent event) async {
                  if (keyboardFocus || AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad) return;
                  if (event is KeyDownEvent && acceptKeys.contains(event.logicalKey)) {
                    if (_textFocus.hasFocus) {
                      _wrapperFocus.requestFocus();
                    } else if (_wrapperFocus.hasFocus) {
                      if (useCustomKeyboard) {
                        await openKeyboard(
                          context,
                          controller,
                          inputType: widget.keyboardType,
                          inputAction: widget.textInputAction,
                          searchQuery: widget.searchQuery,
                          onChanged: () {
                            widget.onChanged?.call(controller.text);
                          },
                        );
                        widget.onSubmitted?.call(controller.text);
                        setState(() {
                          keyboardFocus = false;
                        });
                        _wrapperFocus.requestFocus();
                      } else {
                        _textFocus.requestFocus();
                      }
                    }
                  }
                },
                child: ExcludeFocusTraversal(
                  child: textField,
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
