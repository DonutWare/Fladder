import 'package:flutter/material.dart';

import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as customtab;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart' as urilauncher;
import 'package:url_launcher/url_launcher_string.dart';

import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/sticky_header_text.dart';

class ExternalUrlsRow extends ConsumerWidget {
  final List<ExternalUrls>? urls;
  const ExternalUrlsRow({
    this.urls,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        StickyHeaderText(
          label: context.localized.external,
        ),
        Transform.translate(
          offset: const Offset(-12, 0),
          child: Wrap(
            children: urls
                    ?.map(
                      (url) => TextButton(
                        onPressed: () => launchUrl(context, url.url),
                        child: Text(url.name),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

Future<void> launchUrl(BuildContext context, String link) async {
  final Uri url = Uri.parse(link);

  if (AdaptiveLayout.of(context).isDesktop) {
    if (!await urilauncher.launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  } else {
    try {
      await customtab.launchUrl(
        Uri.parse(link),
        customTabsOptions: customtab.CustomTabsOptions(
          colorSchemes: customtab.CustomTabsColorSchemes.defaults(
            toolbarColor: Theme.of(context).primaryColor,
          ),
          urlBarHidingEnabled: true,
          shareState: customtab.CustomTabsShareState.browserDefault,
          showTitle: true,
        ),
        safariVCOptions: customtab.SafariViewControllerOptions(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: customtab.SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
