import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/full_screen_helpers/full_screen_wrapper.dart';

class DefaultTitleBar extends ConsumerStatefulWidget {
  final String? label;
  final double? height;
  final Brightness? brightness;
  const DefaultTitleBar({this.height = defaultTitleBarHeight, this.label, this.brightness, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DefaultTitleBarState();
}

class _DefaultTitleBarState extends ConsumerState<DefaultTitleBar> with WindowListener {
  bool hovering = false;

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
    if (ref.watch(argumentsStateProvider.select((value) => value.htpcMode))) return const SizedBox.shrink();
    final brightness = widget.brightness ?? Theme.of(context).brightness;
    final iconColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65);
    return MouseRegion(
      onEnter: (event) => setState(() => hovering = true),
      onExit: (event) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: hovering ? Colors.black.withValues(alpha: 0.15) : Colors.transparent,
        ),
        height: widget.height,
        child: kIsWeb
            ? const SizedBox.shrink()
            : switch (AdaptiveLayout.of(context).platform) {
                TargetPlatform.android || TargetPlatform.iOS => SizedBox(height: MediaQuery.paddingOf(context).top),
                TargetPlatform.windows || TargetPlatform.linux => Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.black.withValues(alpha: 0),
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
                      ),
                      Row(
                        children: [
                          FutureBuilder<List<bool>>(future: Future.microtask(() async {
                            final isMinimized = await windowManager.isMinimized();
                            return [isMinimized];
                          }), builder: (context, snapshot) {
                            final isMinimized = snapshot.data?.firstOrNull ?? false;
                            return IconButton(
                              style: IconButton.styleFrom(
                                  hoverColor: brightness == Brightness.light
                                      ? Colors.black.withValues(alpha: 0.1)
                                      : Colors.white.withValues(alpha: 0.2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                              onPressed: () async {
                                fullScreenHelper.closeFullScreen(ref);
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
                                ),
                              ),
                            );
                          }),
                          FutureBuilder<List<bool>>(
                            future: Future.microtask(() async {
                              final isMaximized = await windowManager.isMaximized();
                              return [isMaximized];
                            }),
                            builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
                              final maximized = snapshot.data?.firstOrNull ?? false;
                              return IconButton(
                                style: IconButton.styleFrom(
                                  hoverColor: brightness == Brightness.light
                                      ? Colors.black.withValues(alpha: 0.1)
                                      : Colors.white.withValues(alpha: 0.2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                ),
                                onPressed: () async {
                                  fullScreenHelper.closeFullScreen(ref);
                                  if (maximized) {
                                    await windowManager.unmaximize();
                                    return;
                                  }
                                  if (!maximized) {
                                    await windowManager.maximize();
                                  } else {
                                    await windowManager.unmaximize();
                                  }
                                },
                                icon: Transform.translate(
                                  offset: const Offset(0, 0),
                                  child: Icon(
                                    maximized ? Icons.maximize_rounded : Icons.crop_square_rounded,
                                    color: iconColor,
                                    size: 19,
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
      ),
    );
  }
}
