import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/outlined_text_field.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: OutlinedTextField(
        controller: controller ?? TextEditingController(text: (value ?? 0).toString()),
        keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        onSubmitted: (value) => onSubmitted?.call(int.tryParse(value)),
        textAlign: TextAlign.center,
        suffix: suffix,
        placeHolder: placeHolder,
      ),
    );
  }
}
