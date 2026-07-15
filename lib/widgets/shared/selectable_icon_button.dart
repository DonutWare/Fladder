import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class SelectableIconButton extends ConsumerStatefulWidget {
  final FutureOr<void>? Function()? onPressed;
  final String? label;
  final IconData icon;
  final IconData? selectedIcon;
  final bool selected;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool refreshOnEnd;
  final bool autofocus;
  const SelectableIconButton({
    required this.onPressed,
    this.selected = false,
    required this.icon,
    this.selectedIcon,
    this.label,
    this.backgroundColor,
    this.iconColor,
    this.refreshOnEnd = true,
    this.autofocus = false,
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
    final theme = Theme.of(context).colorScheme;
    final buttonState = WidgetStateProperty.resolveWith(
      (states) {
        return BorderSide(
          width: 2,
          color: theme.onPrimaryContainer.withValues(alpha: states.contains(WidgetState.focused) ? 0.9 : 0.0),
        );
      },
    );
    return Tooltip(
      message: widget.label ?? "",
      child: ElevatedButton(
        autofocus: widget.autofocus,
        style: ButtonStyle(
          side: buttonState,
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(
              widget.backgroundColor ?? (widget.selected ? theme.primaryContainer : theme.surfaceContainerLow)),
          iconColor: WidgetStatePropertyAll(widget.iconColor ?? (widget.selected ? theme.onPrimaryContainer : null)),
          foregroundColor:
              WidgetStatePropertyAll(widget.iconColor ?? (widget.selected ? theme.onPrimaryContainer : null)),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        ),
        onFocusChange: (value) {
          setState(() {
            focused = value;
          });
          if (value) {
            context.ensureVisible(
              alignment: 1.0,
            );
          }
        },
        onPressed: loading || widget.onPressed == null
            ? null
            : () async {
                setState(() => loading = true);
                try {
                  if (widget.onPressed != null) {
                    await widget.onPressed!();
                  }
                } catch (e) {
                  log(e.toString());
                } finally {
                  if (context.mounted && widget.refreshOnEnd) await context.refreshData();
                  setState(() => loading = false);
                }
              },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: widget.label != null ? 18 : 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
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
                    : !widget.selected || widget.selectedIcon == null
                        ? Opacity(
                            opacity: widget.selected || widget.selectedIcon == null ? 1.0 : 0.65,
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
              if (widget.label != null) ...{
                Text(
                  widget.label.toString(),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
