import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';

class IconButtonAwait extends StatefulWidget {
  final FutureOr<dynamic> Function() onPressed;
  final Color? color;
  final Widget icon;

  const IconButtonAwait({required this.onPressed, required this.icon, this.color, super.key});

  @override
  State<IconButtonAwait> createState() => IconButtonAwaitState();
}

class IconButtonAwaitState extends State<IconButtonAwait> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    const iconSize = 24.0;
    return IconButton(
        color: widget.color,
        onPressed: loading
            ? null
            : () async {
                setState(() => loading = true);
                try {
                  await widget.onPressed();
                } catch (e) {
                  log(e.toString());
                } finally {
                  if (mounted) {
                    setState(() {
                      loading = false;
                    });
                  }
                }
              },
        icon: AnimatedFadeSize(
          duration: duration,
          child: loading
              ? Opacity(
                  opacity: 0.75,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : widget.icon,
        ));
  }
}
