import 'package:flutter/material.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/global_hotkeys.dart';

class RouteWrapper extends StatelessWidget {
  final Widget child;
  const RouteWrapper({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationManagerInitializer(
      child: GlobalHotkeys(
        child: child,
        enabledHotkeys: {
          GlobalHotKeys.closeWindow,
          GlobalHotKeys.exit,
        },
      ),
    );
  }
}
