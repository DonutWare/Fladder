import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

Future<String?> showAdvancedLoginOptionsDialog(BuildContext context, {String? initialSeerrUrl}) async {
  return await showDialog<String>(
    context: context,
    builder: (context) => _AdvancedLoginOptionsDialog(initialSeerrUrl: initialSeerrUrl),
  );
}

class _AdvancedLoginOptionsDialog extends ConsumerStatefulWidget {
  final String? initialSeerrUrl;

  const _AdvancedLoginOptionsDialog({this.initialSeerrUrl});

  @override
  ConsumerState<_AdvancedLoginOptionsDialog> createState() => _AdvancedLoginOptionsDialogState();
}

class _AdvancedLoginOptionsDialogState extends ConsumerState<_AdvancedLoginOptionsDialog> {
  late final TextEditingController seerrUrlController = TextEditingController(text: widget.initialSeerrUrl ?? '');

  @override
  void dispose() {
    seerrUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(IconsaxPlusLinear.setting_3),
          const SizedBox(width: 12),
          Text(context.localized.advanced),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            OutlinedTextField(
              controller: seerrUrlController,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              autoFillHints: const [AutofillHints.url],
              autocorrect: false,
              label: context.localized.seerrServer,
              onSubmitted: (_) => _save(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(context.localized.save),
        ),
      ],
    );
  }

  void _save() {
    Navigator.of(context).pop(seerrUrlController.text.trim());
  }
}
