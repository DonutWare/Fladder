import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class MediaPlayButton extends ConsumerWidget {
  final ItemBaseModel? item;
  final Function(bool restart)? onPressed;
  final Function(bool restart)? onLongPressed;

  const MediaPlayButton({
    required this.item,
    this.onPressed,
    this.onLongPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = (item?.progress ?? 0) / 100.0;
    final radius = BorderRadius.circular(16);
    final smallRadius = const Radius.circular(4);
    final theme = Theme.of(context);

    Widget buttonTitle(Color contentColor) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                item?.playButtonLabel(context) ?? "",
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: contentColor,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              IconsaxPlusBold.play,
              color: contentColor,
            ),
          ],
        ),
      );
    }

    return AnimatedFadeSize(
      duration: const Duration(milliseconds: 250),
      child: onPressed == null
          ? const SizedBox.shrink(key: ValueKey('empty'))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Flexible(
                  child: FocusButton(
                    onTap: () => onPressed?.call(false),
                    onLongPress: () => onLongPressed?.call(false),
                    autoFocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                    borderRadius: radius.copyWith(
                      topRight: progress != 0 ? smallRadius : radius.topRight,
                      bottomRight: progress != 0 ? smallRadius : radius.bottomRight,
                    ),
                    darkOverlay: false,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Progress background
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: radius.copyWith(
                                topRight: progress != 0 ? smallRadius : radius.topRight,
                                bottomRight: progress != 0 ? smallRadius : radius.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        // Button content
                        buttonTitle(theme.colorScheme.onPrimaryContainer),
                        Positioned.fill(
                          child: ClipRect(
                            clipper: _ProgressClipper(
                              progress,
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: radius.copyWith(
                                  topRight: progress != 0 ? smallRadius : radius.topRight,
                                  bottomRight: progress != 0 ? smallRadius : radius.bottomRight,
                                ),
                              ),
                              child: buttonTitle(theme.colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (progress != 0)
                  FocusButton(
                    onTap: () => onPressed?.call(true),
                    onLongPress: () => onLongPressed?.call(true),
                    borderRadius: radius.copyWith(
                      topLeft: progress != 0 ? smallRadius : radius.topLeft,
                      bottomLeft: progress != 0 ? smallRadius : radius.bottomLeft,
                    ),
                    onFocusChanged: (value) {
                      if (value) {
                        context.ensureVisible(
                          alignment: 1.0,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: radius.copyWith(
                          topLeft: progress != 0 ? smallRadius : radius.topLeft,
                          bottomLeft: progress != 0 ? smallRadius : radius.bottomLeft,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.5),
                        child: Icon(
                          IconsaxPlusBold.refresh,
                          size: 29,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _ProgressClipper extends CustomClipper<Rect> {
  final double progress;
  _ProgressClipper(this.progress);

  @override
  Rect getClip(Size size) {
    final w = (progress.clamp(0.0, 1.0) * size.width);
    return Rect.fromLTWH(0, 0, w, size.height);
  }

  @override
  bool shouldReclip(covariant _ProgressClipper old) => old.progress != progress;
}
