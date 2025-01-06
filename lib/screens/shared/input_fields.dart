import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntInputField extends ConsumerWidget {
  final int? value;
  final TextEditingController? controller;
  final String? placeHolder;
  final String? suffix;
  final Function(int? value)? onSubmitted;
  const IntInputField({
    this.value,
    this.controller,
    this.suffix,
    this.placeHolder,
    this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.25),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: TextField(
          controller: controller ?? TextEditingController(text: (value ?? 0).toString()),
          keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.done,
          onSubmitted: (value) => onSubmitted?.call(int.tryParse(value)),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            hintText: placeHolder,
            suffixText: suffix,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
