import 'package:flutter/foundation.dart';

import 'package:window_manager/window_manager.dart';

Window? _window;

Window? get currentWindow {
  if (kIsWeb) return null;
  if (defaultTargetPlatform != TargetPlatform.macOS &&
      defaultTargetPlatform != TargetPlatform.windows &&
      defaultTargetPlatform != TargetPlatform.linux) {
    return null;
  }
  try {
    return _window ??= WindowManager.instance.getCurrent();
  } on ArgumentError {
    return null;
  }
}
