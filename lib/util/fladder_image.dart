import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';

class FladderImage extends ConsumerWidget {
  final ImageData? image;
  final Widget Function(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded)? frameBuilder;
  final Widget Function(BuildContext context, Object object, StackTrace? stack)? imageErrorBuilder;
  final Widget? placeHolder;
  final BoxFit fit;
  final BoxFit? blurFit;
  final AlignmentGeometry? alignment;
  final bool disableBlur;
  final bool blurOnly;
  const FladderImage({
    required this.image,
    this.frameBuilder,
    this.imageErrorBuilder,
    this.placeHolder,
    this.fit = BoxFit.cover,
    this.blurFit,
    this.alignment,
    this.disableBlur = false,
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
          if (!(disableBlur && useBluredPlaceHolder) && useBluredPlaceHolder && newImage.hash.isNotEmpty)
            BlurHash(
              hash: newImage.hash,
              optimizationMode: BlurHashOptimizationMode.approximation,
              color: Colors.transparent,
              imageFit: blurFit ?? fit,
            ),
          if (!blurOnly)
            FadeInImage(
              placeholder: Image.memory(kTransparentImage).image,
              fit: fit,
              placeholderFit: fit,
              excludeFromSemantics: true,
              alignment: alignment ?? Alignment.center,
              imageErrorBuilder: imageErrorBuilder,
              image: newImage.imageProvider,
            )
        ],
      );
    }
  }
}
