import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import 'package:auto_route/auto_route.dart';

extension RouterExtension on StackRouter {
  Future<bool> popBack() async {
    if (kIsWeb) {
      back();
      return canNavigateBack;
    } else {
      return maybePop();
    }
  }

  Widget? backButton() {
    if (kIsWeb && canNavigateBack) {
      return IconButton(
        onPressed: back,
        icon: const BackButtonIcon(),
      );
    } else if (canPop()) {
      return IconButton(
        onPressed: maybePop,
        icon: const BackButtonIcon(),
      );
    }
    return null;
  }
}
