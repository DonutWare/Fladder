import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:universal_html/html.dart' as html;

class FullScreenButton extends StatefulWidget {
  const FullScreenButton({super.key});

  @override
  State<FullScreenButton> createState() => _FullScreenButtonState();
}

class _FullScreenButtonState extends State<FullScreenButton> {
  bool fullScreen = false;

  @override
  void initState() {
    super.initState();
    _updateFullScreenStatus();
  }

  void _updateFullScreenStatus() {
    setState(() {
      fullScreen = html.document.fullscreenElement != null;
    });
  }

  void toggleFullScreen() async {
    if (fullScreen) {
      html.document.exitFullscreen();
      //Wait for 1 second
      await Future.delayed(const Duration(seconds: 1));
    } else {
      await html.document.documentElement?.requestFullscreen();
    }

    _updateFullScreenStatus();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleFullScreen,
      icon: Icon(
        fullScreen ? IconsaxOutline.close_square : IconsaxOutline.maximize_4,
      ),
    );
  }
}
