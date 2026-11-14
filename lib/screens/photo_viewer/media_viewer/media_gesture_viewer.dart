import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MediaPage {
  const MediaPage({
    required this.active,
    required this.overlayVisible,
    required this.onTap,
    required this.onZoomChanged,
  });

  final bool active;
  final bool overlayVisible;
  final VoidCallback onTap;
  final ValueChanged<bool>? onZoomChanged;
}

class MediaOverlay {
  const MediaOverlay({required this.index, required this.count, required this.visible, required this.infoOpen});

  final int index;
  final int count;
  final bool visible;
  final bool infoOpen;
}

enum MediaInfoPlacement { sheet, side }

class MediaViewerMotion {
  const MediaViewerMotion({
    this.page = const Duration(milliseconds: 250),
    this.pageCurve = Curves.easeOutCubic,
    this.sheet = const Duration(milliseconds: 450),
    this.sheetCurve = Curves.easeOutCubic,
  });

  final Duration page;
  final Curve pageCurve;
  final Duration sheet;
  final Curve sheetCurve;
}

class MediaViewerController {
  _ViewerActions? _viewer;

  void next() => _viewer?.goBy(1);

  void previous() => _viewer?.goBy(-1);

  void advance() => _viewer?.goBy(1, wrap: true);

  void toggleInfo() => _viewer?.toggleInfo();

  void close() => _viewer?.close();

  void show(Object key) => _viewer?.show(key);

  void showOverlay({required bool visible}) => _viewer?.setOverlay(visible: visible);
}

abstract interface class _ViewerActions {
  void goBy(int delta, {bool wrap = false});

  void toggleInfo();

  void close();

  void show(Object key);

  void setOverlay({required bool visible});
}

class MediaGestureViewer<T> extends StatefulWidget {
  const MediaGestureViewer({
    required this.items,
    required this.itemKey,
    required this.initialItem,
    required this.pageBuilder,
    required this.usesPointer,
    required this.sideInfo,
    this.controller,
    this.overlayBuilder,
    this.infoBuilder,
    this.onItemChanged,
    this.background = Colors.black,
    this.sideInfoWidth = 360,
    this.motion = const MediaViewerMotion(),
    super.key,
  });

  final List<T> items;
  final Object Function(T item) itemKey;
  final T initialItem;
  final Widget Function(BuildContext context, T item, MediaPage page) pageBuilder;
  final bool usesPointer;
  final bool sideInfo;
  final MediaViewerController? controller;
  final Widget Function(BuildContext context, T item, MediaOverlay overlay)? overlayBuilder;
  final Widget Function(BuildContext context, T item, MediaInfoPlacement placement)? infoBuilder;
  final ValueChanged<T>? onItemChanged;
  final Color background;
  final double sideInfoWidth;
  final MediaViewerMotion motion;

  @override
  State<MediaGestureViewer<T>> createState() => _MediaGestureViewerState<T>();
}

