import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:extended_image/extended_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/providers/book_viewer_provider.dart';
import 'package:fladder/providers/items/book_details_provider.dart';
import 'package:fladder/providers/settings/book_viewer_settings_provider.dart';
import 'package:fladder/screens/book_viewer/book_viewer_chapters.dart';
import 'package:fladder/screens/book_viewer/book_viewer_settings.dart';
import 'package:fladder/screens/shared/default_title_bar.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/throttler.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';

class BookViewController {
  bool controlsVisible = true;

  late ValueNotifier<bool> visibilityChanged = ValueNotifier(controlsVisible);

  void toggleControls({bool? value}) {
    controlsVisible = value ?? !controlsVisible;
    visibilityChanged.value = controlsVisible;
  }
}

class BookViewerControls extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel> provider;
  final BookViewController viewController;

  final ExtendedPageController controller;
  const BookViewerControls({
    required this.provider,
    required this.controller,
    required this.viewController,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookViewerControlsState();
}

class _BookViewerControlsState extends ConsumerState<BookViewerControls> {
  final Throttler throttler = Throttler(duration: const Duration(milliseconds: 130));
  final Duration pageAnimDuration = const Duration(milliseconds: 125);
  final Curve pageAnimCurve = Curves.easeInCubic;
  late final BookViewController viewController = widget.viewController;

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

  bool showControls = true;
  void toggleControls({bool? value}) {
    setState(() {
      showControls = value ?? !showControls;
    });
    SystemChrome.setEnabledSystemUIMode(!showControls ? SystemUiMode.leanBack : SystemUiMode.edgeToEdge, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    viewController.visibilityChanged.addListener(() {
      toggleControls(value: viewController.controlsVisible);
    });
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    ScreenBrightness().resetScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
    super.dispose();
  }

  bool _onKey(KeyEvent value) {
    final bookViewerSettings = ref.read(bookViewerSettingsProvider);
    if (value is KeyRepeatEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft || value.logicalKey == LogicalKeyboardKey.keyA) {
        bookViewerSettings.readDirection == ReadDirection.leftToRight ? previousPage() : nextPage();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowRight || value.logicalKey == LogicalKeyboardKey.keyD) {
        bookViewerSettings.readDirection == ReadDirection.leftToRight ? nextPage() : previousPage();
        return true;
      }
    }
    if (value is KeyDownEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft || value.logicalKey == LogicalKeyboardKey.keyA) {
        bookViewerSettings.readDirection == ReadDirection.leftToRight ? previousPage() : nextPage();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowRight || value.logicalKey == LogicalKeyboardKey.keyD) {
        bookViewerSettings.readDirection == ReadDirection.leftToRight ? nextPage() : previousPage();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.keyF) {
        toggleControls();
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(widget.provider);
    final bookViewerSettings = ref.watch(bookViewerSettingsProvider);
    final chapters = details.chapters;
    final bookViewerDetails = ref.watch(bookViewerProvider);
    final currentPage = bookViewerDetails.currentPage;
    const overlayColor = Colors.black;
    final previousChapter = details.previousChapter(bookViewerDetails.book);
    final nextChapter = details.nextChapter(bookViewerDetails.book);

    return MediaQuery.removePadding(
      context: context,
      child: InputHandler(
        onKeyEvent: (node, event) => _onKey(event) ? KeyEventResult.handled : KeyEventResult.ignored,
        child: Stack(
          children: [
            IgnorePointer(
              ignoring: !showControls,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: showControls ? 1 : 0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            overlayColor.withOpacity(1),
                            overlayColor.withOpacity(0.65),
                            overlayColor.withOpacity(0),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: topPadding).copyWith(bottom: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (AdaptiveLayout.of(context).isDesktop)
                              const Flexible(
                                child: DefaultTitleBar(
                                  height: 50,
                                  brightness: Brightness.dark,
                                ),
                              ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const BackButton(),
                                const SizedBox(
                                  width: 16,
                                ),
                                Flexible(
                                  child: Text(
                                    bookViewerDetails.book?.name ?? "None",
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    if (!bookViewerDetails.loading) ...{
                      if (bookViewerDetails.book != null && bookViewerDetails.pages.isNotEmpty) ...{
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  overlayColor.withOpacity(0),
                                  overlayColor.withOpacity(0.65),
                                  overlayColor.withOpacity(1),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: bottomPadding).copyWith(top: 16, bottom: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Tooltip(
                                        message: bookViewerSettings.readDirection == ReadDirection.leftToRight
                                            ? previousChapter?.name != null
                                                ? "Load ${previousChapter?.name}"
                                                : ""
                                            : nextChapter?.name != null
                                                ? "Load ${nextChapter?.name}"
                                                : "",
                                        child: IconButton.filled(
                                          onPressed: bookViewerSettings.readDirection == ReadDirection.leftToRight
                                              ? previousChapter != null
                                                  ? () async => await loadNextBook(previousChapter)
                                                  : null
                                              : nextChapter != null
                                                  ? () async => await loadNextBook(nextChapter)
                                                  : null,
                                          icon: const Icon(IconsaxOutline.backward),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(60),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            child: Row(
                                              children: [
                                                if (bookViewerSettings.readDirection == ReadDirection.leftToRight)
                                                  ...controls(currentPage, bookViewerSettings, bookViewerDetails)
                                                else
                                                  ...controls(currentPage, bookViewerSettings, bookViewerDetails)
                                                      .reversed,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Tooltip(
                                        message: bookViewerSettings.readDirection == ReadDirection.leftToRight
                                            ? nextChapter?.name != null
                                                ? "Load ${nextChapter?.name}"
                                                : ""
                                            : previousChapter?.name != null
                                                ? "Load ${previousChapter?.name}"
                                                : "",
                                        child: IconButton.filled(
                                          onPressed: bookViewerSettings.readDirection == ReadDirection.leftToRight
                                              ? nextChapter != null
                                                  ? () async => await loadNextBook(nextChapter)
                                                  : null
                                              : previousChapter != null
                                                  ? () async => await loadNextBook(previousChapter)
                                                  : null,
                                          icon: const Icon(IconsaxOutline.forward),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Transform.flip(
                                        flipX: bookViewerSettings.readDirection == ReadDirection.rightToLeft,
                                        child: IconButton(
                                            onPressed: () => widget.controller
                                                .animateToPage(1, duration: pageAnimDuration, curve: pageAnimCurve),
                                            icon: const Icon(IconsaxOutline.backward)),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showBookViewerSettings(context);
                                        },
                                        icon: const Icon(IconsaxOutline.setting_2),
                                      ),
                                      IconButton(
                                        onPressed: chapters.length > 1
                                            ? () {
                                                showBookViewerChapters(
                                                  context,
                                                  widget.provider,
                                                  onPressed: (book) async {
                                                    Navigator.of(context).pop();
                                                    loadNextBook(book);
                                                  },
                                                );
                                              }
                                            : () => fladderSnackbar(context, title: "No other chapters"),
                                        icon: const Icon(IconsaxOutline.bookmark_2),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      } else
                        const Center(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.menu_book_rounded),
                                  SizedBox(width: 8),
                                  Text("Unable to load book"),
                                ],
                              ),
                            ),
                          ),
                        )
                    },
                  ],
                ),
              ),
            ),
            if (bookViewerDetails.loading)
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (bookViewerDetails.book != null) ...{
                          Flexible(
                            child: Text("Loading ${bookViewerDetails.book?.name}",
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(width: 16),
                        },
                        const CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  List<Widget> controls(int currentPage, BookViewerSettingsModel bookViewerSettings, BookViewerModel details) {
    final clampedCurrentPage = currentPage.clamp(1, details.pages.length);
    return [
      const SizedBox(width: 6),
      Text(
        (currentPage.clamp(1, details.pages.length)).toInt().toString().padLeft(1).padRight(1),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Transform.flip(
            flipX: bookViewerSettings.readDirection == ReadDirection.rightToLeft,
            child: SizedBox(
              height: 40,
              child: FladderSlider(
                value: clampedCurrentPage.toDouble(),
                divisions: details.pages.length - 1,
                min: 1,
                max: details.pages.length.toDouble(),
                onChangeEnd: (value) => widget.controller.jumpToPage(value.toInt()),
                onChanged: (value) => ref.read(bookViewerProvider.notifier).setPage(value),
              ),
            ),
          ),
        ),
      ),
      Text(
        details.pages.length.toString().padLeft(1).padRight(1),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ];
  }

  Future<void> loadNextBook(BookModel? book) async {
    await ref.read(bookViewerProvider.notifier).fetchBook(book);
    widget.controller.jumpToPage(0);
    return;
  }

  Future<void> nextPage() async =>
      throttler.run(() async => await widget.controller.nextPage(duration: pageAnimDuration, curve: pageAnimCurve));

  Future<void> previousPage() async =>
      throttler.run(() async => await widget.controller.previousPage(duration: pageAnimDuration, curve: pageAnimCurve));
}
