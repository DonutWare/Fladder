import 'dart:math' as math;

import 'package:flutter/widgets.dart';

const _imageSizeSteps = [64, 128, 192, 256, 384, 512, 768, 1024, 1280, 1536, 1920, 2560, 3840];

int? _toImageSizeStep(double logicalSize, double pixelRatio) {
  if (!logicalSize.isFinite || logicalSize <= 0) return null;
  final physical = logicalSize * pixelRatio;
  return _imageSizeSteps.firstWhere((step) => step >= physical, orElse: () => _imageSizeSteps.last);
}

class ImageRequestSize {
  final int? width;
  final int? height;

  const ImageRequestSize({this.width, this.height});

  factory ImageRequestSize.fromConstraints(BuildContext context, BoxConstraints constraints) {
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return ImageRequestSize(
      width: _toImageSizeStep(constraints.maxWidth, ratio),
      height: _toImageSizeStep(constraints.maxHeight, ratio),
    );
  }

  bool get isEmpty => width == null && height == null;

  bool covers(ImageRequestSize other) => (width ?? 0) >= (other.width ?? 0) && (height ?? 0) >= (other.height ?? 0);

  ImageRequestSize merge(ImageRequestSize other) => ImageRequestSize(
        width: _maxOrNull(width, other.width),
        height: _maxOrNull(height, other.height),
      );

  static int? _maxOrNull(int? a, int? b) => a == null ? b : (b == null ? a : math.max(a, b));

  String get cacheSuffix => '${width ?? 0}x${height ?? 0}';
}
