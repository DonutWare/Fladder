import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/update_checker.dart';

class AdaptiveRangeInput extends StatefulWidget {
  const AdaptiveRangeInput({
    super.key,
    required this.min,
    required this.max,
    this.start,
    this.end,
    required this.onChanged,
    this.divisions,
    this.labels,
    this.wholeNumbers = false,
    this.allowEmpty = false,
  });

  final double min;
  final double max;
  final double? start;
  final double? end;
  final int? divisions;
  final RangeLabels? labels;
  final bool wholeNumbers;
  final bool allowEmpty;
  final void Function(double? start, double? end) onChanged;

  @override
  State<AdaptiveRangeInput> createState() => _AdaptiveRangeInputState();
}

class _AdaptiveRangeInputState extends State<AdaptiveRangeInput> {
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController(text: _formatValue(widget.start));
    _endController = TextEditingController(text: _formatValue(widget.end));
  }

  @override
  void didUpdateWidget(covariant AdaptiveRangeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.start != widget.start) {
      _startController.text = _formatValue(widget.start);
    }
    if (oldWidget.end != widget.end) {
      _endController.text = _formatValue(widget.end);
    }
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDevice = AdaptiveLayout.inputDeviceOf(context);
    final useTextFields = inputDevice == InputDevice.dPad;

    if (!useTextFields) {
      final sliderStart = (widget.start ?? widget.min).clamp(widget.min, widget.max);
      final sliderEnd = (widget.end ?? widget.max).clamp(widget.min, widget.max);

      return RangeSlider(
        values: RangeValues(sliderStart, sliderEnd),
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        labels: widget.labels,
        onChanged: (values) {
          if (widget.end == null && widget.allowEmpty && values.end == widget.max) {
            widget.onChanged(values.start, null);
            return;
          }
          widget.onChanged(values.start, values.end);
        },
      );
    }

    return Row(
      spacing: 12,
      children: [
        Expanded(child: _buildField(_startController, true)),
        Expanded(child: _buildField(_endController, false)),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, bool isStart) {
    return OutlinedTextField(
      controller: controller,
      keyboardType: widget.wholeNumbers
          ? const TextInputType.numberWithOptions(decimal: false, signed: false)
          : const TextInputType.numberWithOptions(decimal: true, signed: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          widget.wholeNumbers ? RegExp(r'[0-9]') : RegExp(r'[0-9.,]'),
        ),
      ],
      label: isStart ? context.localized.min.capitalize() : context.localized.max.capitalize(),
      onSubmitted: (_) => _commitValues(),
    );
  }

  void _commitValues() {
    final parsedStart = _parseValue(_startController.text);
    final parsedEnd = _parseValue(_endController.text);

    double? start = parsedStart;
    double? end = parsedEnd;

    if (!widget.allowEmpty && (start == null || end == null)) {
      return;
    }

    if (widget.wholeNumbers) {
      start = start?.roundToDouble();
      end = end?.roundToDouble();
    }

    start = start?.clamp(widget.min, widget.max);
    end = end?.clamp(widget.min, widget.max);

    if (_formatValue(start) != _startController.text) {
      _startController.text = _formatValue(start);
    }
    if (_formatValue(end) != _endController.text) {
      _endController.text = _formatValue(end);
    }

    widget.onChanged(start, end);
  }

  String _formatValue(double? value) {
    if (value == null && widget.allowEmpty) return '';
    final safeValue = value ?? widget.min;
    return widget.wholeNumbers ? safeValue.round().toString() : safeValue.toStringAsFixed(1);
  }

  double? _parseValue(String raw) {
    final normalized = raw.replaceAll(',', '.');
    if (normalized.trim().isEmpty) return null;
    return double.tryParse(normalized);
  }
}
