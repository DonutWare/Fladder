import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

const _pinLength = 4;
const _minPatternLength = 4;

Future<String?> showLocalCodeDialog(BuildContext context, Authentication method, {String? expected}) {
  final pattern = method == Authentication.pattern;
  if (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      enableDrag: !pattern,
      builder: (context) => LocalCodeDialog(pattern: pattern, expected: expected, sheet: true),
    );
  }
  return showDialog<String>(
    context: context,
    builder: (context) => LocalCodeDialog(pattern: pattern, expected: expected),
  );
}

Future<bool> verifyLocalCode(BuildContext context, AccountModel user) async =>
    await showLocalCodeDialog(context, user.authMethod, expected: user.localPin) != null;

class LocalCodeDialog extends StatefulWidget {
  final bool pattern;
  final String? expected;
  final bool sheet;
  const LocalCodeDialog({required this.pattern, this.expected, this.sheet = false, super.key});

  @override
  State<LocalCodeDialog> createState() => _LocalCodeDialogState();
}

class _LocalCodeDialogState extends State<LocalCodeDialog> with SingleTickerProviderStateMixin {
  late final shake = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  String? firstEntry;
  String? error;
  bool busy = false;
  int attempt = 0;

  @override
  void dispose() {
    shake.dispose();
    super.dispose();
  }

  Future<void> onCompleted(String code) async {
    if (busy) return;
    final l = context.localized;
    if (widget.pattern && code.length < _minPatternLength) return reject(l.patternTooShort);
    final expected = widget.expected;
    if (expected != null) {
      if (code == expected) return accept(code);
      return reject(widget.pattern ? l.incorrectPatternTryAgain : l.incorrectPinTryAgain);
    }
    if (firstEntry == null) {
      setState(() {
        firstEntry = code;
        error = null;
        attempt++;
      });
      return;
    }
    if (code == firstEntry) return accept(code);
    firstEntry = null;
    reject(l.codeMismatch);
  }

  void accept(String code) {
    busy = true;
    HapticFeedback.lightImpact();
    Navigator.of(context).pop(code);
  }

  Future<void> reject(String message) async {
    HapticFeedback.heavyImpact();
    setState(() {
      busy = true;
      error = message;
    });
    await shake.forward(from: 0);
    if (!mounted) return;
    setState(() {
      busy = false;
      attempt++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localized;
    final theme = Theme.of(context);
    final title = widget.pattern
        ? (firstEntry == null ? l.drawPattern : l.confirmPattern)
        : (firstEntry == null ? l.enterPin : l.confirmPin);
    final content = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: SingleChildScrollView(
        physics: widget.pattern ? const NeverScrollableScrollPhysics() : null,
        padding: widget.sheet ? const EdgeInsets.fromLTRB(24, 0, 24, 24) : const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(title, style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
            AnimatedBuilder(
              animation: shake,
              builder: (context, child) => Transform.translate(
                offset: Offset(math.sin(shake.value * math.pi * 6) * 12 * (1 - shake.value), 0),
                child: child,
              ),
              child: widget.pattern
                  ? PatternInput(key: ValueKey(attempt), error: busy, onCompleted: onCompleted)
                  : PinInput(key: ValueKey(attempt), error: busy, onCompleted: onCompleted),
            ),
            Text(
              error ?? "",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
            ),
          ],
        ),
      ),
    );
    return widget.sheet ? Center(heightFactor: 1, child: content) : Dialog(child: content);
  }
}

class PinInput extends StatefulWidget {
  final bool error;
  final ValueChanged<String> onCompleted;
  const PinInput({required this.error, required this.onCompleted, super.key});

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  var code = "";

  bool get locked => widget.error || code.length >= _pinLength;

  void add(String digit) {
    if (locked) return;
    HapticFeedback.selectionClick();
    setState(() => code += digit);
    if (code.length == _pinLength) widget.onCompleted(code);
  }

