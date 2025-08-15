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
      final mediaQuery = MediaQuery.of(context);
      final theme = Theme.of(context);
      await customtab.launchUrl(
        Uri.parse(link),
        customTabsOptions: customtab.CustomTabsOptions.partial(
          configuration: customtab.PartialCustomTabsConfiguration.adaptiveSheet(
            initialHeight: mediaQuery.size.height * 0.7,
            initialWidth: mediaQuery.size.width * 0.4,
            activitySideSheetMaximizationEnabled: true,
            activitySideSheetDecorationType: customtab.CustomTabsActivitySideSheetDecorationType.shadow,
            activitySideSheetRoundedCornersPosition: customtab.CustomTabsActivitySideSheetRoundedCornersPosition.top,
            cornerRadius: 16,
          ),
          colorSchemes: customtab.CustomTabsColorSchemes.defaults(
            toolbarColor: Theme.of(context).colorScheme.primary,
            navigationBarColor: Theme.of(context).colorScheme.primary,
          ),
          shareState: customtab.CustomTabsShareState.browserDefault,
          showTitle: true,
          browser: const customtab.CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,
          ),
        ),
        safariVCOptions: customtab.SafariViewControllerOptions.pageSheet(
          configuration: const customtab.SheetPresentationControllerConfiguration(
            detents: {
              customtab.SheetPresentationControllerDetent.large,
              customtab.SheetPresentationControllerDetent.medium,
            },
            prefersScrollingExpandsWhenScrolledToEdge: true,
            prefersGrabberVisible: true,
            prefersEdgeAttachedInCompactHeight: true,
          ),
          preferredBarTintColor: theme.colorScheme.surface,
          preferredControlTintColor: theme.colorScheme.onSurface,
          dismissButtonStyle: customtab.SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
