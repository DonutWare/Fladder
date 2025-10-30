import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout_model.dart';
import 'package:fladder/util/poster_defaults.dart';

class _DeviceProfile {
  final String name;
  final Size size;
  final double scale;
  final bool isDesktop;
  final InputDevice inputDevice;
  final ViewSize viewSize;
  final LayoutMode layoutMode;
  final TargetPlatform platform;

  const _DeviceProfile({
    required this.name,
    required this.size,
    this.scale = 1.0,
    this.isDesktop = false,
    this.inputDevice = InputDevice.dPad,
    required this.viewSize,
    required this.layoutMode,
    required this.platform,
  });
}

class ScreenshotRunner extends StatefulWidget {
  final Widget child;
  final String outputPath;

  const ScreenshotRunner({
    super.key,
    required this.child,
    required this.outputPath,
  });

  @override
  State<ScreenshotRunner> createState() => _ScreenshotRunnerState();
}

class _ScreenshotRunnerState extends State<ScreenshotRunner> {
  final GlobalKey _repaintKey = GlobalKey();
  int _currentIndex = 0;
  bool _isCapturing = false;

  bool _showNameInput = false;

  final TextEditingController _nameController = TextEditingController();

  Future<void> _capture(_DeviceProfile device, String screenshotName) async {
    final boundary = _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      debugPrint('No boundary found for ${device.name}');
      return;
    }

    final rawImage = await boundary.toImage(pixelRatio: 1.0);

    final resized = await resizeUiImage(
      rawImage,
      (device.size.width * device.scale).toInt(),
      (device.size.height * device.scale).toInt(),
    );

    final byteData = await resized.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    final dir = Directory('${widget.outputPath}/${device.name}');
    if (!dir.existsSync()) dir.createSync(recursive: true);

    final file = File('${dir.path}/$screenshotName.png');
    await file.writeAsBytes(bytes);
    debugPrint('Saved: ${file.path}');
  }

  Future<void> _runScreenshots(String value) async {
    if (_isCapturing) return;
    setState(() => _isCapturing = true);

    for (int i = 0; i < _defaultDeviceProfiles.length; i++) {
      setState(() => _currentIndex = i);
      await Future.delayed(const Duration(milliseconds: 300));
      await _capture(_defaultDeviceProfiles[i], value);
    }

    setState(() => _isCapturing = false);
  }

  Future<ui.Image> resizeUiImage(ui.Image image, int targetWidth, int targetHeight) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    final src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble());

    canvas.drawImageRect(image, src, dst, paint);

    final picture = recorder.endRecording();
    return await picture.toImage(targetWidth, targetHeight);
  }

  @override
  Widget build(BuildContext context) {
    final device = _defaultDeviceProfiles[_currentIndex];

    final scale = device.scale;
    final mediaQuery = MediaQuery.of(context);
    final screenSize = device.size;

    final scaledMedia = _isCapturing
        ? mediaQuery.copyWith(
            size: screenSize,
            padding: EdgeInsets.zero,
            viewInsets: EdgeInsets.zero,
            viewPadding: EdgeInsets.zero,
            devicePixelRatio: mediaQuery.devicePixelRatio * scale,
          )
        : MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: RepaintBoundary(
              key: _repaintKey,
              child: FittedBox(
                alignment: Alignment.center,
                child: SizedBox(
                  width: scaledMedia.size.width,
                  height: scaledMedia.size.height,
                  child: MediaQuery(
                    data: scaledMedia,
                    child: Builder(
                      builder: (context) {
                        return AdaptiveLayout(
                          data: _isCapturing
                              ? AdaptiveLayoutModel(
                                  viewSize: device.viewSize,
                                  layoutMode: device.layoutMode,
                                  inputDevice: device.inputDevice,
                                  platform: device.platform,
                                  isDesktop: device.isDesktop,
                                  posterDefaults: const PosterDefaults(size: 350, ratio: 0.55),
                                  controller: {},
                                  sideBarWidth: 0,
                                )
                              : AdaptiveLayout.of(context),
                          child: widget.child,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_showNameInput)
            Center(
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    canSizeOverlay: true,
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Enter screenshot name:"),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _nameController,
                            autofocus: true,
                            onSubmitted: (value) {
                              setState(() => _showNameInput = false);
                              _runScreenshots(value.trim());
                              _nameController.clear();
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              setState(() => _showNameInput = false);
                              _runScreenshots(_nameController.text.trim());
                              _nameController.clear();
                            },
                            child: const Text("Capture"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() {
          _showNameInput = true;
        }),
        label: Text(_isCapturing ? 'Capturing...' : 'Take Screenshots'),
        icon: const Icon(Icons.camera),
      ),
    );
  }
}

const _defaultDeviceProfiles = [
  _DeviceProfile(
    name: 'Mobile',
    size: Size(412, 915),
    scale: 3.0,
    inputDevice: InputDevice.touch,
    viewSize: ViewSize.phone,
    layoutMode: LayoutMode.single,
    platform: TargetPlatform.android,
    isDesktop: false,
  ),
  _DeviceProfile(
    name: 'Tablet',
    size: Size(1194, 834),
    scale: 2.0,
    inputDevice: InputDevice.touch,
    viewSize: ViewSize.tablet,
    layoutMode: LayoutMode.single,
    platform: TargetPlatform.android,
    isDesktop: false,
  ),
  _DeviceProfile(
    name: 'Television',
    size: Size(1920, 1080),
    scale: 1.0,
    inputDevice: InputDevice.dPad,
    viewSize: ViewSize.television,
    layoutMode: LayoutMode.dual,
    platform: TargetPlatform.android,
    isDesktop: false,
  ),
];
