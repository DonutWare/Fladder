import 'package:extended_image/extended_image.dart';
import 'package:fladder/models/book_model.dart';
import 'package:fladder/providers/book_viewer_provider.dart';
import 'package:fladder/providers/items/book_details_provider.dart';
import 'package:fladder/providers/settings/book_viewer_settings_provider.dart';
import 'package:fladder/screens/book_viewer/book_viewer_controls.dart';
import 'package:fladder/screens/book_viewer/book_viewer_reader.dart'
    if (dart.library.js_interop) 'package:fladder/screens/book_viewer/book_viewer_reader_web.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/util/throttler.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

Future<void> openBookViewer(
  BuildContext context,
  StateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel> provider, {
  int? initialPage,
}) async {
  return showDialog(
    context: context,
    useRootNavigator: true,
    useSafeArea: false,
    builder: (context) => Dialog.fullscreen(
      child: BookViewerScreen(
        initialPage: initialPage ?? 0,
        provider: provider,
      ),
    ),
  );
}

class BookViewerScreen extends ConsumerStatefulWidget {
  final int initialPage;
  final StateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel> provider;
  const BookViewerScreen({required this.provider, this.initialPage = 0, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookViewerScreenState();
}

class _BookViewerScreenState extends ConsumerState<BookViewerScreen> {
  final Throttler throttler = Throttler(duration: const Duration(milliseconds: 130));
  final Duration pageAnimDuration = const Duration(milliseconds: 125);
  final Curve pageAnimCurve = Curves.easeInCubic;
  late final ExtendedPageController extendedController = ExtendedPageController(initialPage: widget.initialPage);
  late final BookViewController viewController = BookViewController();
  bool outOfRange = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(bookViewerSettingsProvider.notifier).setSavedBrightness());
  }

  late double lastScale = switch (ref.read(bookViewerSettingsProvider).initZoomState) {
    InitZoomState.contained => 1.0,
    InitZoomState.covered => 1.75,
  };

  late double lastPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final bookViewerDetails = ref.watch(bookViewerProvider);
    final loading = bookViewerDetails.loading;
    final pages = bookViewerDetails.pages;
    final book = bookViewerDetails.book;
    final bookViewSettings = ref.watch(bookViewerSettingsProvider);
    ref.listen(
      bookViewerProvider.select((value) => value.loading),
      (previous, next) {
        if (previous == true && next == false) {
          ref.read(bookViewerProvider.notifier).updatePlayback((widget.initialPage.toDouble()).toInt());
        }
      },
    );
    return Theme(
      data: ThemesData.of(context).dark,
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) async {
          await ref.read(bookViewerProvider.notifier).stopPlayback();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (!loading)
                ExtendedImageGesturePageView.builder(
                  itemCount: pages.length + 2,
                  controller: extendedController,
                  canScrollPage: (gestureDetails) {
                    return bookViewSettings.disableScrollOnZoom
                        ? gestureDetails != null
                            ? !(gestureDetails.totalScale! > 1.0)
                            : true
                        : true;
                  },
                  onPageChanged: (value) {
                    final newRange = pages.length + 1 == value || value == 0;
                    if (outOfRange != newRange) {
                      viewController.toggleControls(value: newRange);
                      outOfRange = newRange;
                    }
                    ref.read(bookViewerProvider.notifier).updatePlayback(value);
                  },
                  reverse: bookViewSettings.readDirection == ReadDirection.rightToLeft,
                  itemBuilder: (context, index) {
                    if (pages.length + 1 == index || index == 0) {
                      final atEnd = index >= pages.length;
                      final details = ref.read(widget.provider);
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: bookViewSettings.readDirection != ReadDirection.leftToRight
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (atEnd) ...{
                                Flexible(
                                  child: Text(
                                    "End: \n${book?.name}",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                if (details.nextChapter(bookViewerDetails.book) != null) ...{
                                  const SizedBox(height: 32),
                                  Flexible(
                                    child: Text(
                                      "Next: ",
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                  Flexible(
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                                      onPressed: () async =>
                                          await loadNextBook(details.nextChapter(bookViewerDetails.book)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.keyboard_arrow_left_rounded),
                                          Text(
                                            details.nextChapter(bookViewerDetails.book)!.name,
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.onPrimary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                } else ...{
                                  const SizedBox(height: 32),
                                  const Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.info_rounded),
                                          SizedBox(width: 16),
                                          Text("No next chapter"),
                                        ],
                                      ),
                                    ),
                                  )
                                }
                              } else ...{
                                Flexible(
                                  child: Text(
                                    "Start: \n${book?.name}",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                if (details.previousChapter(bookViewerDetails.book) != null) ...{
                                  const SizedBox(height: 32),
                                  Flexible(
                                    child: Text(
                                      "Previous:",
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                  Flexible(
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                                      onPressed: () async =>
                                          await loadNextBook(details.previousChapter(bookViewerDetails.book)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            details.previousChapter(bookViewerDetails.book)!.name,
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.onPrimary),
                                          ),
                                          const Icon(Icons.keyboard_arrow_right_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                } else ...{
                                  const SizedBox(height: 32),
                                  const Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.info_rounded),
                                          SizedBox(width: 16),
                                          Text("First chapter"),
                                        ],
                                      ),
                                    ),
                                  )
                                }
                              },
                            ],
                          ),
                        ),
                      );
                    } else {
                      return BookViewerReader(
                        index: index,
                        pages: pages,
                        bookViewSettings: bookViewSettings,
                        previousPage: previousPage,
                        nextPage: nextPage,
                        viewController: viewController,
                        lastScale: lastScale,
                        newScale: (value) => lastScale = value,
                      );
                    }
                  },
                ),
              BookViewerControls(
                provider: widget.provider,
                viewController: viewController,
                controller: extendedController,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> nextPage() async =>
      throttler.run(() async => await extendedController.nextPage(duration: pageAnimDuration, curve: pageAnimCurve));

  Future<void> previousPage() async => throttler
      .run(() async => await extendedController.previousPage(duration: pageAnimDuration, curve: pageAnimCurve));

  Future<void> loadNextBook(BookModel? book) async {
    await ref.read(bookViewerProvider.notifier).fetchBook(book);
    extendedController.jumpToPage(0);
    return;
  }
}
