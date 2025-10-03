import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class MediaPlayButton extends ConsumerWidget {
  final ItemBaseModel? item;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const MediaPlayButton({
    required this.item,
    this.onPressed,
    this.onLongPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = (item?.progress ?? 0) / 100.0;
    final padding = 3.0;
    final radius = FladderTheme.smallShape.borderRadius.subtract(BorderRadius.circular(padding));
    final buttonState = WidgetStateProperty.resolveWith(
      (states) {
        return BorderSide(
          width: 2,
          color: Theme.of(context)
              .colorScheme
              .onPrimaryContainer
              .withValues(alpha: states.contains(WidgetState.focused) ? 0.9 : 0.0),
        );
      },
    );

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
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
          : TextButton(
              onPressed: onPressed,
              onLongPress: onLongPressed,
              autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
              style: ButtonStyle(
                side: buttonState,
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              ),
              onFocusChange: (value) {
                if (value) {
                  context.ensureVisible(
                    alignment: 1.0,
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress background
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: radius,
                        ),
                      ),
                    ),
                    // Button content
                    buttonTitle(Theme.of(context).colorScheme.onPrimaryContainer),
                    Positioned.fill(
                      child: ClipRect(
                        clipper: _ProgressClipper(
                          progress,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: radius,
                          ),
                          child: buttonTitle(Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
