import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedVisibilityIcon extends StatefulWidget {
  final bool isFilled;
  final IconData filledIcon;
  final Color filledColor;
  final IconData outlinedIcon;
  final Color? outlinedColor;
  final Duration displayDuration;

  const AnimatedVisibilityIcon({
    super.key,
    required this.isFilled,
    required this.filledIcon,
    this.filledColor = Colors.redAccent,
    required this.outlinedIcon,
    this.outlinedColor,
    this.displayDuration = const Duration(seconds: 2),
  });

  @override
  AnimatedVisibilityIconState createState() => AnimatedVisibilityIconState();
}

class AnimatedVisibilityIconState extends State<AnimatedVisibilityIcon> {
  bool _isVisible = false;
  bool _currentFilledState = false;

  Timer? timer;

  @override
  void didUpdateWidget(covariant AnimatedVisibilityIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFilled != oldWidget.isFilled) {
      _animateIconChange();
    }
  }

  void _animateIconChange() {
    timer?.cancel();
    setState(() {
      _isVisible = true;
      _currentFilledState = widget.isFilled;
    });

    timer = Timer.periodic(
      widget.displayDuration,
      (timer) {
        if (mounted) {
          setState(() {
            _isVisible = false;
          });
        }
        timer.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: _currentFilledState ? 1.2 : 1.0,
      curve: Curves.easeInOutCubic,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: (_currentFilledState ? widget.filledColor : widget.outlinedColor)?.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 6),
              child: Icon(
                _currentFilledState ? widget.filledIcon : widget.outlinedIcon,
                size: 42,
                color: _currentFilledState ? widget.filledColor : widget.outlinedColor,
                key: ValueKey<bool>(_currentFilledState),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
