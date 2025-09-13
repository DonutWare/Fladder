import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';

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

    return AnimatedFadeSize(
      duration: const Duration(milliseconds: 250),
      child: onPressed == null
          ? const SizedBox.shrink(key: ValueKey('empty'))
          : ElevatedButton(
              onPressed: onPressed,
              onLongPress: onLongPressed,
              autofocus: true,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onFocusChange: (value) {
                if (value) {
                  Scrollable.ensureVisible(
                    context,
                    duration: const Duration(milliseconds: 250),
                    alignment: 1,
                    curve: Curves.easeOut,
                  );
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Progress background
                  Positioned.fill(
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  // Button content
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          item?.playButtonLabel(context) ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        IconsaxPlusBold.play,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
