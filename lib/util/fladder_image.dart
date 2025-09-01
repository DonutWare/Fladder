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
  final StackFit stackFit;
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
    this.stackFit = StackFit.expand,
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
    final imageProvider = image?.imageProvider;
    if (newImage == null) {
      return placeHolder ?? Container();
    } else {
      return Stack(
        key: Key(newImage.key),
        fit: stackFit,
        children: [
          if (!disableBlur && useBluredPlaceHolder && newImage.hash.isNotEmpty || blurOnly)
            Image(
              image: BlurHashImage(
                newImage.hash,
                decodingHeight: 24,
                decodingWidth: 24,
              ),
              fit: blurFit ?? fit,
            ),
          if (!blurOnly && imageProvider != null)
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              fit: fit,
              placeholderFit: fit,
              excludeFromSemantics: true,
              alignment: alignment ?? Alignment.center,
              imageErrorBuilder: imageErrorBuilder,
              image: imageProvider,
            )
        ],
      );
    }
  }
}
