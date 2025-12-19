import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

//Empty screen that "overlays" the control panel selection on single layout
@RoutePage()
class ControlPanelSelectionScreen extends StatelessWidget {
  const ControlPanelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}
