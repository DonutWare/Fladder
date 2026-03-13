import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/bootstrap/app_bootstrap.dart';
import 'package:fladder/bootstrap/platform/platform_app_wrapper.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/localization_delegates.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/crash_log_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/application_info.dart';
import 'package:fladder/util/deep_link_helper.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/widgets/media_query_scaler.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  final bootstrap = await bootstrapApplication(args);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => bootstrap.sharedPreferences),
        applicationInfoProvider.overrideWith((ref) => bootstrap.applicationInfo),
        crashLogProvider.overrideWith((ref) => bootstrap.crashProvider),
        argumentsStateProvider.overrideWith((ref) => bootstrap.argumentsModel),
        syncProvider.overrideWith((ref) => SyncNotifier(ref, bootstrap.applicationDirectory)),
      ],
      child: AdaptiveLayoutBuilder(
        child: (context) => const Main(),
      ),
    ),
  );
}

class Main extends ConsumerWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformAppWrapper(
      builder: (context, autoRouter) {
        return _FladderApp(
          autoRouter: autoRouter,
        );
      },
    );
  }
}

class _FladderApp extends ConsumerWidget {
  const _FladderApp({
    required this.autoRouter,
  });

  final AutoRouter autoRouter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    final themeMode = ref.watch(clientSettingsProvider.select((value) => value.themeMode));
    final themeColor = ref.watch(clientSettingsProvider.select((value) => value.themeColor));
    final amoledBlack = ref.watch(clientSettingsProvider.select((value) => value.amoledBlack));
    final mouseDrag = ref.watch(clientSettingsProvider.select((value) => value.mouseDragSupport));
    final schemeVariant = ref.watch(clientSettingsProvider.select((value) => value.schemeVariant));
    final language = ref.watch(clientSettingsProvider
        .select((value) => value.selectedLocale ?? WidgetsBinding.instance.platformDispatcher.locale));
    final scrollBehaviour = const MaterialScrollBehavior();
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final baseLightTheme = themeColor == null
            ? FladderTheme.theme(lightDynamic ?? FladderTheme.defaultScheme(Brightness.light), schemeVariant)
            : FladderTheme.theme(themeColor.schemeLight, schemeVariant);
        final baseDarkTheme = (themeColor == null
            ? FladderTheme.theme(darkDynamic ?? FladderTheme.defaultScheme(Brightness.dark), schemeVariant)
            : FladderTheme.theme(themeColor.schemeDark, schemeVariant));

        // Apply Chinese font for non-Linux platforms (Windows, macOS, Android, iOS)
        final lightTheme = isLinux
            ? baseLightTheme
            : FladderTheme.applyChineseFontToTheme(
                lightTheme: baseLightTheme,
                darkTheme: baseDarkTheme,
              );
        final darkTheme = isLinux ? baseDarkTheme : FladderTheme.applyChineseFontToDarkTheme(darkTheme: baseDarkTheme);

        final amoledOverwrite = amoledBlack ? Colors.black : null;
        return ThemesData(
          light: lightTheme,
          dark: darkTheme,
          child: MaterialApp.router(
            onGenerateTitle: (context) => ref.watch(currentTitleProvider),
            theme: lightTheme,
            scrollBehavior: scrollBehaviour.copyWith(
              dragDevices: {
                ...scrollBehaviour.dragDevices,
                mouseDrag ? PointerDeviceKind.mouse : null,
              }.nonNulls.toSet(),
            ),
            localizationsDelegates: FladderLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: language,
            localeResolutionCallback: (locale, supportedLocales) {
              const fallback = Locale('en');
              if (locale == null) return fallback;
              if (supportedLocales.contains(locale)) {
                return locale;
              }
              final matchByLanguage = supportedLocales.firstWhere(
                (l) => l.languageCode == locale.languageCode,
                orElse: () => fallback,
              );

              return matchByLanguage;
            },
            builder: (context, child) => MediaQueryScaler(
              child: LocalizationContextWrapper(
                child: child ?? Container(),
                currentLocale: language,
              ),
              enable: ref.read(argumentsStateProvider).leanBackMode,
            ),
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme.copyWith(
              scaffoldBackgroundColor: amoledOverwrite,
              cardColor: amoledOverwrite,
              canvasColor: amoledOverwrite,
              colorScheme: darkTheme.colorScheme.copyWith(
                surface: amoledOverwrite,
                surfaceContainerHighest: amoledOverwrite,
                surfaceContainerLow: amoledOverwrite,
              ),
            ),
            themeMode: themeMode,
            routerConfig: autoRouter.config(
              deepLinkBuilder: (deepLink) => deepLinkBuilder(deepLink.uri),
            ),
          ),
        );
      },
    );
  }
}

final currentTitleProvider = StateProvider<String>((ref) => "Fladder");
