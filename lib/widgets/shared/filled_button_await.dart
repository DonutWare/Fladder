import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';

class FilledButtonAwait extends StatefulWidget {
  final FutureOr<dynamic> Function() onPressed;
  final ButtonStyle? style;
  final Widget child;

  final bool _tonal;

  const FilledButtonAwait({
    required this.onPressed,
    this.style,
    required this.child,
    super.key,
  }) : _tonal = false;

  const FilledButtonAwait.tonal({
    required this.onPressed,
    this.style,
    required this.child,
    super.key,
  }) : _tonal = true;

  @override
  State<FilledButtonAwait> createState() => FilledButtonAwaitState();
}

class FilledButtonAwaitState extends State<FilledButtonAwait> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    const iconSize = 24.0;
    if (widget._tonal) {
      return FilledButton.tonal(
          style: widget.style,
          onPressed: loading
              ? null
              : () async {
                  setState(() => loading = true);
                  try {
                    await widget.onPressed();
                  } catch (e) {
                    log(e.toString());
                  } finally {
                    setState(() => loading = false);
                  }
                },
          child: AnimatedFadeSize(
            duration: duration,
            child: loading
                ? Opacity(
                    opacity: 0.75,
                    child: SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        color: widget.style?.foregroundColor?.resolve({WidgetState.hovered}),
                      ),
                    ),
                  )
                : widget.child,
          ));
    }
    return FilledButton(
        style: widget.style,
        onPressed: loading
            ? null
            : () async {
                setState(() => loading = true);
                try {
                  await widget.onPressed();
                } catch (e) {
                  log(e.toString());
                } finally {
                  setState(() => loading = false);
                }
              },
        child: AnimatedFadeSize(
          duration: duration,
          child: loading
              ? Opacity(
                  opacity: 0.75,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: widget.style?.foregroundColor?.resolve({WidgetState.hovered}),
                    ),
                  ),
                )
              : widget.child,
        ));
  }
}
