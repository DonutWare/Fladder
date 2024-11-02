import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:extended_image/extended_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/settings/photo_view_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/throttler.dart';
import 'package:fladder/widgets/shared/elevated_icon.dart';
import 'package:fladder/widgets/shared/progress_floating_button.dart';

class PhotoViewerControls extends ConsumerStatefulWidget {
  final EdgeInsets padding;
  final PhotoModel photo;
  final int itemCount;
  final bool loadingMoreItems;
  final int currentIndex;
  final ValueChanged<PhotoModel> onPhotoChanged;
  final Function() openOptions;
  final ExtendedPageController pageController;
  final Function(bool? value)? toggleOverlay;
  const PhotoViewerControls({
    required this.padding,
    required this.photo,
    required this.pageController,
    required this.loadingMoreItems,
    required this.openOptions,
    required this.onPhotoChanged,
    required this.itemCount,
    required this.currentIndex,
    this.toggleOverlay,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoViewerControllsState();
}

class _PhotoViewerControllsState extends ConsumerState<PhotoViewerControls> with WindowListener {
  final Throttler throttler = Throttler(duration: const Duration(milliseconds: 130));
  late int currentPage = widget.pageController.page?.round() ?? 0;
  double dragUpDelta = 0.0;

  final controller = TextEditingController();
  late final timerController = RestarableTimerController(
      ref.read(photoViewSettingsProvider).timer, const Duration(milliseconds: 32), onTimeout: () {
    if (widget.pageController.page == widget.itemCount - 1) {
      widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    } else {
      widget.pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    }
  });

  void _resetOnScroll() {
    if (currentPage != widget.pageController.page?.round()) {
      currentPage = widget.pageController.page?.round() ?? 0;
    }
  }

  bool _onKey(KeyEvent value) {
    if (value is KeyRepeatEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
        throttler.run(() =>
            widget.pageController.previousPage(duration: const Duration(milliseconds: 125), curve: Curves.easeInOut));
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
        throttler.run(
            () => widget.pageController.nextPage(duration: const Duration(milliseconds: 125), curve: Curves.easeInOut));
        return true;
      }
    }
    if (value is KeyDownEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
        throttler.run(() =>
            widget.pageController.previousPage(duration: const Duration(milliseconds: 125), curve: Curves.easeInOut));
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
        throttler.run(
            () => widget.pageController.nextPage(duration: const Duration(milliseconds: 125), curve: Curves.easeInOut));
        return true;
      }

      if (value.logicalKey == LogicalKeyboardKey.keyK) {
        timerController.playPause();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.space) {
        widget.toggleOverlay?.call(null);
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    widget.pageController.addListener(
      () {
        _resetOnScroll();
        timerController.reset();
      },
    );
  }

  @override
  void onWindowMinimize() {
    timerController.cancel();
    super.onWindowMinimize();
  }

  @override
  void dispose() {
    timerController.dispose();
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = [
      Colors.black.withOpacity(0.6),
      Colors.black.withOpacity(0.3),
      Colors.black.withOpacity(0.1),
      Colors.black.withOpacity(0.0),
    ];

    final padding = MediaQuery.of(context).padding;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async => await WakelockPlus.disable(),
      child: InputHandler(
        onKeyEvent: (node, event) => _onKey(event) ? KeyEventResult.handled : KeyEventResult.ignored,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradient,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: widget.padding.top),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (AdaptiveLayout.of(context).isDesktop) const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12)
                            .add(EdgeInsets.only(left: padding.left, right: padding.right)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedIconButton(
                              onPressed: () => Navigator.of(context).pop(widget.pageController.page?.toInt()),
                              icon: getBackIcon(context),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Tooltip(
                                message: widget.photo.name,
                                child: Text(
                                  widget.photo.name,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold, shadows: [
                                    BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.black.withOpacity(0.7)),
                                    BoxShadow(blurRadius: 4, spreadRadius: 4, color: Colors.black.withOpacity(0.4)),
                                    BoxShadow(blurRadius: 20, spreadRadius: 6, color: Colors.black.withOpacity(0.2)),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context).colorScheme.onPrimary),
                                    child: SquareProgressIndicator(
                                      value: widget.currentIndex / (widget.itemCount - 1),
                                      borderRadius: 7,
                                      clockwise: false,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${widget.currentIndex + 1} / ${widget.loadingMoreItems ? "-" : "${widget.itemCount}"} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      if (widget.loadingMoreItems)
                                        const SizedBox.square(
                                          dimension: 16,
                                          child: CircularProgressIndicator.adaptive(
                                            strokeCap: StrokeCap.round,
                                          ),
                                        ),
                                    ].addInBetween(const SizedBox(width: 6)),
                                  ),
                                ),
                                Positioned.fill(
                                  child: FlatButton(
                                    borderRadiusGeometry: BorderRadius.circular(8),
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          child: SizedBox(
                                            width: 125,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    context.localized.goTo,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(fontWeight: FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  IntInputField(
                                                    controller: TextEditingController(
                                                        text: (widget.currentIndex + 1).toString()),
                                                    onSubmitted: (value) {
                                                      final position =
                                                          ((value ?? 0) - 1).clamp(0, widget.itemCount - 1);
                                                      widget.pageController.jumpToPage(position);
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradient.reversed.toList(),
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.padding.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.all(8.0).add(EdgeInsets.only(left: padding.left, right: padding.right)),
                        child: Row(
                          children: [
                            ElevatedIconButton(
                              onPressed: widget.openOptions,
                              icon: IconsaxOutline.more_2,
                            ),
                            const Spacer(),
                            ElevatedIconButton(
                              onPressed: markAsFavourite,
                              color: widget.photo.userData.isFavourite ? Colors.red : null,
                              icon: widget.photo.userData.isFavourite ? IconsaxBold.heart : IconsaxOutline.heart,
                            ),
                            ProgressFloatingButton(
                              controller: timerController,
                              onLongPress: (duration) {
                                if (duration != null) {
                                  ref
                                      .read(photoViewSettingsProvider.notifier)
                                      .update((state) => state.copyWith(timer: duration));
                                }
                              },
                            ),
                          ].addPadding(const EdgeInsets.symmetric(horizontal: 8)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void markAsFavourite() {
    ref.read(userProvider.notifier).setAsFavorite(!widget.photo.userData.isFavourite, widget.photo.id);

    widget.onPhotoChanged(widget.photo
        .copyWith(userData: widget.photo.userData.copyWith(isFavourite: !widget.photo.userData.isFavourite)));
  }

  Future<void> sharePhoto() async {
    final file = await DefaultCacheManager().getSingleFile(widget.photo.downloadPath(ref));
    await Share.shareXFiles([
      XFile(
        file.path,
      ),
    ]);
    await file.delete();
  }
}
