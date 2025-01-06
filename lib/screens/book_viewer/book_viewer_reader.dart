import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/book_viewer_settings_provider.dart';
import 'package:fladder/screens/book_viewer/book_viewer_controls.dart';

class BookViewerReader extends ConsumerWidget {
  final int index;
  final List<String> pages;
  final BookViewerSettingsModel bookViewSettings;
  final Function() previousPage;
  final Function() nextPage;
  final BookViewController viewController;
  final double lastScale;
  final Function(double value) newScale;
  const BookViewerReader({
    required this.index,
    required this.pages,
    required this.bookViewSettings,
    required this.previousPage,
    required this.nextPage,
    required this.viewController,
    required this.lastScale,
    required this.newScale,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double? initScale({
      required Size imageSize,
      required Size size,
      double? initialScale,
    }) {
      final double n1 = imageSize.height / imageSize.width;
      final double n2 = size.height / size.width;
      if (n1 > n2) {
        final FittedSizes fittedSizes = applyBoxFit(BoxFit.cover, imageSize, size);
        //final Size sourceSize = fittedSizes.source;
        final Size destinationSize = fittedSizes.destination;
        return size.width / destinationSize.width;
      } else if (n1 / n2 < 1 / 4) {
        final FittedSizes fittedSizes = applyBoxFit(BoxFit.cover, imageSize, size);
        //final Size sourceSize = fittedSizes.source;
        final Size destinationSize = fittedSizes.destination;
        return size.height / destinationSize.height;
      }

      return initialScale;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (tapDetails) {
        double screenWidth = MediaQuery.of(context).size.width;
        double tapPosition = tapDetails.globalPosition.dx;
        double tapPercentage = tapPosition / screenWidth;
        if (tapPercentage < 0.22) {
          bookViewSettings.readDirection == ReadDirection.leftToRight ? previousPage() : nextPage();
        } else if (tapPercentage < 0.88) {
          viewController.toggleControls();
        } else {
          bookViewSettings.readDirection == ReadDirection.leftToRight ? nextPage() : previousPage();
        }
      },
      child: ExtendedImage.file(
        fit: BoxFit.contain,
        imageCacheName: pages[index - 1],
        mode: ExtendedImageMode.gesture,
        initGestureConfigHandler: (state) {
          double? initialScale = !bookViewSettings.keepPageZoom
              ? switch (bookViewSettings.initZoomState) {
                  InitZoomState.contained => 1.0,
                  InitZoomState.covered => 1.75,
                }
              : lastScale;

          if (state.extendedImageInfo != null) {
            initialScale = initScale(
                size: MediaQuery.sizeOf(context),
                initialScale: initialScale,
                imageSize: Size(
                    state.extendedImageInfo!.image.width.toDouble(), state.extendedImageInfo!.image.height.toDouble()));
          }

          return GestureConfig(
            inertialSpeed: 300,
            inPageView: true,
            initialScale: initialScale!,
            initialAlignment: bookViewSettings.initZoomState == InitZoomState.contained && initialScale == 1.0
                ? InitialAlignment.center
                : switch (bookViewSettings.readDirection) {
                    ReadDirection.rightToLeft => InitialAlignment.topRight,
                    ReadDirection.leftToRight => InitialAlignment.topLeft,
                  },
            reverseMousePointerScrollDirection: true,
            maxScale: math.max(initialScale, 5.0),
            minScale: math.min(initialScale, 1),
            animationMaxScale: math.max(initialScale, 5.0),
            gestureDetailsIsChanged: (details) {
              if (bookViewSettings.keepPageZoom) {
                if (lastScale != (details?.totalScale ?? initialScale)) {
                  newScale(details?.totalScale ?? 1.0);
                }
              }
            },
            cacheGesture: bookViewSettings.cachePageZoom,
            hitTestBehavior: HitTestBehavior.translucent,
          );
        },
        File(pages[index - 1]),
      ),
    );
  }
}
