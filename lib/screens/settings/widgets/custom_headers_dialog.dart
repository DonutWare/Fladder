import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/custom_headers_editor.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

/// Lets a logged in user edit the headers that are sent along with every
/// request to their Jellyfin server.
Future<void> showCustomHeadersDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const _CustomHeadersDialog(),
  );
}

class _CustomHeadersDialog extends ConsumerStatefulWidget {
  const _CustomHeadersDialog();

  @override
  ConsumerState<_CustomHeadersDialog> createState() => _CustomHeadersDialogState();
}

class _CustomHeadersDialogState extends ConsumerState<_CustomHeadersDialog> {
  late Map<String, String> customHeaders = Map.of(ref.read(userProvider)?.credentials.customHeaders ?? const {});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(IconsaxPlusLinear.code),
          const SizedBox(width: 12),
          Flexible(child: Text(context.localized.customHeaders)),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: CustomHeadersEditor(
            headers: customHeaders,
            onChanged: (value) => customHeaders = value,
          ),
        ),
      ),
      actions: [
        TextButton(
          autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
        FilledButton(
          onPressed: () {
            ref.read(userProvider.notifier).setCustomHeaders(customHeaders);
            Navigator.of(context).pop();
          },
          child: Text(context.localized.save),
        ),
      ],
    );
  }
}
