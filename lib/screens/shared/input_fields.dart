import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 60,
        maxWidth: 135,
      ),
      child: Padding(
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
      ),
    );
  }
}

Future<void> openSimpleTextInput(
  BuildContext context,
  String? value,
  Function(String result) onChanged,
  String title,
  String description,
) {
  return showDialog(
    context: context,
    builder: (context) => _TextInputFieldDialog(
      value: value,
      title: title,
      description: description,
      onChanged: onChanged,
    ),
  );
}

class _TextInputFieldDialog extends ConsumerWidget {
  final String? value;
  final String title;
  final String description;
  final Function(String result) onChanged;
  const _TextInputFieldDialog({
    this.value,
    required this.title,
    required this.description,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(6),
              children: [
                OutlinedTextField(
                  controller: TextEditingController(text: value),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    onChanged.call(value);
                    context.pop();
                  },
                  textAlign: TextAlign.start,
                  placeHolder: "http://192.168.1.1:8096, 192.168.1.1:8096",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
