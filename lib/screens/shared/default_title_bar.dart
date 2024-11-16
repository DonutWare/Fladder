import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/util/adaptive_layout.dart';

class DefaultTitleBar extends ConsumerStatefulWidget {
  final String? label;
  final double? height;
  final Brightness? brightness;
  const DefaultTitleBar({this.height = defaultTitleBarHeight, this.label, this.brightness, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DefaultTitleBarState();
}

class _DefaultTitleBarState extends ConsumerState<DefaultTitleBar> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = widget.brightness ?? Theme.of(context).brightness;
    final shadows = brightness == Brightness.dark
        ? [
            BoxShadow(blurRadius: 1, spreadRadius: 1, color: Theme.of(context).colorScheme.surface.withOpacity(1)),
            BoxShadow(blurRadius: 8, spreadRadius: 2, color: Colors.black.withOpacity(0.2)),
            BoxShadow(blurRadius: 3, spreadRadius: 2, color: Colors.black.withOpacity(0.3)),
          ]
        : <BoxShadow>[];
    final iconColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.65);
    return SizedBox(
      height: widget.height,
      child: switch (AdaptiveLayout.of(context).platform) {
        TargetPlatform.android || TargetPlatform.iOS => SizedBox(height: MediaQuery.paddingOf(context).top),
        TargetPlatform.windows || TargetPlatform.linux => Row(
            children: [
              Expanded(
                child: DragToMoveArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: iconColor,
                            fontSize: 14,
                          ),
                          child: Text(widget.label ?? ""),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  FutureBuilder(
                      future: windowManager.isMinimizable(),
                      builder: (context, data) {
                        final isMinimized = !(data.data ?? false);
                        return IconButton(
                          style: IconButton.styleFrom(
                              hoverColor: brightness == Brightness.light
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white.withOpacity(0.2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                          onPressed: () async {
                            if (isMinimized) {
                              windowManager.restore();
                            } else {
                              windowManager.minimize();
                            }
                          },
                          icon: Transform.translate(
                            offset: const Offset(0, -2),
                            child: Icon(
                              Icons.minimize_rounded,
                              color: iconColor,
                              size: 20,
                              shadows: shadows,
                            ),
                          ),
                        );
                      }),
                  FutureBuilder<List<bool>>(
                    future: Future.microtask(() async {
                      final isMaximized = await windowManager.isMaximized();
                      final isFullScreen = await windowManager.isFullScreen();
                      return [isMaximized, isFullScreen];
                    }),
                    builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
                      final maximized = snapshot.data?.firstOrNull ?? false;
                      final fullScreen = snapshot.data?.lastOrNull ?? false;
                      return IconButton(
                        style: IconButton.styleFrom(
                          hoverColor: brightness == Brightness.light
                              ? Colors.black.withOpacity(0.1)
                              : Colors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        ),
                        onPressed: () async {
                          if (fullScreen == true && maximized == true) {
                            await windowManager.setFullScreen(false);
                            await windowManager.unmaximize();
                            return;
                          }
                          if (fullScreen == true) {
                            windowManager.setFullScreen(false);
                          } else {
                            maximized == false ? windowManager.maximize() : windowManager.unmaximize();
                          }
                        },
                        icon: Transform.translate(
                          offset: const Offset(0, 0),
                          child: Icon(
                            maximized ? Icons.maximize_rounded : Icons.crop_square_rounded,
                            color: iconColor,
                            size: 19,
                            shadows: shadows,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      hoverColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    onPressed: () async {
                      windowManager.close();
                    },
                    icon: Transform.translate(
                      offset: const Offset(0, -2),
                      child: Icon(
                        Icons.close_rounded,
                        color: iconColor,
                        size: 23,
                        shadows: shadows,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        TargetPlatform.macOS => const SizedBox.shrink(),
        _ => Text(widget.label ?? "Fladder"),
      },
    );
  }
}
