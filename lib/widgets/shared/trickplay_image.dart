import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:fladder/models/items/trick_play_model.dart';

class TrickplayImage extends ConsumerStatefulWidget {
  final TrickPlayModel trickplay;
  final Duration? position;

  const TrickplayImage(this.trickplay, {this.position, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrickplayImageState();
}

class _TrickplayImageState extends ConsumerState<TrickplayImage> {
  ui.Image? image;
  late TrickPlayModel model = widget.trickplay;
  late Duration time = widget.position ?? Duration.zero;
  late Offset currentOffset = const Offset(0, 0);
  String? currentUrl;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  void didUpdateWidget(covariant TrickplayImage oldWidget) {
    if (oldWidget.position?.inMilliseconds != widget.position?.inMilliseconds) {
      time = widget.position ?? Duration.zero;
      model = widget.trickplay;
      loadImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: image != null
          ? CustomPaint(
              painter: TilledPainter(image!, currentOffset, widget.trickplay),
            )
          : Container(
              color: Colors.purple,
            ),
    );
  }

  Future<void> loadImage() async {
    if (model.images.isEmpty) return;
    final newUrl = model.getTile(time);
    currentOffset = model.offset(time);
    if (newUrl != currentUrl) {
      currentUrl = newUrl;
      final tempUrl = currentUrl;
      if (tempUrl == null) return;
      if (tempUrl.startsWith('http')) {
        await loadNetworkImage(tempUrl);
      } else {
        await loadFileImage(tempUrl);
      }
    }
  }

  Future<void> loadNetworkImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      setState(() {
        image = frameInfo.image;
      });
    } else {
      throw Exception('Failed to load network image');
    }
  }

  Future<void> loadFileImage(String path) async {
    final Uint8List bytes = await File(path).readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      image = frameInfo.image;
    });
  }
}

class TilledPainter extends CustomPainter {
  final ui.Image image;
  final Offset offset;
  final TrickPlayModel model;

  TilledPainter(this.image, this.offset, this.model);

  @override
  void paint(Canvas canvas, Size size) {
    // Define the source rectangle from the image
    Rect srcRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      model.width.toDouble(),
      model.height.toDouble(),
    ); // Adjust these values to control the part of the image to display

    // Define the destination rectangle on the canvas
    Rect dstRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the image part onto the canvas
    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
