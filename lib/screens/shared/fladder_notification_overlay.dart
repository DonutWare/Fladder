import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';

import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

class FladderSnack {
  static final FladderSnack _instance = FladderSnack._internal();
  factory FladderSnack() => _instance;
  FladderSnack._internal();

  static BuildContext? _storedContext;

  static void setContext(BuildContext context) {
    _storedContext = context;
  }

  final Queue<_NotificationEntry> _notifications = Queue();
  int _nextId = 0;

  int _getIndexById(int id) {
    var index = 0;
    for (final entry in _notifications) {
      if (entry.id == id) return index;
      index++;
    }
    return 0;
  }

  int get _notificationCount => _notifications.length;

  static void showResponse({Response? response, String? altTitle}) {
    if (response != null) {
      FladderSnack.show("(${response.base.statusCode}) ${response.base.reasonPhrase ?? "Something went wrong!"}");
      return;
    } else if (altTitle != null) {
      FladderSnack.show(altTitle);
    }
  }

  static void show(
    String message, {
    BuildContext? context,
    Duration? duration,
    bool permanent = false,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool showCloseButton = false,
  }) {
    final effectiveContext = context ?? _storedContext;
    if (effectiveContext == null || !effectiveContext.mounted) {
      debugPrint('FladderNotificationManager: No valid context available');
      return;
    }

    final overlay = Overlay.of(effectiveContext);
    final instance = FladderSnack();
    final id = instance._nextId++;

    final effectiveDuration = duration ?? const Duration(seconds: 5);

    late OverlayEntry overlayEntry;
    Timer? timer;
    final widgetKey = GlobalKey<_NotificationOverlayWidgetState>();

    void removeNotification() async {
      final state = widgetKey.currentState;
      if (state != null && state.mounted) {
        await state.dismiss();
      }

      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
      timer?.cancel();
      instance._notifications.removeWhere((entry) => entry.id == id);
      instance._updatePositions();
    }

    overlayEntry = OverlayEntry(
      builder: (context) => _NotificationOverlayWidget(
        key: widgetKey,
        id: id,
        message: message,
        onDismiss: removeNotification,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        showCloseButton: showCloseButton,
      ),
    );

    final entry = _NotificationEntry(
      id: id,
      overlayEntry: overlayEntry,
      timer: timer,
    );

    instance._notifications.add(entry);
    overlay.insert(overlayEntry);

    if (!permanent) {
      timer = Timer(effectiveDuration, removeNotification);
      entry.timer = timer;
    }
  }

  void clearAll() {
    for (final entry in _notifications) {
      entry.timer?.cancel();
      if (entry.overlayEntry.mounted) {
        entry.overlayEntry.remove();
      }
    }
    _notifications.clear();
  }

  void _updatePositions() {
    for (var i = 0; i < _notifications.length; i++) {
      final entry = _notifications.elementAt(i);
      if (entry.overlayEntry.mounted) {
        entry.overlayEntry.markNeedsBuild();
      }
    }
  }
}

class _NotificationEntry {
  final int id;
  final OverlayEntry overlayEntry;
  Timer? timer;

  _NotificationEntry({
    required this.id,
    required this.overlayEntry,
    this.timer,
  });
}

class _NotificationOverlayWidget extends StatefulWidget {
  final int id;
  final String message;
  final VoidCallback onDismiss;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final bool showCloseButton;

  const _NotificationOverlayWidget({
    super.key,
    required this.id,
    required this.message,
    required this.onDismiss,
    this.actionLabel,
    this.onActionPressed,
    this.showCloseButton = false,
  });

  @override
  State<_NotificationOverlayWidget> createState() => _NotificationOverlayWidgetState();
}

class _NotificationOverlayWidgetState extends State<_NotificationOverlayWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  Future<void> dismiss() async {
    if (!mounted) return;
    await _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewSize = AdaptiveLayout.viewSizeOf(context);
    final inputDevice = AdaptiveLayout.inputDeviceOf(context);
    final screenSize = MediaQuery.of(context).size;

    final positioning = _getPositioning(viewSize, screenSize);

