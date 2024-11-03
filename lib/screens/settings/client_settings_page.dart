import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/custom_color_themes.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/option_dialogue.dart';
import 'package:fladder/util/simple_duration_picker.dart';
import 'package:fladder/util/size_formatting.dart';
import 'package:fladder/util/theme_mode_extension.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';

@RoutePage()
class ClientSettingsPage extends ConsumerStatefulWidget {
  const ClientSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientSettingsPageState();
}

class _ClientSettingsPageState extends ConsumerState<ClientSettingsPage> {
  late final nextUpDaysEditor = TextEditingController(
      text: ref.read(clientSettingsProvider.select((value) => value.nextUpDateCutoff?.inDays ?? 14)).toString());

  late final libraryPageSizeController = TextEditingController(
      text: ref.read(clientSettingsProvider.select((value) => value.libraryPageSize))?.toString() ?? "");

  @override
  Widget build(BuildContext context) {
    final clientSettings = ref.watch(clientSettingsProvider);
    final showBackground = AdaptiveLayout.of(context).layout != LayoutState.phone &&
        AdaptiveLayout.of(context).size != ScreenLayout.single;
    final currentFolder = ref.watch(syncProvider.notifier).savePath;
    Locale currentLocale = WidgetsBinding.instance.platformDispatcher.locale;

    final canSync = ref.watch(userProvider.select((value) => value?.canDownload ?? false));
    return Card(
      elevation: showBackground ? 2 : 0,
      child: SettingsScaffold(
        label: "Fladder",
        items: [
          if (canSync && !kIsWeb) ...[
            SettingsLabelDivider(label: context.localized.downloadsTitle),
            if (AdaptiveLayout.of(context).isDesktop) ...[
              SettingsListTile(
                label: Text(context.localized.downloadsPath),
                subLabel: Text(currentFolder ?? "-"),
                onTap: currentFolder != null
                    ? () async => await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(context.localized.pathEditTitle),
                            content: Text(context.localized.pathEditDesc),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
                                      dialogTitle: context.localized.pathEditSelect, initialDirectory: currentFolder);
                                  if (selectedDirectory != null) {
                                    ref.read(clientSettingsProvider.notifier).setSyncPath(selectedDirectory);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text(context.localized.change),
                              )
                            ],
                          ),
                        )
                    : () async {
                        String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
                            dialogTitle: context.localized.pathEditSelect, initialDirectory: currentFolder);
                        if (selectedDirectory != null) {
                          ref.read(clientSettingsProvider.notifier).setSyncPath(selectedDirectory);
                        }
                      },
                trailing: currentFolder?.isNotEmpty == true
                    ? IconButton(
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () async => await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(context.localized.pathClearTitle),
                            content: Text(context.localized.pathEditDesc),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  ref.read(clientSettingsProvider.notifier).setSyncPath(null);
                                  Navigator.of(context).pop();
                                },
                                child: Text(context.localized.clear),
                              )
                            ],
                          ),
                        ),
                        icon: const Icon(IconsaxOutline.folder_minus),
                      )
                    : null,
              ),
            ],
            FutureBuilder(
              future: ref.watch(syncProvider.notifier).directorySize,
              builder: (context, snapshot) {
                final data = snapshot.data ?? 0;
                return SettingsListTile(
                  label: Text(context.localized.downloadsSyncedData),
                  subLabel: Text(data.byteFormat ?? ""),
                  trailing: FilledButton(
                    onPressed: () {
                      showDefaultAlertDialog(
                        context,
                        context.localized.downloadsClearTitle,
                        context.localized.downloadsClearDesc,
                        (context) async {
                          await ref.read(syncProvider.notifier).clear();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        context.localized.clear,
                        (context) => Navigator.of(context).pop(),
                        context.localized.cancel,
                      );
                    },
                    child: Text(context.localized.clear),
                  ),
                );
              },
            ),
            SettingsListTile(
              label: Text(context.localized.clientSettingsRequireWifiTitle),
              subLabel: Text(context.localized.clientSettingsRequireWifiDesc),
              onTap: () => ref.read(clientSettingsProvider.notifier).setRequireWifi(!clientSettings.requireWifi),
              trailing: Switch(
                value: clientSettings.requireWifi,
                onChanged: (value) => ref.read(clientSettingsProvider.notifier).setRequireWifi(value),
              ),
            ),
            const Divider(),
          ],
          SettingsLabelDivider(label: context.localized.lockscreen),
          SettingsListTile(
            label: Text(context.localized.timeOut),
            subLabel: Text(timePickerString(context, clientSettings.timeOut)),
            onTap: () async {
              final timePicker = await showSimpleDurationPicker(
                context: context,
                initialValue: clientSettings.timeOut ?? const Duration(),
              );

              ref.read(clientSettingsProvider.notifier).setTimeOut(timePicker != null
                  ? Duration(minutes: timePicker.inMinutes, seconds: timePicker.inSeconds % 60)
                  : null);
            },
          ),
          const Divider(),
          SettingsLabelDivider(label: context.localized.dashboard),
          SettingsListTile(
            label: Text(context.localized.settingsHomeBannerTitle),
            subLabel: Text(context.localized.settingsHomeBannerDescription),
            trailing: EnumBox(
              current: ref.watch(
                homeSettingsProvider.select(
                  (value) => value.homeBanner.label(context),
                ),
              ),
              itemBuilder: (context) => HomeBanner.values
                  .map(
                    (entry) => PopupMenuItem(
                      value: entry,
                      child: Text(entry.label(context)),
                      onTap: () => ref
                          .read(homeSettingsProvider.notifier)
                          .update((context) => context.copyWith(homeBanner: entry)),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (ref.watch(homeSettingsProvider.select((value) => value.homeBanner)) != HomeBanner.hide)
            SettingsListTile(
              label: Text(context.localized.settingsHomeBannerInformationTitle),
              subLabel: Text(context.localized.settingsHomeBannerInformationDesc),
              trailing: EnumBox(
                current: ref.watch(
                  homeSettingsProvider.select((value) => value.carouselSettings.label(context)),
                ),
                itemBuilder: (context) => HomeCarouselSettings.values
                    .map(
                      (entry) => PopupMenuItem(
                        value: entry,
                        child: Text(entry.label(context)),
                        onTap: () => ref
                            .read(homeSettingsProvider.notifier)
                            .update((context) => context.copyWith(carouselSettings: entry)),
                      ),
                    )
                    .toList(),
              ),
            ),
          SettingsListTile(
            label: Text(context.localized.settingsHomeNextUpTitle),
            subLabel: Text(context.localized.settingsHomeNextUpDesc),
            trailing: EnumBox(
              current: ref.watch(
                homeSettingsProvider.select(
                  (value) => value.nextUp.label(context),
                ),
              ),
              itemBuilder: (context) => HomeNextUp.values
                  .map(
                    (entry) => PopupMenuItem(
                      value: entry,
                      child: Text(entry.label(context)),
                      onTap: () =>
                          ref.read(homeSettingsProvider.notifier).update((context) => context.copyWith(nextUp: entry)),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(),
          SettingsLabelDivider(label: context.localized.settingsVisual),
          SettingsListTile(
            label: Text(context.localized.displayLanguage),
            trailing: Localizations.override(
              context: context,
              locale: ref.watch(
                clientSettingsProvider.select(
                  (value) => (value.selectedLocale ?? currentLocale),
                ),
              ),
              child: Builder(builder: (context) {
                return EnumBox(
                  current: context.localized.nativeName,
                  itemBuilder: (context) {
                    return [
                      ...AppLocalizations.supportedLocales.map(
                        (entry) => PopupMenuItem(
                          value: entry,
                          child: Localizations.override(
                            context: context,
                            locale: entry,
                            child: Builder(builder: (context) {
                              return Text(
                                context.localized.nativeName,
                              );
                            }),
                          ),
                          onTap: () => ref
                              .read(clientSettingsProvider.notifier)
                              .update((state) => state.copyWith(selectedLocale: entry)),
                        ),
                      )
                    ];
                  },
                );
              }),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.settingsBlurredPlaceholderTitle),
            subLabel: Text(context.localized.settingsBlurredPlaceholderDesc),
            onTap: () =>
                ref.read(clientSettingsProvider.notifier).setBlurPlaceholders(!clientSettings.blurPlaceHolders),
            trailing: Switch(
              value: clientSettings.blurPlaceHolders,
              onChanged: (value) => ref.read(clientSettingsProvider.notifier).setBlurPlaceholders(value),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.settingsBlurEpisodesTitle),
            subLabel: Text(context.localized.settingsBlurEpisodesDesc),
            onTap: () =>
                ref.read(clientSettingsProvider.notifier).setBlurEpisodes(!clientSettings.blurUpcomingEpisodes),
            trailing: Switch(
              value: clientSettings.blurUpcomingEpisodes,
              onChanged: (value) => ref.read(clientSettingsProvider.notifier).setBlurEpisodes(value),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.settingsEnableOsMediaControls),
            onTap: () => ref.read(clientSettingsProvider.notifier).setMediaKeys(!clientSettings.enableMediaKeys),
            trailing: Switch(
              value: clientSettings.enableMediaKeys,
              onChanged: (value) => ref.read(clientSettingsProvider.notifier).setMediaKeys(value),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.settingsNextUpCutoffDays),
            trailing: SizedBox(
                width: 100,
                child: IntInputField(
                  suffix: context.localized.days,
                  controller: nextUpDaysEditor,
                  onSubmitted: (value) {
                    if (value != null) {
                      ref.read(clientSettingsProvider.notifier).update((current) => current.copyWith(
                            nextUpDateCutoff: Duration(days: value),
                          ));
                    }
                  },
                )),
          ),
          SettingsListTile(
            label: Text(context.localized.libraryPageSizeTitle),
            subLabel: Text(context.localized.libraryPageSizeDesc),
            trailing: SizedBox(
                width: 100,
                child: IntInputField(
                  controller: libraryPageSizeController,
                  placeHolder: "500",
                  onSubmitted: (value) => ref.read(clientSettingsProvider.notifier).update(
                        (current) => current.copyWith(libraryPageSize: value),
                      ),
                )),
          ),
          SettingsListTile(
            label: Text(AdaptiveLayout.of(context).isDesktop
                ? context.localized.settingsShowScaleSlider
                : context.localized.settingsPosterPinch),
            onTap: () => ref.read(clientSettingsProvider.notifier).update(
                  (current) => current.copyWith(pinchPosterZoom: !current.pinchPosterZoom),
                ),
            trailing: Switch(
              value: clientSettings.pinchPosterZoom,
              onChanged: (value) => ref.read(clientSettingsProvider.notifier).update(
                    (current) => current.copyWith(pinchPosterZoom: value),
                  ),
            ),
          ),
          Column(
            children: [
              SettingsListTile(
                label: Text(context.localized.settingsPosterSize),
                trailing: Text(
                  clientSettings.posterSize.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: FladderSlider(
                  min: 0.5,
                  max: 1.5,
                  value: clientSettings.posterSize,
                  divisions: 20,
                  onChanged: (value) => ref
                      .read(clientSettingsProvider.notifier)
                      .update((current) => current.copyWith(posterSize: value)),
                ),
              ),
              const Divider(),
            ],
          ),
          SettingsLabelDivider(label: context.localized.theme),
          SettingsListTile(
            label: Text(context.localized.mode),
            subLabel: Text(clientSettings.themeMode.label(context)),
            onTap: () => openOptionDialogue(
              context,
              label: "${context.localized.theme} ${context.localized.mode}",
              items: ThemeMode.values,
              itemBuilder: (type) => RadioListTile.adaptive(
                value: type,
                title: Text(type?.label(context) ?? context.localized.other),
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                groupValue: ref.read(clientSettingsProvider.select((value) => value.themeMode)),
                onChanged: (value) => ref.read(clientSettingsProvider.notifier).setThemeMode(value),
              ),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.color),
            subLabel: Text(clientSettings.themeColor?.name ?? context.localized.dynamicText),
            onTap: () => openOptionDialogue<ColorThemes>(
              context,
              isNullable: !kIsWeb,
              label: context.localized.themeColor,
              items: ColorThemes.values,
              itemBuilder: (type) => Consumer(
                builder: (context, ref, child) => ListTile(
                  title: Row(
                    children: [
                      Checkbox.adaptive(
                        value: type == ref.watch(clientSettingsProvider.select((value) => value.themeColor)),
                        onChanged: (value) => ref.read(clientSettingsProvider.notifier).setThemeColor(type),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          gradient: type == null
                              ? const SweepGradient(
                                  center: FractionalOffset.center,
                                  colors: <Color>[
                                    Color(0xFF4285F4), // blue
                                    Color(0xFF34A853), // green
                                    Color(0xFFFBBC05), // yellow
                                    Color(0xFFEA4335), // red
                                    Color(0xFF4285F4), // blue again to seamlessly transition to the start
                                  ],
                                  stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                                )
                              : null,
                          color: type?.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(type?.name ?? context.localized.dynamicText),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onTap: () => ref.read(clientSettingsProvider.notifier).setThemeColor(type),
                ),
              ),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.clientSettingsSchemeVariantTitle),
            subLabel: Text(clientSettings.schemeVariant.label(context)),
            onTap: () => openOptionDialogue<DynamicSchemeVariant>(
              context,
              isNullable: false,
              label: context.localized.themeColor,
              items: DynamicSchemeVariant.values,
              itemBuilder: (type) => Consumer(
                builder: (context, ref, child) => ListTile(
                  title: Row(
                    children: [
                      Checkbox.adaptive(
                        value: type == ref.watch(clientSettingsProvider.select((value) => value.schemeVariant)),
                        onChanged: (value) => ref.read(clientSettingsProvider.notifier).setSchemeVariant(type),
                      ),
                      const SizedBox(width: 8),
                      Text(type?.label(context) ?? ""),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onTap: () => ref.read(clientSettingsProvider.notifier).setSchemeVariant(type),
                ),
              ),
            ),
          ),
          SettingsListTile(
            label: Text(context.localized.amoledBlack),
            subLabel: Text(clientSettings.amoledBlack ? context.localized.enabled : context.localized.disabled),
            onTap: () => ref.read(clientSettingsProvider.notifier).setAmoledBlack(!clientSettings.amoledBlack),
            trailing: Switch(
              value: clientSettings.amoledBlack,
              onChanged: (value) => ref.read(clientSettingsProvider.notifier).setAmoledBlack(value),
            ),
          ),
          if (AdaptiveLayout.of(context).isDesktop) ...[
            const Divider(),
            SettingsLabelDivider(label: context.localized.controls),
            SettingsListTile(
              label: Text(context.localized.mouseDragSupport),
              subLabel: Text(clientSettings.mouseDragSupport ? context.localized.enabled : context.localized.disabled),
              onTap: () => ref
                  .read(clientSettingsProvider.notifier)
                  .update((current) => current.copyWith(mouseDragSupport: !clientSettings.mouseDragSupport)),
              trailing: Switch(
                value: clientSettings.mouseDragSupport,
                onChanged: (value) => ref.read(clientSettingsProvider.notifier).setAmoledBlack(value),
              ),
            ),
          ],
          const SizedBox(height: 64),
          SettingsListTile(
            label: Text(
              context.localized.clearAllSettings,
            ),
            contentColor: Theme.of(context).colorScheme.error,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.localized.clearAllSettingsQuestion,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.localized.unableToReverseAction,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilledButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(context.localized.cancel),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () async {
                                await ref.read(sharedPreferencesProvider).clear();
                                context.router.push(const LoginRoute());
                              },
                              child: Text(context.localized.clear),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
