import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/refresh_state.dart';

class SelectableIconButton extends ConsumerStatefulWidget {
  final FutureOr<dynamic> Function() onPressed;
  final String? label;
  final IconData icon;
  final IconData? selectedIcon;
  final bool selected;
  final Color? backgroundColor;
  final Color? iconColor;
  const SelectableIconButton({
    required this.onPressed,
    required this.selected,
    required this.icon,
    this.selectedIcon,
    this.label,
    this.backgroundColor,
    this.iconColor,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectableIconButtonState();
}

class _SelectableIconButtonState extends ConsumerState<SelectableIconButton> {
  bool loading = false;
  bool focused = false;
  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    const iconSize = 24.0;
    return AnimatedScale(
      duration: const Duration(milliseconds: 125),
      scale: focused ? 1.1 : 1,
      child: Tooltip(
        message: widget.label ?? "",
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(
                widget.backgroundColor != null ? (widget.backgroundColor!.a < 1 ? 0 : null) : null),
            backgroundColor: WidgetStatePropertyAll(
                widget.backgroundColor ?? (widget.selected ? Theme.of(context).colorScheme.primary : null)),
            iconColor: WidgetStatePropertyAll(
                widget.iconColor ?? (widget.selected ? Theme.of(context).colorScheme.onPrimary : null)),
            foregroundColor: WidgetStatePropertyAll(
                widget.iconColor ?? (widget.selected ? Theme.of(context).colorScheme.onPrimary : null)),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          onFocusChange: (value) {
            setState(() {
              focused = value;
            });
            if (value) {
              Scrollable.ensureVisible(
                context,
                duration: const Duration(milliseconds: 250),
                alignment: 1,
                curve: Curves.easeOut,
              );
            }
          },
          onPressed: loading
              ? null
              : () async {
                  setState(() => loading = true);
                  try {
                    await widget.onPressed();
                  } catch (e) {
                    log(e.toString());
                  } finally {
                    if (context.mounted) await context.refreshData();
                    setState(() => loading = false);
                  }
                },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: widget.label != null ? 18 : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.label != null) ...{
                  Text(
                    widget.label.toString(),
                  ),
                  const SizedBox(width: 10),
                },
                AnimatedFadeSize(
                  duration: duration,
                  child: loading
                      ? Opacity(
                          opacity: 0.75,
                          child: SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                              color: widget.selected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : !widget.selected
                          ? Opacity(
                              opacity: 0.65,
                              child: Icon(
                                key: const Key("selected-off"),
                                widget.icon,
                                size: iconSize,
                              ),
                            )
                          : Icon(
                              key: const Key("selected-on"),
                              widget.selectedIcon,
                              size: iconSize,
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
