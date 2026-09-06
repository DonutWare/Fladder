import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_message_box.dart';
import 'package:fladder/screens/shared/custom_headers_editor.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_config.dart';
import 'package:fladder/util/localization_helper.dart';

/// Options gathered by [showAdvancedLoginOptionsDialog].
class AdvancedLoginOptions {
  const AdvancedLoginOptions({
    required this.seerrUrl,
    required this.customHeaders,
  });

  final String seerrUrl;
  final Map<String, String> customHeaders;
}

Future<AdvancedLoginOptions?> showAdvancedLoginOptionsDialog(
  BuildContext context, {
  String? initialSeerrUrl,
  Map<String, String> initialCustomHeaders = const {},
}) async {
  return await showDialog<AdvancedLoginOptions>(
    context: context,
    builder: (context) => _AdvancedLoginOptionsDialog(
      initialSeerrUrl: initialSeerrUrl,
      initialCustomHeaders: initialCustomHeaders,
    ),
  );
}

class _AdvancedLoginOptionsDialog extends ConsumerStatefulWidget {
  final String? initialSeerrUrl;
  final Map<String, String> initialCustomHeaders;

  const _AdvancedLoginOptionsDialog({
    this.initialSeerrUrl,
    this.initialCustomHeaders = const {},
  });

  @override
  ConsumerState<_AdvancedLoginOptionsDialog> createState() => _AdvancedLoginOptionsDialogState();
}

class _AdvancedLoginOptionsDialogState extends ConsumerState<_AdvancedLoginOptionsDialog> {
  late final TextEditingController seerrUrlController = TextEditingController(text: widget.initialSeerrUrl ?? '');
  late Map<String, String> customHeaders = Map.of(widget.initialCustomHeaders);
  bool _probing = false;
  String? _warning;

  bool get _hasPresetSeerrBaseUrl => FladderConfig.seerrBaseUrl?.isNotEmpty == true;

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              if (_warning != null) SettingsMessageBox(_warning!, messageType: MessageType.warning),
              if (!_hasPresetSeerrBaseUrl)
                OutlinedTextField(
                  controller: seerrUrlController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  autoFillHints: const [AutofillHints.url],
                  autocorrect: false,
                  label: context.localized.seerrServer,
                  onSubmitted: (_) => _save(),
                ),
              SettingsLabelDivider(label: context.localized.customHeaders),
              CustomHeadersEditor(
                headers: customHeaders,
                onChanged: (value) => customHeaders = value,
              ),
            ],
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
          onPressed: _probing ? null : _save,
          child: _probing
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(context.localized.save),
        ),
      ],
    );
  }

  void _pop(String seerrUrl) => Navigator.of(context).pop(
        AdvancedLoginOptions(seerrUrl: seerrUrl, customHeaders: customHeaders),
      );

  Future<void> _save() async {
    if (_hasPresetSeerrBaseUrl) {
      _pop('');
      return;
    }
    final url = seerrUrlController.text.trim();
    if (url.isEmpty) {
      _pop(url);
      return;
    }
    setState(() {
      _probing = true;
      _warning = null;
    });
    try {
      final result = await probeAndNormalizeUrl(url, probeSeerrUrl);
      if (!mounted) return;
      if (result.probed) {
        _pop(result.url);
      } else {
        seerrUrlController.text = result.url;
        _warning = context.localized.seerrUrlSchemeWarning;
      }
    } finally {
      if (mounted) setState(() => _probing = false);
    }
  }
}
