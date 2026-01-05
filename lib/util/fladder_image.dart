import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/arguments_provider.dart';
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
  final bool cachedImage;
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
    this.cachedImage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useBluredPlaceHolder = ref.watch(clientSettingsProvider.select((value) => value.blurPlaceHolders));
    final newImage = image;
    final imageProvider = cachedImage ? image?.imageProvider : image?.nonCachedImageProvider;

    final leanBackMode = ref.watch(argumentsStateProvider.select((value) => value.leanBackMode));

    if (newImage == null) {
      return placeHolder ?? Container();
    } else {
      if (!leanBackMode && (blurOnly && newImage.hash.isEmpty && imageProvider != null)) {
        return ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Image(
            image: ResizeImage(imageProvider, width: 32, height: 32),
            fit: blurFit ?? fit,
            alignment: alignment ?? Alignment.center,
          ),
        );
      }
      return Stack(
        key: Key(newImage.key),
        fit: stackFit,
        children: [
          if (!disableBlur && useBluredPlaceHolder && newImage.hash.isNotEmpty || blurOnly && newImage.hash.isNotEmpty)
            Image(
              image: BlurHashImage(
                newImage.hash,
                decodingHeight: 16,
                decodingWidth: 16,
              ),
              fit: blurFit ?? fit,
              height: 16,
            ),
          if (!blurOnly && imageProvider != null)
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              fit: fit,
              placeholderFit: fit,
              alignment: alignment ?? Alignment.center,
              imageErrorBuilder: imageErrorBuilder,
              image: imageProvider,
            )
        ],
      );
    }
  }
}