  void backspace() {
    if (locked || code.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => code = code.substring(0, code.length - 1));
  }

  void clear() {
    if (locked || code.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => code = "");
  }

  KeyEventResult onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final digit = int.tryParse(event.character ?? "");
    if (digit != null) {
      add("$digit");
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.backspace || event.logicalKey == LogicalKeyboardKey.delete) {
      backspace();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold);
    final dPad = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;

    Widget digitKey(int digit) => _PadKey(
          autofocus: dPad && digit == 5,
          background: scheme.surfaceContainerHighest,
          foreground: scheme.onSurface,
          onPressed: () => add("$digit"),
          child: Text("$digit", style: textStyle),
        );

    Widget keyRow(List<Widget> keys) => Row(
          spacing: 12,
          children: keys.map((key) => Expanded(child: SizedBox(height: 64, child: key))).toList(),
        );

    return Focus(
      autofocus: !dPad,
      skipTraversal: true,
      onKeyEvent: onKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: List.generate(_pinLength, (index) {
                final color = widget.error
                    ? scheme.error
                    : index < code.length
                        ? scheme.primary
                        : null;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color ?? Colors.transparent,
                    border: Border.all(width: 2, color: color ?? scheme.outline),
                  ),
                );
              }),
            ),
          ),
          for (final row in const [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
          ])
            keyRow(row.map(digitKey).toList()),
          keyRow([
            _PadKey(
              background: scheme.errorContainer,
              foreground: scheme.onErrorContainer,
              onPressed: clear,
              child: const Icon(Icons.clear_rounded, size: 32),
            ),
            digitKey(0),
            _PadKey(
              background: scheme.primaryContainer,
              foreground: scheme.onPrimaryContainer,
              onPressed: backspace,
              child: const Icon(Icons.backspace_rounded, size: 28),
            ),
          ]),
        ],
      ),
    );
  }
}

