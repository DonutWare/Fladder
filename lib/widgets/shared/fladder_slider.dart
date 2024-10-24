import 'package:flutter/material.dart';

import 'package:fladder/util/num_extension.dart';
import 'package:fladder/widgets/gapped_container_shape.dart';

double normalize(double min, double max, double value) {
  return (value - min) / (max - min);
}

class FladderSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final double thumbWidth;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final bool showThumb;
  final Duration animation;
  final Function(double value)? onChanged;
  final Function(double value)? onChangeStart;
  final Function(double value)? onChangeEnd;

  const FladderSlider({
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.onChanged,
    this.thumbWidth = 6.5,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.showThumb = true,
    this.animation = const Duration(milliseconds: 100),
    this.onChangeStart,
    this.onChangeEnd,
    super.key,
  }) : assert(value >= min || value <= max);

  @override
  FladderSliderState createState() => FladderSliderState();
}

class FladderSliderState extends State<FladderSlider> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentValue = 0.0;
  bool hovering = false;
  bool dragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _controller = AnimationController(vsync: this, duration: widget.animation);
    _animation = Tween<double>(begin: widget.value, end: widget.value).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant FladderSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value || oldWidget.divisions != widget.divisions) {
      double newValue = widget.value;

      if (widget.divisions != null) {
        final stepSize = (widget.max - widget.min) / widget.divisions!;
        newValue = ((newValue - widget.min) / stepSize).round() * stepSize + widget.min;
      }

      setState(() {
        _currentValue = newValue;
      });

      _animation = Tween<double>(begin: _animation.value, end: _currentValue).animate(_controller);
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double normalize(double min, double max, double value) {
    return (value - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final thumbWidth = widget.thumbWidth;
    final height = Theme.of(context).sliderTheme.trackHeight ?? 24.0;

    double calculateChange(double offset, double width) {
      double relativeOffset = (offset / width).clamp(0.0, 1.0);
      double newValue = (widget.max - widget.min) * relativeOffset + widget.min;

      if (widget.divisions != null) {
        final stepSize = (widget.max - widget.min) / widget.divisions!;
        newValue = ((newValue - widget.min) / stepSize).round() * stepSize + widget.min;
      }

      setState(() {
        _currentValue = newValue.clamp(widget.min, widget.max);
      });

      return _currentValue.roundTo(2);
    }

    return Container(
      height: height * 4,
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final divisionSize = 5.0 * 0.95;
          final stepSize = constraints.maxWidth / (widget.divisions ?? 1);
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) => setState(() => hovering = true),
            onExit: (event) => setState(() => hovering = false),
            child: GestureDetector(
              onTapUp: (details) => widget.onChangeEnd?.call(calculateChange(details.localPosition.dx, width)),
              onTapDown: (details) => widget.onChanged?.call(calculateChange(details.localPosition.dx, width)),
              onHorizontalDragStart: (details) {
                setState(() {
                  dragging = true;
                });
                widget.onChangeStart?.call(calculateChange(details.localPosition.dx, width));
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  dragging = false;
                });
                widget.onChangeEnd?.call(calculateChange(details.localPosition.dx, width));
              },
              onHorizontalDragUpdate: (details) =>
                  widget.onChanged?.call(calculateChange(details.localPosition.dx, width)),
              child: Container(
                color: Colors.transparent,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final relativeValue = normalize(widget.min, widget.max, _animation.value);
                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: height,
                          width: constraints.maxWidth,
                          child: GappedContainerShape(
                            activeColor: widget.activeTrackColor,
                            inActiveColor: widget.inactiveTrackColor,
                            thumbPosition: relativeValue,
                          ),
                        ),
                        if (widget.divisions != null && stepSize > divisionSize * 3)
                          ...List.generate(
                            widget.divisions! + 1,
                            (index) {
                              final offset = (stepSize * index)
                                  .clamp(divisionSize / 1.2, constraints.maxWidth - divisionSize / 1.2);
                              final active = (1.0 / widget.divisions!) * index > relativeValue;
                              return Positioned(
                                left: offset - divisionSize / 2,
                                child: Container(
                                  width: divisionSize,
                                  height: divisionSize,
                                  decoration: BoxDecoration(
                                    color: active
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          ),
                        // Thumb
                        if (widget.showThumb)
                          Positioned(
                            left:
                                (width * relativeValue).clamp(thumbWidth / 2, width - thumbWidth / 2) - thumbWidth / 2,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 125),
                              height: (hovering || dragging) ? height * 3 : height,
                              width: thumbWidth,
                              decoration: BoxDecoration(
                                color: (hovering || dragging)
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
