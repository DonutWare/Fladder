import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:window_manager/window_manager.dart';

class FullScreenButton extends StatefulWidget {
  const FullScreenButton({super.key});

  @override
  State<FullScreenButton> createState() => _FullScreenButtonState();
}

class _FullScreenButtonState extends State<FullScreenButton> {
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(checkFullScreen);
  }

  void checkFullScreen() async {
    final fullScreen = await windowManager.isFullScreen();
    setState(() {
      isFullScreen = fullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await windowManager.setFullScreen(!isFullScreen);
        checkFullScreen();
      },
      icon: Icon(
        isFullScreen ? IconsaxOutline.close_square : IconsaxOutline.maximize_4,
      ),
    );
  }
}