class _PadKey extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color background;
  final Color foreground;
  final bool autofocus;
  const _PadKey({
    required this.child,
    required this.onPressed,
    required this.background,
    required this.foreground,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return FocusButton(
      autoFocus: autofocus,
      borderRadius: radius,
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(color: background, borderRadius: radius),
        child: IconTheme.merge(
          data: IconThemeData(color: foreground),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: foreground),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class PatternInput extends StatefulWidget {
  final bool error;
  final ValueChanged<String> onCompleted;
  const PatternInput({required this.error, required this.onCompleted, super.key});

  @override
  State<PatternInput> createState() => _PatternInputState();
}

class _PatternInputState extends State<PatternInput> with SingleTickerProviderStateMixin {
  late final ticker = createTicker(onTick);
  final clock = Stopwatch()..start();
  final List<int> nodes = [];
  final List<Duration> activatedAt = [];
  Duration lastEvent = Duration.zero;
  Duration? errorAt;
  Offset? finger;
  bool done = false;

  @override
  void initState() {
    super.initState();
    kick();
  }

  @override
  void didUpdateWidget(covariant PatternInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error && !oldWidget.error) {
      errorAt = clock.elapsed;
      kick();
    }
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void kick() {
    lastEvent = clock.elapsed;
    if (!ticker.isActive) ticker.start();
  }

  void onTick(Duration _) {
    setState(() {});
    if (finger == null && clock.elapsed - lastEvent > const Duration(milliseconds: 800)) ticker.stop();
  }

  void addNode(int node) {
    nodes.add(node);
    activatedAt.add(clock.elapsed);
  }

  void track(Offset position, double side) {
    if (widget.error || done) return;
    final cell = side / 3;
    final col = (position.dx / cell).floor();
    final row = (position.dy / cell).floor();
    final inGrid = col >= 0 && col < 3 && row >= 0 && row < 3;
    final center = Offset((col + 0.5) * cell, (row + 0.5) * cell);
    final node = row * 3 + col;
    if (inGrid && (position - center).distance < cell * 0.35 && !nodes.contains(node)) {
      if (nodes.isNotEmpty) {
        final rows = nodes.last ~/ 3 + row;
        final cols = nodes.last % 3 + col;
        final middle = rows ~/ 2 * 3 + cols ~/ 2;
        if (rows.isEven && cols.isEven && !nodes.contains(middle)) addNode(middle);
      }
      addNode(node);
      HapticFeedback.selectionClick();
    }
    finger = position;
    kick();
  }

  void finish() {
    if (widget.error || done) return;
    finger = null;
    done = nodes.isNotEmpty;
    kick();
    if (done) widget.onCompleted(nodes.join());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final side = (MediaQuery.sizeOf(context).height - 220).clamp(150.0, 280.0);
    final now = clock.elapsed;
    final errorProgress = errorAt == null ? 0.0 : ((now - errorAt!).inMilliseconds / 150).clamp(0.0, 1.0);
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.down,
      onPanDown: (details) => track(details.localPosition, side),
      onPanUpdate: (details) => track(details.localPosition, side),
      onPanEnd: (_) => finish(),
      onPanCancel: finish,
      child: CustomPaint(
        size: Size.square(side),
        painter: _PatternPainter(
          nodes: List.of(nodes),
          activatedAt: List.of(activatedAt),
          now: now,
          finger: finger,
          active: Color.lerp(scheme.primary, scheme.error, errorProgress)!,
          idle: scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final List<int> nodes;
  final List<Duration> activatedAt;
  final Duration now;
  final Offset? finger;
  final Color active;
  final Color idle;
  const _PatternPainter({
    required this.nodes,
    required this.activatedAt,
    required this.now,
    required this.finger,
    required this.active,
    required this.idle,
  });

  double progress(Duration since, int milliseconds) => ((now - since).inMilliseconds / milliseconds).clamp(0.0, 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 3;
    Offset center(int node) => Offset((node % 3 + 0.5) * cell, (node ~/ 3 + 0.5) * cell);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = cell * 0.06
      ..strokeCap = StrokeCap.round;

    for (var i = 1; i < nodes.length; i++) {
      final from = center(nodes[i - 1]);
      final grow = Curves.easeOut.transform(progress(activatedAt[i], 120));
      canvas.drawLine(from, Offset.lerp(from, center(nodes[i]), grow)!, line..color = active.withValues(alpha: 0.5));
    }

    if (finger != null && nodes.isNotEmpty) {
      final from = center(nodes.last);
      canvas.drawLine(
        from,
        finger!,
        line
          ..shader = ui.Gradient.linear(from, finger!, [active.withValues(alpha: 0.5), active.withValues(alpha: 0.05)]),
      );
    }

    final idleRadius = cell * 0.07;
    final selectedRadius = cell * 0.1;
    for (var node = 0; node < 9; node++) {
      final appear = Curves.easeOutBack.transform(
        progress(Duration(milliseconds: node ~/ 3 * 70 + node % 3 * 35), 350),
      );
      final index = nodes.indexOf(node);
      if (index == -1) {
        canvas.drawCircle(
          center(node),
          idleRadius * appear,
          Paint()..color = idle.withValues(alpha: appear.clamp(0.0, 1.0)),
        );
        continue;
      }
      final since = activatedAt[index];
      final ripple = progress(since, 450);
      if (ripple < 1) {
        canvas.drawCircle(
          center(node),
          ui.lerpDouble(selectedRadius, cell * 0.34, Curves.easeOutCubic.transform(ripple))!,
          Paint()..color = active.withValues(alpha: 0.3 * (1 - ripple)),
        );
      }
      final pop = progress(since, 250);
      final radius = ui.lerpDouble(idleRadius, selectedRadius, Curves.easeOut.transform(pop))! +
          cell * 0.06 * math.sin(math.pi * pop);
      canvas.drawCircle(center(node), radius, Paint()..color = active);
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) => true;
}
