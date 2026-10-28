import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/image_sizing.dart';

class FladderImage extends ConsumerStatefulWidget {
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
  final int? decodeHeight;
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
    this.decodeHeight,
    this.cachedImage = true,
    super.key,
  });

  @override
  ConsumerState<FladderImage> createState() => _FladderImageState();
}

class _FladderImageState extends ConsumerState<FladderImage> with SingleTickerProviderStateMixin {
  late final AnimationController _fade = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  late final Animation<double> _fadeCurve = CurvedAnimation(parent: _fade, curve: Curves.easeIn);
  ImageRequestSize? _requestSize;
  ImageRequestSize? _pendingSize;
  Timer? _resizeTimer;

  @override
  void didUpdateWidget(covariant FladderImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image?.key != widget.image?.key) {
      _resizeTimer?.cancel();
      _requestSize = null;
      _fade.value = 0;
    }
  }

  @override
  void dispose() {
    _resizeTimer?.cancel();
    _fade.dispose();
    super.dispose();
  }

  ImageRequestSize _resolveRequestSize(ImageRequestSize measured) {
    final current = _requestSize;
    if (current == null) return _requestSize = measured;
    if (!current.covers(measured) && _pendingSize?.covers(measured) != true) {
      _pendingSize = measured;
      _resizeTimer?.cancel();
      _resizeTimer = Timer(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() => _requestSize = current.merge(measured));
        _pendingSize = null;
      });
    }
    return current;
  }

  ImageProvider _imageProvider(ImageData image, BoxConstraints constraints) {
    if (!widget.cachedImage) return image.nonCachedImageProvider;
    final decodeHeight = widget.decodeHeight;
    if (decodeHeight != null) {
      return ResizeImage(image.imageProvider, policy: ResizeImagePolicy.fit, height: decodeHeight);
    }
    final requestSize = _resolveRequestSize(ImageRequestSize.fromConstraints(context, constraints));
    return image.sizedImageProvider(requestSize, widget.fit);
  }

  @override
  Widget build(BuildContext context) {
    final useBluredPlaceHolder = ref.watch(clientSettingsProvider.select((value) => value.blurPlaceHolders));
    final newImage = widget.image;

    if (newImage == null) {
      return widget.placeHolder ?? Container();
    }
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        key: Key(newImage.key),
        fit: widget.stackFit,
        children: [
          if (!widget.disableBlur && useBluredPlaceHolder && newImage.hash.isNotEmpty ||
              widget.blurOnly && newImage.hash.isNotEmpty)
            Image(
              image: BlurHashImage(
                newImage.hash,
                decodingHeight: 16,
                decodingWidth: 16,
              ),
              fit: widget.blurFit ?? widget.fit,
              height: 16,
            ),
          if (!widget.blurOnly)
            Image(
              image: _imageProvider(newImage, constraints),
              fit: widget.fit,
              alignment: widget.alignment ?? Alignment.center,
              gaplessPlayback: true,
              errorBuilder: widget.imageErrorBuilder,
              frameBuilder: widget.frameBuilder ?? _fadeIn,
              opacity: widget.frameBuilder == null ? _fadeCurve : null,
            ),
        ],
      ),
    );
  }

  Widget _fadeIn(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
    if (frame != null && _fade.isDismissed) {
      if (wasSynchronouslyLoaded) {
        _fade.value = 1;
      } else {
        _fade.forward();
      }
    }
    return child;
  }
}
