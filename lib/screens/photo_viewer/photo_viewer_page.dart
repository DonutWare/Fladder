import 'dart:io';

import 'package:material_ui/material_ui.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/screens/photo_viewer/media_viewer/media_gesture_viewer.dart';
import 'package:fladder/screens/photo_viewer/media_viewer/zoomable_media.dart';
import 'package:fladder/util/custom_cache_manager.dart';
import 'package:fladder/util/localization_helper.dart';

ImageProvider photoImageProvider(String? path) {
  final imagePath = path ?? "";
  if (imagePath.isNotEmpty && !imagePath.startsWith("http")) {
    return FileImage(File(imagePath));
  }
  return CachedNetworkImageProvider(
    imagePath,
    cacheManager: CustomCacheManager.instance,
  );
}

class PhotoViewerPage extends StatefulWidget {
  final PhotoModel photo;
  final MediaPage page;
  const PhotoViewerPage({required this.photo, required this.page, super.key});

  @override
  State<PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<PhotoViewerPage> {
  ImageStream? _stream;
  Size? _contentSize;
  bool _failed = false;
  int _attempt = 0;

  late final _listener = ImageStreamListener(
    (info, _) {
      final size = Size(info.image.width.toDouble(), info.image.height.toDouble());
      info.dispose();
      if (mounted) setState(() => _contentSize = size);
    },
    onError: (_, _) {
      if (mounted) setState(() => _failed = true);
    },
  );

  ImageProvider get _image => photoImageProvider(widget.photo.images?.primary?.path);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
  }

  @override
  void didUpdateWidget(PhotoViewerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photo.images?.primary?.path != widget.photo.images?.primary?.path) _resolve();
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }

  void _resolve() {
    final stream = _image.resolve(createLocalImageConfiguration(context));
    if (stream.key == _stream?.key) return;
    _stream?.removeListener(_listener);
    _stream = stream..addListener(_listener);
  }

  Future<void> _retry() async {
    await _image.evict();
    _stream?.removeListener(_listener);
    _stream = null;
    setState(() {
      _failed = false;
      _attempt++;
    });
    _resolve();
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = Image(
      key: const ValueKey(false),
      image: photoImageProvider(widget.photo.thumbnail?.primary?.path),
      fit: BoxFit.contain,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => const SizedBox.shrink(),
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        ZoomableMedia(
          active: widget.page.active,
          contentSize: _contentSize,
          onTap: widget.page.onTap,
          onZoomChanged: widget.page.onZoomChanged,
          child: Image(
            key: ValueKey(_attempt),
            image: _image,
            fit: BoxFit.contain,
            gaplessPlayback: true,
            filterQuality: FilterQuality.medium,
            frameBuilder: (context, child, frame, synchronous) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              layoutBuilder: (current, previous) => Stack(
                fit: StackFit.expand,
                children: [...previous, ?current],
              ),
              child: synchronous || frame != null ? KeyedSubtree(key: const ValueKey(true), child: child) : thumbnail,
            ),
            errorBuilder: (_, _, _) => thumbnail,
          ),
        ),
        if (_contentSize == null && !_failed)
          const IgnorePointer(child: Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round))),
        if (_failed)
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.localized.failedToLoadImage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 6),
                    FilledButton.tonal(
                      onPressed: _retry,
                      child: Text(context.localized.retry),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