class _MediaGestureViewerState<T> extends State<MediaGestureViewer<T>>
    with TickerProviderStateMixin
    implements _ViewerActions {
  static const _overlayIdleTimeout = Duration(seconds: 3);
  static const _dismissDistance = 120.0;
  static const _flingVelocity = 300.0;
  static const _sheetMaxHeight = 480.0;
  static const _sheetHeightFraction = 0.55;
  static const _sheetOpenThreshold = 0.3;
  static const _dismissShrink = 0.3;

  late Object _currentKey = widget.itemKey(widget.initialItem);
  Object? _pendingKey;
  int _lastIndex = 0;
  late List<Object> _keys = _keysOf(widget.items);
  late final _pageController = PageController(initialPage: _index);
  late final _sheet = AnimationController(vsync: this);
  late final _dismiss = AnimationController.unbounded(vsync: this);
  final _focusNode = FocusNode();
  bool _overlayVisible = true;
  bool _zoomed = false;
  final _touches = <int>{};
  bool _multiTouch = false;
  bool _sideInfoOpen = false;
  double _sheetHeight = 1;
  Timer? _overlayTimer;

  int get _index => math.max(0, _keys.indexOf(_currentKey));

  T get _current => widget.items[_index];

  bool get _infoOpen => widget.sideInfo ? _sideInfoOpen : _sheet.value > 0;

  List<Object> _keysOf(List<T> items) => [for (final item in items) widget.itemKey(item)];

  @override
  void initState() {
    super.initState();
    widget.controller?._viewer = this;
    _lastIndex = _index;
    _notifyCurrent();
  }

  @override
  void didUpdateWidget(MediaGestureViewer<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._viewer = null;
      widget.controller?._viewer = this;
    }
    final keys = _keysOf(widget.items);
    if (listEquals(keys, _keys)) return;
    _keys = keys;
    if (keys.isEmpty) return;
    final previous = _currentKey;
    if (_pendingKey case final pending? when keys.contains(pending)) {
      _currentKey = pending;
      _pendingKey = null;
    } else if (!keys.contains(_currentKey)) {
      _currentKey = keys[math.min(_lastIndex, keys.length - 1)];
    }
    _jumpToCurrent();
    if (_currentKey != previous) _notifyCurrent();
  }

  void _jumpToCurrent() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients && _pageController.page?.round() != _index) _pageController.jumpToPage(_index);
      });

  void _notifyCurrent() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.items.isNotEmpty) widget.onItemChanged?.call(_current);
      });

  @override
  void show(Object key) {
    if (!_keys.contains(key)) {
      _pendingKey = key;
      return;
    }
    if (key == _currentKey) return;
    setState(() => _currentKey = key);
    _jumpToCurrent();
    _notifyCurrent();
  }

  @override
  void dispose() {
    if (widget.controller?._viewer == this) widget.controller?._viewer = null;
    _overlayTimer?.cancel();
    _pageController.dispose();
    _sheet.dispose();
    _dismiss.dispose();
    _focusNode.dispose();
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));
    super.dispose();
  }

  void _onPageChanged(int index) {
    final item = widget.items[index];
    _lastIndex = index;
    setState(() {
      _currentKey = widget.itemKey(item);
      _zoomed = false;
    });
    widget.onItemChanged?.call(item);
  }

  @override
  void goBy(int delta, {bool wrap = false}) {
    final count = widget.items.length;
    if (!_pageController.hasClients || count < 2) return;
    final current = _index;
    final target = wrap ? (current + delta) % count : (current + delta).clamp(0, count - 1);
    if (target == current) return;
    if ((target - current).abs() > 1) {
      _pageController.jumpToPage(target);
    } else {
      unawaited(_pageController.animateToPage(target, duration: widget.motion.page, curve: widget.motion.pageCurve));
    }
  }

  @override
  void setOverlay({required bool visible}) {
    if (_overlayVisible == visible) return;
    setState(() => _overlayVisible = visible);
    if (!widget.usesPointer) {
      unawaited(SystemChrome.setEnabledSystemUIMode(visible ? SystemUiMode.edgeToEdge : SystemUiMode.immersiveSticky));
    }
  }

  @override
  void toggleInfo() {
    if (widget.sideInfo) {
      setState(() => _sideInfoOpen = !_sideInfoOpen);
    } else {
      _animateSheet(open: _sheet.value == 0);
    }
  }

  @override
  void close() {
    if (_sheet.value > 0) return _animateSheet(open: false);
    if (_sideInfoOpen) return setState(() => _sideInfoOpen = false);
    unawaited(Navigator.of(context).maybePop());
  }

  void _animateSheet({required bool open}) =>
      unawaited(_sheet.animateTo(open ? 1 : 0, duration: widget.motion.sheet, curve: widget.motion.sheetCurve));

  void _onTap() {
    if (_sheet.value > 0) {
      _animateSheet(open: false);
    } else {
      setOverlay(visible: !_overlayVisible);
    }
  }

  void _onPointerHover(PointerHoverEvent event) {
    if (event.kind != PointerDeviceKind.mouse) return;
    setOverlay(visible: true);
    _overlayTimer?.cancel();
    _overlayTimer = Timer(_overlayIdleTimeout, () {
      if (mounted) setOverlay(visible: false);
    });
  }

  void _onPointerDown(PointerDownEvent event) {
    if (event.kind != PointerDeviceKind.touch) return;
    _touches.add(event.pointer);
    if (_touches.length > 1 && !_multiTouch) setState(() => _multiTouch = true);
  }

  void _onPointerEnd(PointerEvent event) {
    _touches.remove(event.pointer);
    if (_touches.isEmpty && _multiTouch) setState(() => _multiTouch = false);
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0;
    if (_dismiss.value > 0 || (_sheet.value == 0 && delta > 0)) {
      _dismiss.value = math.max(0, _dismiss.value + delta);
    } else if (!widget.sideInfo) {
      _sheet.value -= delta / _sheetHeight;
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (_dismiss.value > 0) {
      if (_dismiss.value > _dismissDistance || velocity > _flingVelocity * 3) {
        unawaited(Navigator.of(context).maybePop());
      } else {
        unawaited(_dismiss.animateTo(0, duration: widget.motion.page, curve: widget.motion.pageCurve));
      }
      return;
    }
    if (widget.sideInfo) {
      if (velocity < -_flingVelocity) setState(() => _sideInfoOpen = true);
      return;
    }
    _animateSheet(open: velocity.abs() > _flingVelocity ? velocity < 0 : _sheet.value > _sheetOpenThreshold);
  }

  Map<ShortcutActivator, VoidCallback> get _shortcuts => {
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => goBy(1),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => goBy(-1),
        const SingleActivator(LogicalKeyboardKey.keyI): toggleInfo,
        const SingleActivator(LogicalKeyboardKey.escape): close,
      };

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.expand();
    final current = _current;
    return CallbackShortcuts(
      bindings: _shortcuts,
      child: Focus(
        focusNode: _focusNode,
        autofocus: true,
        child: Row(
          children: [
            Expanded(child: _stage(current)),
            _sidePanel(current),
          ],
        ),
      ),
    );
  }

  Widget _sidePanel(T current) {
    final infoBuilder = widget.infoBuilder;
    return AnimatedSize(
      duration: widget.motion.sheet,
      curve: widget.motion.pageCurve,
      alignment: Alignment.centerLeft,
      child: widget.sideInfo && _sideInfoOpen && infoBuilder != null
          ? SizedBox(width: widget.sideInfoWidth, child: infoBuilder(context, current, MediaInfoPlacement.side))
          : const SizedBox(height: double.infinity),
    );
  }

  Widget _stage(T current) => LayoutBuilder(
        builder: (context, constraints) {
          _sheetHeight = math.min(constraints.maxHeight * _sheetHeightFraction, _sheetMaxHeight);
          final dragsEnabled = !widget.usesPointer && !_zoomed && !_multiTouch;
          final infoBuilder = widget.infoBuilder;
          final overlayBuilder = widget.overlayBuilder;
          return Listener(
            onPointerDown: _onPointerDown,
            onPointerUp: _onPointerEnd,
            onPointerCancel: _onPointerEnd,
            child: MouseRegion(
              onHover: _onPointerHover,
              child: AnimatedBuilder(
                animation: Listenable.merge([_sheet, _dismiss]),
                builder: (context, _) {
                  final sheet = _sheet.value;
                  final dismiss = _dismiss.value;
                  final dismissProgress = (dismiss / constraints.maxHeight).clamp(0.0, 1.0);
                  final fitScale = 1 - sheet * _sheetHeight / constraints.maxHeight;
                  final overlayVisible = _overlayVisible && sheet == 0 && dismiss == 0;
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: ColoredBox(
                            color: widget.background.withValues(alpha: widget.background.a * (1 - dismissProgress))),
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onVerticalDragUpdate: dragsEnabled ? _onVerticalDragUpdate : null,
                          onVerticalDragEnd: dragsEnabled ? _onVerticalDragEnd : null,
                          child: Transform.translate(
                            offset: Offset(0, dismiss),
                            child: Transform.scale(
                              scale: 1 - dismissProgress * _dismissShrink,
                              child: Transform.scale(
                                alignment: Alignment.topCenter,
                                scale: fitScale,
                                child: _pager(overlayVisible),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (overlayBuilder != null)
                        Positioned.fill(
                          child: overlayBuilder(
                            context,
                            current,
                            MediaOverlay(
                              index: _index,
                              count: widget.items.length,
                              visible: overlayVisible,
                              infoOpen: _infoOpen,
                            ),
                          ),
                        ),
                      if (!widget.sideInfo && sheet > 0 && infoBuilder != null)
                        Positioned(
                          left: 0,
                          right: 0,
                          height: _sheetHeight,
                          bottom: -(1 - sheet) * _sheetHeight,
                          child: GestureDetector(
                            onVerticalDragUpdate: widget.usesPointer ? null : _onVerticalDragUpdate,
                            onVerticalDragEnd: widget.usesPointer ? null : _onVerticalDragEnd,
                            child: infoBuilder(context, current, MediaInfoPlacement.sheet),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      );

  Widget _pager(bool overlayVisible) => PageView.builder(
        controller: _pageController,
        physics: _zoomed || _multiTouch ? const NeverScrollableScrollPhysics() : null,
        allowImplicitScrolling: true,
        itemCount: widget.items.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final key = widget.itemKey(item);
          final active = key == _currentKey;
          return KeyedSubtree(
            key: ValueKey(key),
            child: widget.pageBuilder(
              context,
              item,
              MediaPage(
                active: active,
                overlayVisible: overlayVisible,
                onTap: _onTap,
                onZoomChanged: active ? (zoomed) => setState(() => _zoomed = zoomed) : null,
              ),
            ),
          );
        },
      );
}
