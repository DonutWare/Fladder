import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';

class FladderImage extends ConsumerWidget {
  final ImageData? image;
  final Widget Function(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded)? frameBuilder;
  final Widget? placeHolder;
  final BoxFit fit;
  final bool enableBlur;
  final bool blurOnly;
  const FladderImage({
    required this.image,
    this.frameBuilder,
    this.placeHolder,
    this.fit = BoxFit.cover,
    this.enableBlur = false,
    this.blurOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useBluredPlaceHolder = ref.watch(clientSettingsProvider.select((value) => value.blurPlaceHolders));
    final newImage = image;
    if (newImage == null) {
      return placeHolder ?? Container();
    } else {
      return Stack(
        key: Key(newImage.key),
        fit: StackFit.expand,
        children: [
          if (useBluredPlaceHolder && !enableBlur && newImage.hash.isNotEmpty && !enableBlur)
            Image(
              fit: fit,
              excludeFromSemantics: true,
              filterQuality: FilterQuality.low,
              image: BlurHashImage(
                newImage.hash,
              ),
            ),
          if (!blurOnly)
            FadeInImage(
              placeholder: Image.memory(kTransparentImage).image,
              fit: fit,
              placeholderFit: fit,
              excludeFromSemantics: true,
              filterQuality: FilterQuality.high,
              placeholderFilterQuality: FilterQuality.low,
              image: newImage.imageProvider,
            )
        ],
      );
    }
  }
}
