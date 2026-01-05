import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/funding_model.dart' as funding;
import 'package:fladder/screens/crash_screen/crash_screen.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_update_information.dart';
import 'package:fladder/screens/shared/fladder_icon.dart';
import 'package:fladder/screens/shared/fladder_logo.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/util/application_info.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

class _Socials {
  final String label;
  final String url;
  final IconData icon;

  const _Socials(this.label, this.url, this.icon);
}

const socials = [
  _Socials(
    'Github',
    'https://github.com/DonutWare/Fladder',
    FontAwesomeIcons.githubAlt,
  ),
  _Socials(
    'Weblate',
    'https://hosted.weblate.org/projects/fladder/',
    IconsaxPlusLinear.global,
  ),
];

@RoutePage()
class AboutSettingsPage extends ConsumerWidget {
  const AboutSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationInfo = ref.watch(applicationInfoProvider);

    return SettingsScaffold(
      label: "",
      items: [
        const FladderLogo(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.localized.aboutVersion(applicationInfo.versionAndPlatform)),
            Text(context.localized.aboutBuild(applicationInfo.buildNumber)),
            const SizedBox(height: 16),
            Text(context.localized.aboutCreatedBy),
          ],
        ),
        const FractionallySizedBox(
          widthFactor: 0.25,
          child: Divider(
            indent: 16,
            endIndent: 16,
          ),
        ),
        const _SocialsSection(),
        const _SponsorsSection(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () => showLicensePage(
                context: context,
                applicationIcon: const FladderIcon(size: 55),
                applicationVersion: applicationInfo.versionPlatformBuild,
                applicationLegalese: "DonutWare",
                useRootNavigator: true,
              ),
              child: Text(context.localized.aboutLicenses),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const CrashScreen(),
              ),
              child: Text(context.localized.errorLogs),
            )
          ],
        ),
        const SettingsUpdateInformation(),
      ].addInBetween(const SizedBox(height: 16)),
    );
  }
}

class _SocialsSection extends StatelessWidget {
  const _SocialsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.localized.aboutSocials,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: socials
              .map(
                (e) => IconButton.filledTonal(
                  onPressed: () => launchUrl(context, e.url),
                  icon: Column(
                    children: [
                      Icon(e.icon),
                      Text(e.label),
                    ],
                  ),
                ),
              )
              .toList()
              .addInBetween(const SizedBox(width: 16)),
        )
      ],
    );
  }
}

class _SponsorsSection extends StatelessWidget {
  const _SponsorsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FractionallySizedBox(
          widthFactor: 0.25,
          child: Divider(
            indent: 16,
            endIndent: 16,
          ),
        ),
        Column(
          spacing: 6,
          children: [
            Text(
              context.localized.sponsor,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Text(
                context.localized.sponsorMessage,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: funding.sponsors
                  .map(
                    (sponsor) => Tooltip(
                      message: sponsor.platform,
                      child: IconButton.filledTonal(
                        onPressed: () => launchUrl(context, sponsor.url),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          minimumSize: const Size(64, 64),
                          backgroundColor: sponsor.color?.withAlpha(75),
                          side: BorderSide(
                            color: sponsor.color?.withAlpha(150) ?? Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        icon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              sponsor.icon,
                              color: sponsor.color,
                            ),
                            Flexible(
                              child: Text(
                                sponsor.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
