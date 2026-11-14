import 'package:fladder/providers/settings/book_viewer_settings_provider.dart';
import 'package:fladder/screens/book_viewer/book_viewer_controls.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Container(
      child: const Text("Web not supported."),
    );
  }
}
