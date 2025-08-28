import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/theme.dart';

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
    this.enabled,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends ConsumerState<OutlinedTextField> {
  late FocusNode focusNode = widget.focusNode ?? FocusNode();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Color getColor() {
    if (widget.errorText != null) return Theme.of(context).colorScheme.errorContainer;
    return Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.25);
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.keyboardType == TextInputType.visiblePassword;
    if (widget.autoFocus) {
      focusNode.requestFocus();
    }
    focusNode.addListener(
      () {},
    );
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: widget.fillColor ?? getColor(),
                    borderRadius: FladderTheme.defaultShape.borderRadius,
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: widget.enabled == false,
              child: TextField(
                controller: widget.controller,
                onChanged: widget.onChanged,
                focusNode: focusNode,
                onTap: widget.onTap,
                autofillHints: widget.autoFillHints,
                keyboardType: widget.keyboardType,
                autocorrect: widget.autocorrect,
                onSubmitted: widget.onSubmitted,
                textInputAction: widget.textInputAction,
                obscureText: isPasswordField ? _obscureText : false,
                style: widget.style,
                maxLines: widget.maxLines,
                inputFormatters: widget.inputFormatters,
                textAlign: widget.textAlign,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0),
                      width: widget.borderWidth,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0),
                      width: widget.borderWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0),
                      width: widget.borderWidth,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0),
                      width: widget.borderWidth,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0),
                      width: widget.borderWidth,
                    ),
                  ),
                  filled: widget.fillColor != null,
                  fillColor: widget.fillColor,
                  labelText: widget.label,
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
          ],
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
