import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

//Empty screen that "overlays" the settings selection on single layout
@RoutePage()
class SettingsSelectionScreen extends StatelessWidget {
  const SettingsSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}
