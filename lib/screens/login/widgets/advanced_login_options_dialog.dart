import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

Future<String?> showAdvancedLoginOptionsDialog(
  BuildContext context, {
  String? initialSeerrUrl,
  bool hasSeerrUrl = false,
}) async {
  return await showDialog<String>(
    context: context,
    builder: (context) => _AdvancedLoginOptionsDialog(
      initialSeerrUrl: initialSeerrUrl,
      hasSeerrUrl: hasSeerrUrl,
    ),
  );
}

class _AdvancedLoginOptionsDialog extends ConsumerStatefulWidget {
  final String? initialSeerrUrl;
  final bool hasSeerrUrl;

  const _AdvancedLoginOptionsDialog({this.initialSeerrUrl, this.hasSeerrUrl = false});

  @override
  ConsumerState<_AdvancedLoginOptionsDialog> createState() => _AdvancedLoginOptionsDialogState();
}

class _AdvancedLoginOptionsDialogState extends ConsumerState<_AdvancedLoginOptionsDialog> {
  late final TextEditingController seerrUrlController = TextEditingController(text: widget.initialSeerrUrl ?? '');
  bool _probing = false;

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
              enabled: !widget.hasSeerrUrl,
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
          onPressed: _probing ? null : _save,
          child: _probing
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(context.localized.save),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final url = seerrUrlController.text.trim();
    if (url.isEmpty) {
      Navigator.of(context).pop(url);
      return;
    }
    final hasScheme = url.startsWith('http://') || url.startsWith('https://');
    if (!hasScheme) {
      setState(() => _probing = true);
      final httpsUrl = normalizeUrl('https://$url');
      final httpUrl = normalizeUrl('http://$url');
      final result = await probeSeerrUrl(httpsUrl) ?? await probeSeerrUrl(httpUrl);
      if (!mounted) return;
      setState(() => _probing = false);
      if (result != null) {
        Navigator.of(context).pop(result);
      } else {
        Navigator.of(context).pop(normalizeUrl(url));
      }
    } else {
      Navigator.of(context).pop(normalizeUrl(url));
    }
  }
}
