import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_window_utils/window_manipulator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtc_windows/smtc_windows.dart' if (dart.library.html) 'package:fladder/stubs/web/smtc_web.dart';
import 'package:universal_html/html.dart' as html;
import 'package:window_manager/window_manager.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/localization_delegates.dart';
import 'package:fladder/logic/application_menu.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/crash_log_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/router_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/routes/auto_router.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/src/application_menu.g.dart';
import 'package:fladder/src/video_player_helper.g.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/application_info.dart';
import 'package:fladder/util/fladder_config.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/macos_window_helpers.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/util/svg_utils.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/util/window_helper.dart';
import 'package:fladder/widgets/media_query_scaler.dart';

bool get _isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

bool nativeActivityStarted = false;

Future<Map<String, dynamic>> loadConfig() async {
  final configString = await rootBundle.loadString('config/config.json');
  return jsonDecode(configString);
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final crashProvider = CrashLogNotifier();

  await SvgUtils.preCacheSVGs();

  // Check if running on android TV
  final leanBackEnabled = !kIsWeb && Platform.isAndroid ? await NativeVideoActivity().isLeanBackEnabled() : false;

  if (defaultTargetPlatform == TargetPlatform.windows) {
    await SMTCWindows.initialize();
  }

  if (kIsWeb) {
    html.document.onContextMenu.listen((event) => event.preventDefault());
    final result = await loadConfig();
    FladderConfig.fromJson(result);
  }

  String windowArguments = "";

  if (!kIsWeb && Platform.isMacOS) {
    await WindowManipulator.initialize(enableWindowDelegate: true);
  }

  if (_isDesktop) {
    final windowController = await WindowController.fromCurrentEngine();
    windowArguments = windowController.arguments;
    final appMenu = ApplicationMenuImp();
    ApplicationMenu.setUp(appMenu);
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Directory applicationDirectory = Directory("");

  if (!kIsWeb) {
    applicationDirectory = await getApplicationDocumentsDirectory();
  }

  if (_isDesktop) {
    await WindowManager.instance.ensureInitialized();
  }

  final applicationInfo = ApplicationInfo(
    name: packageInfo.appName.capitalize(),
    version: packageInfo.version,
    buildNumber: packageInfo.buildNumber,
    os: !kIsWeb ? defaultTargetPlatform.name.capitalize() : "${defaultTargetPlatform.name.capitalize()} Web",
  );

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
        applicationInfoProvider.overrideWith((ref) => applicationInfo),
        crashLogProvider.overrideWith((ref) => crashProvider),
        argumentsStateProvider
            .overrideWith((ref) => ArgumentsModel.fromArguments(args, windowArguments, leanBackEnabled)),
        syncProvider.overrideWith((ref) => SyncNotifier(ref, applicationDirectory)),
      ],
      child: AdaptiveLayoutBuilder(
        child: (context) => const Main(),
      ),
    ),
  );
}

class Main extends ConsumerStatefulWidget with WindowListener {
  const Main({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> with WindowListener, WidgetsBindingObserver {
  DateTime _lastPaused = DateTime.now();
  bool _hidden = false;
  late final autoRouter = AutoRouter(ref: ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final ignoreLifeCycle = ref.read(lockScreenActiveProvider) ||
        ref.read(userProvider) == null ||
        ref.read(videoPlayerProvider).lastState?.playing == true ||
        nativeActivityStarted;

    if (ignoreLifeCycle) {
      _lastPaused = DateTime.now();
      _hidden = false;
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        if (_hidden) {
          enableTimeOut();
          _hidden = false;
        }
        break;

      case AppLifecycleState.paused:
        _hidden = true;
        _lastPaused = DateTime.now();
        break;

      default:
        break;
    }
  }

  void enableTimeOut() async {
    final timeOut = ref.read(clientSettingsProvider).timeOut;
    if (timeOut == null) return;

    final difference = DateTime.now().difference(_lastPaused);

    final lockMethod = ref.read(userProvider.select((value) => value?.authMethod));
    final shouldLock = Authentication.secureOptions.contains(lockMethod);

    if (difference > timeOut && shouldLock) {
      _lastPaused = DateTime.now();

      // Stop playback if the user was still watching a video
      await ref.read(videoPlayerProvider).pause();

      if (context.mounted) {
        autoRouter.push(const LockRoute());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    windowManager.addListener(this);
    // Make router available globally for SyncPlay and other providers
    // Deferred to avoid modifying provider during build phase
    Future.microtask(() {
      ref.read(routerProvider.notifier).state = autoRouter;
    });
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    windowManager.removeListener(this);
  }

  @override
  void onWindowClose() {
    ref.read(videoPlayerProvider).stop();
    ref.read(clientSettingsProvider.notifier).closeDirectory();
    super.onWindowClose();
  }

  @override
  void onWindowResize() async {
    final size = await windowManager.getSize();
    ref.read(clientSettingsProvider.notifier).setWindowSize(size);
    super.onWindowResize();
  }

  @override
  void onWindowResized() async {
    final size = await windowManager.getSize();
    ref.read(clientSettingsProvider.notifier).setWindowSize(size);
    super.onWindowResized();
  }

  @override
  void onWindowMove() async {
    final position = await windowManager.getPosition();
    ref.read(clientSettingsProvider.notifier).setWindowPosition(position);
    super.onWindowMove();
  }

  @override
  void onWindowMoved() async {
    final position = await windowManager.getPosition();
    ref.read(clientSettingsProvider.notifier).setWindowPosition(position);
    super.onWindowMoved();
  }

  @override
  void onWindowEnterFullScreen() {
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: true));
    toggleMacTrafficLights(true);
    super.onWindowEnterFullScreen();
  }

  @override
  void onWindowLeaveFullScreen() {
    toggleMacTrafficLights(false);
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: false));
    super.onWindowLeaveFullScreen();
  }

  void _init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    ref.read(sharedUtilityProvider).loadSettings();

    final clientSettings = ref.read(clientSettingsProvider);
    final startupArguments = ref.read(argumentsStateProvider);

    if (_isDesktop) {
      toggleMacTrafficLights(false);
      await windowManager.setupFladderWindowChrome(
        startupArguments,
        clientSettings,
        packageInfo,
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
        final lightTheme = themeColor == null
            ? FladderTheme.theme(lightDynamic ?? FladderTheme.defaultScheme(Brightness.light), schemeVariant)
            : FladderTheme.theme(themeColor.schemeLight, schemeVariant);
        final darkTheme = (themeColor == null
            ? FladderTheme.theme(darkDynamic ?? FladderTheme.defaultScheme(Brightness.dark), schemeVariant)
            : FladderTheme.theme(themeColor.schemeDark, schemeVariant));
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
                child: ScaffoldMessenger(child: child ?? Container()),
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
            routerConfig: autoRouter.config(),
          ),
        );
      },
    );
  }
}

final currentTitleProvider = StateProvider<String>((ref) => "Fladder");
