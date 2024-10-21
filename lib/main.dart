import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:media_kit/media_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/syncing/i_synced_item.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/application_info.dart';
import 'package:fladder/util/fladder_config.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/util/themes_data.dart';

bool get _isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 3),
      maxNrOfCacheObjects: 500,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}

Future<Map<String, dynamic>> loadConfig() async {
  final configString = await rootBundle.loadString('config/config.json');
  return jsonDecode(configString);
}

void main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  if (kIsWeb) {
    html.document.onContextMenu.listen((event) => event.preventDefault());
    final result = await loadConfig();
    FladderConfig.fromJson(result);
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Directory isarPath = Directory("");
  Directory applicationDirectory = Directory("");

  if (!kIsWeb) {
    applicationDirectory = await getApplicationDocumentsDirectory();
    isarPath = Directory(path.joinAll([applicationDirectory.path, 'Fladder', 'Database']));
    await isarPath.create(recursive: true);
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
        syncProvider.overrideWith((ref) => SyncNotifier(
              ref,
              !kIsWeb
                  ? Isar.open(
                      schemas: [ISyncedItemSchema],
                      directory: isarPath.path,
                    )
                  : null,
              applicationDirectory,
            ))
      ],
      child: AdaptiveLayoutBuilder(
        fallBack: LayoutState.tablet,
        layoutPoints: [
          LayoutPoints(start: 0, end: 599, type: LayoutState.phone),
          LayoutPoints(start: 600, end: 1919, type: LayoutState.tablet),
          LayoutPoints(start: 1920, end: 3180, type: LayoutState.desktop),
        ],
        child: const Main(),
      ),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    if (kDebugMode) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });
}

class Main extends ConsumerStatefulWidget with WindowListener {
  const Main({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> with WindowListener, WidgetsBindingObserver {
  DateTime dateTime = DateTime.now();
  bool hidden = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (ref.read(lockScreenActiveProvider) || ref.read(userProvider) == null) {
      dateTime = DateTime.now();
      return;
    }
    switch (state) {
      case AppLifecycleState.resumed:
        enableTimeOut();
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        hidden = true;
        dateTime = DateTime.now();
        break;
      default:
        break;
    }
  }

  void enableTimeOut() async {
    final timeOut = ref.read(clientSettingsProvider).timeOut;

    if (timeOut == null) return;

    final difference = DateTime.now().difference(dateTime).abs();

    if (difference > timeOut && ref.read(userProvider)?.authMethod != Authentication.autoLogin && hidden) {
      hidden = false;
      dateTime = DateTime.now();

      // Stop playback if the user was still watching a video
      await ref.read(videoPlayerProvider).pause();

      if (context.mounted) {
        AdaptiveLayout.of(context).router.push(const LockRoute());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    windowManager.addListener(this);
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

  void _init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    ref.read(sharedUtilityProvider).loadSettings();

    final clientSettings = ref.read(clientSettingsProvider);

    if (_isDesktop) {
      WindowOptions windowOptions = WindowOptions(
          size: Size(clientSettings.size.x, clientSettings.size.y),
          center: true,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.hidden,
          title: packageInfo.appName.capitalize());

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
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
    final language = ref.watch(clientSettingsProvider
        .select((value) => value.selectedLocale ?? WidgetsBinding.instance.platformDispatcher.locale));
    final scrollBehaviour = const MaterialScrollBehavior();
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final lightTheme = themeColor == null
            ? FladderTheme.theme(lightDynamic ?? FladderTheme.defaultScheme(Brightness.light))
            : FladderTheme.theme(themeColor.schemeLight);
        final darkTheme = (themeColor == null
            ? FladderTheme.theme(darkDynamic ?? FladderTheme.defaultScheme(Brightness.dark))
            : FladderTheme.theme(themeColor.schemeDark));
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
              }.whereNotNull().toSet(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => Localizations.override(
              context: context,
              locale: AppLocalizations.supportedLocales.firstWhere(
                (element) => element.languageCode == language.languageCode,
                orElse: () => const Locale('en', "GB"),
              ),
              child: ScaffoldMessenger(child: child ?? Container()),
            ),
            darkTheme: darkTheme.copyWith(
              scaffoldBackgroundColor: amoledOverwrite,
              cardColor: amoledOverwrite,
              canvasColor: amoledOverwrite,
              colorScheme: darkTheme.colorScheme.copyWith(
                surface: amoledOverwrite,
                surfaceContainerHighest: amoledOverwrite,
              ),
            ),
            themeMode: themeMode,
            routerConfig: AdaptiveLayout.routerOf(context).config(),
          ),
        );
      }),
    );
  }
}

final currentTitleProvider = StateProvider<String>((ref) {
  return "Fladder";
});
