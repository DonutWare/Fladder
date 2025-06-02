import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/widget/markdown.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/update_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/theme_extensions.dart';
import 'package:fladder/util/update_checker.dart';

class SettingsUpdateInformation extends ConsumerStatefulWidget {
  const SettingsUpdateInformation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsUpdateInformationState();
}

class _SettingsUpdateInformationState extends ConsumerState<SettingsUpdateInformation> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) {
      final latestRelease = ref.read(updateProvider.select((value) => value.latestRelease));
      if (latestRelease == null) return;
      final lastViewedUpdate = ref.read(clientSettingsProvider.select((value) => value.lastViewedUpdate));
      if (lastViewedUpdate != latestRelease.version) {
        ref
            .read(clientSettingsProvider.notifier)
            .update((value) => value.copyWith(lastViewedUpdate: latestRelease.version));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final updates = ref.watch(updateProvider);
    final latestRelease = updates.latestRelease;
    final otherReleases = updates.lastRelease;
    final checkForUpdate = ref.watch(clientSettingsProvider.select((value) => value.checkForUpdates));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Divider(),
          SettingsListTile(
            label: Text(context.localized.latestReleases),
            subLabel: Text(context.localized.autoCheckForUpdates),
            onTap: () => ref
                .read(clientSettingsProvider.notifier)
                .update((value) => value.copyWith(checkForUpdates: !checkForUpdate)),
            trailing: Switch(
              value: checkForUpdate,
              onChanged: (value) => ref
                  .read(clientSettingsProvider.notifier)
                  .update((value) => value.copyWith(checkForUpdates: !checkForUpdate)),
            ),
          ),
          if (latestRelease != null)
            UpdateInformation(
              releaseInfo: latestRelease,
              expanded: true,
            ),
          ...otherReleases.where((element) => element != latestRelease).map(
                (value) => UpdateInformation(releaseInfo: value),
              ),
        ],
      ),
    );
  }
}

class UpdateInformation extends StatelessWidget {
  final ReleaseInfo releaseInfo;
  final bool expanded;
  const UpdateInformation({
    required this.releaseInfo,
    this.expanded = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor:
          releaseInfo.isNewerThanCurrent ? context.colors.primaryContainer : context.colors.surfaceContainer,
      collapsedBackgroundColor: releaseInfo.isNewerThanCurrent ? context.colors.primaryContainer : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(releaseInfo.version),
      initiallyExpanded: expanded,
      childrenPadding: const EdgeInsets.all(16),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: MarkdownWidget(
              data: releaseInfo.changelog,
              shrinkWrap: true,
            ),
          ),
        ),
        ...releaseInfo.preferredDownloads.entries.map(
          (entry) {
            return FilledButton(
              onPressed: () => launchUrl(context, entry.value),
              child: Text(
                entry.key.prettifyKey(),
              ),
            );
          },
        ),
        ...releaseInfo.otherDownloads.entries.map(
          (entry) {
            return ElevatedButton(
              onPressed: () => launchUrl(context, entry.value),
              child: Text(
                entry.key.prettifyKey(),
              ),
            );
          },
        )
      ].addInBetween(const SizedBox(height: 12)),
    );
  }
}
