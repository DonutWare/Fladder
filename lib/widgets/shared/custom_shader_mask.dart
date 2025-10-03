import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomShaderMask extends StatefulWidget {
  final Widget child;
  const CustomShaderMask({required this.child, super.key});

  @override
  CustomShaderMaskState createState() => CustomShaderMaskState();
}

class CustomShaderMaskState extends State<CustomShaderMask> {
  ui.Image? gradientImage;

  @override
  void initState() {
    super.initState();
    _loadImage('assets/gradient.png');
  }

  Future<void> _loadImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    setState(() {
      gradientImage = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gradientImage == null) {
      return const SizedBox.shrink();
    }

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        final imageWidth = gradientImage!.width.toDouble();
        final imageHeight = gradientImage!.height.toDouble();

        final scaleX = bounds.width / imageWidth;
        final scaleY = bounds.height / imageHeight;

        final matrix = Matrix4.diagonal3Values(scaleX, scaleY, 1);

        return ImageShader(
          gradientImage!,
          TileMode.clamp,
          TileMode.clamp,
          matrix.storage,
        );
      },
      blendMode: BlendMode.dstIn,
      child: widget.child,
    );
  }
}
