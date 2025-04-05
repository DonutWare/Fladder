import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';

class MediaPlayButton extends ConsumerWidget {
  final ItemBaseModel? item;
  final Function()? onPressed;
  final Function()? onLongPressed;
  const MediaPlayButton({
    required this.item,
    this.onPressed,
    this.onLongPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = (item?.progress ?? 0) > 0;
    Widget buttonBuilder(bool resume, ButtonStyle? style, Color? textColor) {
      return ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        style: style,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  item?.playButtonLabel(context) ?? "",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                IconsaxPlusBold.play,
              ),
            ],
          ),
        ),
      );
    }

    return AnimatedFadeSize(
      duration: const Duration(milliseconds: 250),
      child: onPressed != null
          ? Stack(
              children: [
                buttonBuilder(resume, null, null),
                IgnorePointer(
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: (item?.progress ?? 0) / 100,
                      child: buttonBuilder(
                        resume,
                        ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                          foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                          iconColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                        ),
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              key: UniqueKey(),
            ),
    );
  }
}
