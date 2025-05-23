import 'package:fladder/models/book_model.dart';
import 'package:fladder/providers/book_viewer_provider.dart';
import 'package:fladder/providers/items/book_details_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/widgets/shared/modal_side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showBookViewerChapters(
    BuildContext context, AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel> provider,
    {Function(BookModel book)? onPressed}) async {
  if (AdaptiveLayout.of(context).isDesktop) {
    return showModalSideSheet(context,
        content: BookViewerChapters(
          provider: provider,
          onPressed: onPressed,
        ));
  } else {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => BookViewerChapters(
        provider: provider,
        onPressed: onPressed,
      ),
    );
  }
}

class BookViewerChapters extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel> provider;
  final Function(BookModel book)? onPressed;
  const BookViewerChapters({required this.provider, this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBook = ref.watch(bookViewerProvider.select((value) => value.book));
    final chapters = ref.watch(provider.select((value) => value.chapters));

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Chapters",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const Divider(),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: [
              ...chapters.map(
                (book) {
                  final bool current = currentBook == book;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Card(
                        elevation: current ? 10 : 3,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 80),
                          alignment: Alignment.center,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            leading: AspectRatio(
                              aspectRatio: 1,
                              child: Card(
                                child: FladderImage(
                                  image: book.getPosters?.primary,
                                ),
                              ),
                            ),
                            title: Text(book.name),
                            trailing: current
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    child: Icon(
                                      Icons.visibility_rounded,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  )
                                : FilledButton(
                                    onPressed: () => onPressed?.call(book),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Icon(Icons.read_more_rounded),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
