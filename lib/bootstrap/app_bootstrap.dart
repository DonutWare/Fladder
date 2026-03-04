import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/providers/crash_log_provider.dart';
import 'package:fladder/src/video_player_helper.g.dart';
import 'package:fladder/util/application_info.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/util/svg_utils.dart';

bool get isDesktopPlatform {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

class AppBootstrapResult {
  const AppBootstrapResult({
    required this.sharedPreferences,
    required this.applicationInfo,
    required this.applicationDirectory,
    required this.argumentsModel,
    required this.crashProvider,
  });

  final SharedPreferences sharedPreferences;
  final ApplicationInfo applicationInfo;
  final Directory applicationDirectory;
  final ArgumentsModel argumentsModel;
  final CrashLogNotifier crashProvider;
}

Future<AppBootstrapResult> bootstrapApplication(List<String> args) async {
  final crashProvider = CrashLogNotifier();

  await SvgUtils.preCacheSVGs();

  final leanBackEnabled = await _resolveLeanBackEnabled();

  var windowArguments = '';
  if (isDesktopPlatform) {
    windowArguments = await _resolveWindowArguments();
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();

  var applicationDirectory = Directory('');
  if (!kIsWeb) {
    applicationDirectory = await getApplicationDocumentsDirectory();
  }

  final applicationInfo = ApplicationInfo(
    name: packageInfo.appName.capitalize(),
    version: packageInfo.version,
    buildNumber: packageInfo.buildNumber,
    platform: defaultTargetPlatform,
  );

  final argumentsModel = ArgumentsModel.fromArguments(
    args,
    windowArguments,
    leanBackEnabled,
  );

  return AppBootstrapResult(
    sharedPreferences: sharedPreferences,
    applicationInfo: applicationInfo,
    applicationDirectory: applicationDirectory,
    argumentsModel: argumentsModel,
    crashProvider: crashProvider,
  );
}

Future<bool> _resolveLeanBackEnabled() async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return false;
  }

  try {
    return await NativeVideoActivity().isLeanBackEnabled();
  } catch (e) {
    print('Leanback detection failed (non-TV Android device): $e');
    return false;
  }
}

Future<String> _resolveWindowArguments() async {
  try {
    final windowController = await WindowController.fromCurrentEngine();
    return windowController.arguments;
  } catch (e) {
    print('Window arguments resolution failed: $e');
    return '';
  }
}
