import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChapterTimeline extends StatefulWidget {
  final List<Chapter> chapters;
  final Function(Chapter)? onPressed;

  const ChapterTimeline({required this.chapters, required this.onPressed, super.key});

  @override
  State<ChapterTimeline> createState() => _ChapterTimelineState();
}

class _ChapterTimelineState extends State<ChapterTimeline> with SingleTickerProviderStateMixin {
  int? hoveredIndex;
  late final AnimationController fillController;
  double fillProgress = 0;
  double fillStart = 0;
  double fillTarget = 0;

  @override
  void initState() {
    super.initState();
    fillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(updateFillProgress);
  }

  void updateFillProgress() {
    if (!mounted) return;
    final curveProgress = Curves.easeInOut.transform(fillController.value);
    setState(() => fillProgress = fillStart + (fillTarget - fillStart) * curveProgress);
  }

  void animateFillTo(double target) {
    fillStart = fillProgress;
    fillTarget = target;
    fillController.forward(from: 0);
  }

  @override
  void dispose() {
    fillController.dispose();
    super.dispose();
  }

  void updateHoveredIndex(PointerHoverEvent event, double columnWidth) {
    final index = event.localPosition.dx ~/ columnWidth;
    if (hoveredIndex != index) {
      setState(() => hoveredIndex = index);
      animateFillTo(index + 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final baseColor = colorScheme.surfaceContainerHigh;
    final hoverColor = colorScheme.primary;
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = 12 +
            widget.chapters
                    .mapIndexed((i, c) => TextPainter.computeWidth(
                          text: TextSpan(text: c.name + (i == 0 ? '' : widget.chapters[i - 1].name), style: textStyle),
                          textDirection: Directionality.of(context),
                        ))
                    .max /
                2;
        final timelineWidth = columnWidth * widget.chapters.length;
        final visibleWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : timelineWidth;
        final contentWidth = max(visibleWidth, timelineWidth);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: contentWidth,
            child: MouseRegion(
              onHover: (event) => updateHoveredIndex(event, columnWidth),
              onExit: (_) {
                setState(() => hoveredIndex = null);
                animateFillTo(0);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) {
                  if (widget.onPressed == null) return;
                  final index = details.localPosition.dx ~/ columnWidth;
                  widget.onPressed!(widget.chapters[index]);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _ChapterLabels(
                      chapters: widget.chapters,
                      columnWidth: columnWidth,
                      labelBuilder: (chapter) => chapter.name,
                      color: hoverColor,
                      textStyle: textStyle,
                    ),
                    SizedBox(
                      width: contentWidth,
                      height: 32,
                      child: CustomPaint(
                        painter: _ChapterTimelinePainter(
                          chapterCount: widget.chapters.length,
                          columnWidth: columnWidth,
                          fillProgress: fillProgress,
                          baseColor: baseColor,
                          hoverColor: hoverColor,
                        ),
                      ),
                    ),
                    _ChapterLabels(
                      chapters: widget.chapters,
                      columnWidth: columnWidth,
                      labelBuilder: (chapter) => chapter.startPosition.humanize ?? context.localized.start,
                      color: hoverColor,
                      textStyle: textStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChapterLabels extends StatelessWidget {
  final List<Chapter> chapters;
  final double columnWidth;
  final String Function(Chapter) labelBuilder;
  final Color color;
  final TextStyle? textStyle;

  const _ChapterLabels({
    required this.chapters,
    required this.columnWidth,
    required this.labelBuilder,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: chapters
          .map(
            (chapter) => SizedBox(
              width: columnWidth,
              height: 24,
              child: OverflowBox(
                alignment: Alignment.center,
                minWidth: 0,
                maxWidth: double.infinity,
                child: Text(
                  labelBuilder(chapter),
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: textStyle?.copyWith(color: color, overflow: TextOverflow.visible),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ChapterTimelinePainter extends CustomPainter {
  final int chapterCount;
  final double columnWidth;
  final double fillProgress;
  final Color baseColor;
  final Color hoverColor;

  const _ChapterTimelinePainter({
    required this.chapterCount,
    required this.columnWidth,
    required this.fillProgress,
    required this.baseColor,
    required this.hoverColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const circleRadius = 8.0;
    final centerY = size.height / 2;
    final centers = List.generate(chapterCount, (index) => Offset(columnWidth * (index + 0.5), centerY));

    final linePaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    for (var index = 0; index < centers.length - 1; index++) {
      final lineStart = centers[index] + const Offset(circleRadius, 0);
      final lineEnd = centers[index + 1] - const Offset(circleRadius, 0);
      linePaint.color = baseColor;
      canvas.drawLine(lineStart, lineEnd, linePaint);

      final lineProgress = (fillProgress - index - 1).clamp(0.0, 1.0);
      if (lineProgress > 0) {
        linePaint.color = hoverColor;
        canvas.drawLine(lineStart, Offset.lerp(lineStart, lineEnd, lineProgress)!, linePaint);
      }
    }

    final circlePaint = Paint()..strokeWidth = 6;

    for (var index = 0; index < centers.length; index++) {
      final isLeftOfHover = fillProgress != 0 && index <= fillProgress - 1;
      circlePaint
        ..color = isLeftOfHover ? hoverColor : baseColor
        ..style = isLeftOfHover ? PaintingStyle.fill : PaintingStyle.stroke;
      canvas.drawCircle(centers[index], circleRadius + (isLeftOfHover ? 3 : 0), circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChapterTimelinePainter oldDelegate) {
    return chapterCount != oldDelegate.chapterCount ||
        columnWidth != oldDelegate.columnWidth ||
        fillProgress != oldDelegate.fillProgress ||
        baseColor != oldDelegate.baseColor ||
        hoverColor != oldDelegate.hoverColor;
  }
}