    _slideAnimation = Tween<Offset>(
      begin: positioning.slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    final manager = FladderSnack();
    final currentIndex = manager._getIndexById(widget.id);
    final totalNotifications = manager._notificationCount;
    final verticalOffset = (totalNotifications - 1 - currentIndex) * 30.0;

    return Positioned(
      top: positioning.top != null ? positioning.top! + verticalOffset : null,
      left: positioning.left,
      right: positioning.right,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: positioning.padding,
            child: Align(
              alignment: positioning.alignment,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: positioning.maxWidth ?? double.infinity,
                ),
                child: _NotificationCard(
                  message: widget.message,
                  onDismiss: widget.onDismiss,
                  actionLabel: widget.actionLabel,
                  onActionPressed: () {
                    if (inputDevice == InputDevice.dPad && widget.onActionPressed != null) {
                      _showActionDialog(context);
                    } else {
                      widget.onActionPressed?.call();
                    }
                  },
                  showCloseButton: widget.showCloseButton,
                  showActionInline: inputDevice != InputDevice.dPad,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(widget.message),
        actions: [
          FilledButton(
            autofocus: true,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              widget.onActionPressed?.call();
              widget.onDismiss();
            },
            child: Text(widget.actionLabel ?? context.localized.ok),
          ),
        ],
      ),
    );
  }

  _NotificationPositioning _getPositioning(ViewSize viewSize, Size screenSize) {
    switch (viewSize) {
      case ViewSize.phone:
        return _NotificationPositioning(
          top: 0,
          left: 0,
          right: 0,
          alignment: Alignment.center,
          slideOffset: const Offset(0, -1),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
        );

      case ViewSize.tablet:
      case ViewSize.desktop:
        return _NotificationPositioning(
          top: 20,
          right: 20,
          alignment: Alignment.centerRight,
          maxWidth: screenSize.width / 2.5,
          slideOffset: const Offset(1, 0),
          padding: EdgeInsets.zero,
        );

      case ViewSize.television:
        return _NotificationPositioning(
          top: 40,
          right: screenSize.width / 3,
          alignment: Alignment.center,
          maxWidth: screenSize.width / 2,
          slideOffset: const Offset(0, -1),
          padding: EdgeInsets.zero,
        );
    }
  }
}

class _NotificationPositioning {
  final double? top;
  final double? left;
  final double? right;
  final double? maxWidth;
  final Offset slideOffset;
  final EdgeInsets padding;
  final Alignment alignment;

  _NotificationPositioning({
    this.top,
    this.left,
    this.right,
    this.maxWidth,
    required this.slideOffset,
    required this.padding,
    required this.alignment,
  });
}

class _NotificationCard extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final bool showCloseButton;
  final bool showActionInline;

  const _NotificationCard({
    required this.message,
    required this.onDismiss,
    this.actionLabel,
    this.onActionPressed,
    this.showCloseButton = false,
    this.showActionInline = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasAction = actionLabel != null && onActionPressed != null;
    final showAction = hasAction && showActionInline;
    final viewSize = AdaptiveLayout.viewSizeOf(context);
    final isPhone = viewSize == ViewSize.phone;

    final radius = FladderTheme.defaultShape.borderRadius;

    final backgroundColor = Theme.of(context).colorScheme.primary;
    final borderColor = Theme.of(context).colorScheme.onPrimary.withAlpha(150);
    final foregroundColor = Theme.of(context).colorScheme.onPrimary;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(75),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisSize: isPhone ? MainAxisSize.max : MainAxisSize.min,
          spacing: 12,
          children: [
            if (isPhone)
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: foregroundColor,
                      ),
                ),
              )
            else
              Flexible(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: foregroundColor,
                      ),
                ),
              ),
            if (showAction)
              FilledButton(
                onPressed: () {
                  onActionPressed!();
                  onDismiss();
                },
                child: Text(actionLabel!),
              ),
            if (showCloseButton && !showAction)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onDismiss,
                color: foregroundColor,
              ),
          ],
        ),
      ),
    );
  }
}

class NotificationManagerInitializer extends StatelessWidget {
  final Widget child;

  const NotificationManagerInitializer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        FladderSnack.setContext(context);
      }
    });

    return child;
  }
}
