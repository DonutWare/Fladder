import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/util/localization_helper.dart';

extension DeviceOrientationExtension on DeviceOrientation {
  String label(BuildContext context) => switch (this) {
        DeviceOrientation.portraitUp => context.localized.deviceOrientationPortraitUp,
        DeviceOrientation.landscapeLeft => context.localized.deviceOrientationLandscapeLeft,
        DeviceOrientation.portraitDown => context.localized.deviceOrientationPortraitDown,
        DeviceOrientation.landscapeRight => context.localized.deviceOrientationLandscapeRight,
      };
}
