import 'package:universal_html/html.dart' as html;

Future<void> downloadFile(String url) async {
  try {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  } catch (e) {
    print('Download error: $e');
  }
}
