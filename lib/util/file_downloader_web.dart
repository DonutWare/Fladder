import 'package:web/web.dart' as web;

Future<void> downloadFile(String url) async {
  try {
    final anchorElement = web.HTMLAnchorElement()
      ..href = url
      ..download = url;
    anchorElement.click();
  } catch (e) {
    print('Download error: $e');
  }
}
