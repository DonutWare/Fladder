import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player_videohole/video_player.dart';
import 'package:video_player_videohole/video_player_platform_interface.dart';

/// This is a modified version of the VideoHole widget from the video_player package
/// It is used to create a hole in the video player to display the video on the Tizen TV
/// This is only used to have scaling of UI be independent of the Tizen Video Player
class TizenVideoHole extends StatefulWidget {
  const TizenVideoHole(this.controller, {super.key});

  final VideoPlayerController controller;

  @override
  State<TizenVideoHole> createState() => _TizenVideoHoleState();
}

class _TizenVideoHoleState extends State<TizenVideoHole> {
  final GlobalKey _videoBoxKey = GlobalKey();
  Rect _playerRect = Rect.zero;
  late final VoidCallback _listener;
  int _playerId = -1;
  int? _lastGeometryPlayerId;

  @override
  void initState() {
    super.initState();

    // Keep track of the platform player id. It becomes available after
    // asynchronous initialization.
    _playerId = widget.controller.playerId;
    _listener = () {
      _playerId = widget.controller.playerId;
    };
    widget.controller.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback(_afterFrameLayout);
  }

  @override
  void didUpdateWidget(TizenVideoHole oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) {
      return;
    }

    oldWidget.controller.removeListener(_listener);
    _playerId = widget.controller.playerId;
    widget.controller.addListener(_listener);
    _lastGeometryPlayerId = null;
    _playerRect = Rect.zero;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  void _afterFrameLayout(_) {
    if (!mounted) {
      return;
    }

    if (widget.controller.value.isInitialized) {
      final int playerId = _playerId;
      final Rect currentRect = _getCurrentRect();
      final bool playerChanged = _lastGeometryPlayerId != playerId;
      final bool rectChanged = _playerRect != currentRect;

      if (currentRect != Rect.zero && (playerChanged || rectChanged)) {
        VideoPlayerPlatform.instance.setDisplayGeometry(
          playerId,
          _safeInt(currentRect.left),
          _safeInt(currentRect.top),
          _safeInt(currentRect.width),
          _safeInt(currentRect.height),
        );
        _playerRect = currentRect;
        _lastGeometryPlayerId = playerId;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback(_afterFrameLayout);
  }

  int _safeInt(double value) {
    if (!value.isFinite || value.isNaN) {
      return 0;
    }
    return value.toInt();
  }

  Rect _getCurrentRect() {
    final RenderObject? renderObject = _videoBoxKey.currentContext?.findRenderObject();
    if (renderObject == null) {
      return Rect.zero;
    }

    final RenderBox renderBox = renderObject as RenderBox;

    final double pixelRatio = View.of(context).devicePixelRatio;

    final Matrix4 transform = renderBox.getTransformTo(null);
    final Rect logicalRect = MatrixUtils.transformRect(
      transform,
      Offset.zero & renderBox.size,
    );

    return Rect.fromLTWH(
      logicalRect.left * pixelRatio,
      logicalRect.top * pixelRatio,
      logicalRect.width * pixelRatio,
      logicalRect.height * pixelRatio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _videoBoxKey, child: const _Hole());
  }
}

class _Hole extends LeafRenderObjectWidget {
  const _Hole();

  @override
  RenderBox createRenderObject(BuildContext context) => _HoleBox();
}

class _HoleBox extends RenderBox {
  @override
  bool get sizedByParent => true;

  @override
  bool get alwaysNeedsCompositing => true;

  @override
  bool get isRepaintBoundary => true;

  @override
  void performResize() {
    size = constraints.biggest;
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    context.addLayer(_HoleLayer(rect: offset & size));
  }
}

class _HoleLayer extends Layer {
  _HoleLayer({required this.rect});

  final Rect rect;

  @override
  void addToScene(ui.SceneBuilder builder, [Offset layerOffset = Offset.zero]) {
    builder.addPicture(layerOffset, _createHolePicture(rect));
  }

  ui.Picture _createHolePicture(Rect holeRect) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.src;
    canvas.drawRect(holeRect, paint);
    return recorder.endRecording();
  }
}
