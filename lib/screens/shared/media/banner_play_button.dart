import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';

class BannerPlayButton extends ConsumerWidget {
  final ItemBaseModel item;
  const BannerPlayButton({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
        opacity: 0.9,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Transform.scale(
                    scale: 1.01,
                    child: SquareProgressIndicator(
                      value: item.userData.progress / 100,
                      borderRadius: 12,
                      strokeWidth: 12,
                      strokeAlign: SquareStrokeAlign.center,
                      strokeCap: StrokeCap.round,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => item.play(context, ref),
                  icon: const Icon(
                    IconsaxBold.play,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
