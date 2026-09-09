import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';

const cloudflareAccessClientIdHeader = 'CF-Access-Client-Id';
const cloudflareAccessClientSecretHeader = 'CF-Access-Client-Secret';

const _cloudflareAccessHeaders = {cloudflareAccessClientIdHeader, cloudflareAccessClientSecretHeader};

/// Shape of the header input: a known proxy whose header names are filled in
/// for the user, or free-form entry.
enum CustomHeaderPreset {
  cloudflareAccess,
  custom;

  String label(BuildContext context) => switch (this) {
        CustomHeaderPreset.cloudflareAccess => context.localized.customHeaderPresetCloudflare,
        CustomHeaderPreset.custom => context.localized.customHeaderPresetCustom,
      };
}

/// Holds the headers being edited by a [CustomHeadersEditor].
///
/// [headers] includes whatever is still sitting in the input fields, so saving
/// without pressing add never throws away what was typed.
class CustomHeadersController extends ChangeNotifier {
  CustomHeadersController({Map<String, String> headers = const {}}) : _headers = Map.of(headers) {
    _preset = _headers.keys.any(_cloudflareAccessHeaders.contains) || _headers.isEmpty
        ? CustomHeaderPreset.cloudflareAccess
        : CustomHeaderPreset.custom;
    clientId = TextEditingController(text: _headers[cloudflareAccessClientIdHeader] ?? '');
    clientSecret = TextEditingController(text: _headers[cloudflareAccessClientSecretHeader] ?? '');
  }

  final Map<String, String> _headers;
  late final TextEditingController clientId;
  late final TextEditingController clientSecret;
  final TextEditingController name = TextEditingController();
  final TextEditingController value = TextEditingController();
  late CustomHeaderPreset _preset;

  CustomHeaderPreset get preset => _preset;

  set preset(CustomHeaderPreset next) {
    if (next == _preset) return;
    // Keep what was typed under the preset we are leaving.
    _applyPending(_headers);
    _preset = next;
    if (next == CustomHeaderPreset.cloudflareAccess) {
      clientId.text = _headers[cloudflareAccessClientIdHeader] ?? '';
      clientSecret.text = _headers[cloudflareAccessClientSecretHeader] ?? '';
    } else {
      name.clear();
      value.clear();
    }
    notifyListeners();
  }

  Map<String, String> get headers => _applyPending(Map<String, String>.of(_headers));

  /// Headers to show as chips: the ones the current preset has no field for.
  Map<String, String> get listedHeaders {
    final listed = headers;
    if (_preset == CustomHeaderPreset.cloudflareAccess) {
      listed.removeWhere((header, _) => _cloudflareAccessHeaders.contains(header));
    }
    return listed;
  }

  Map<String, String> _applyPending(Map<String, String> target) {
    switch (_preset) {
      case CustomHeaderPreset.cloudflareAccess:
        _put(target, cloudflareAccessClientIdHeader, clientId.text);
        _put(target, cloudflareAccessClientSecretHeader, clientSecret.text);
      case CustomHeaderPreset.custom:
        final header = name.text.trim();
        if (header.isNotEmpty) target[header] = value.text.trim();
    }
    return target;
  }

  static void _put(Map<String, String> target, String header, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      target.remove(header);
    } else {
      target[header] = trimmed;
    }
  }

  /// Moves whatever is in the input fields into the header list.
  void commitPending() {
    _applyPending(_headers);
    if (_preset == CustomHeaderPreset.custom) {
      name.clear();
      value.clear();
    }
    notifyListeners();
  }

  void remove(String header) {
    _headers.remove(header);
    if (header == cloudflareAccessClientIdHeader) clientId.clear();
    if (header == cloudflareAccessClientSecretHeader) clientSecret.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    clientId.dispose();
    clientSecret.dispose();
    name.dispose();
    value.dispose();
    super.dispose();
  }
}

/// Editor for the extra HTTP headers that are sent along with every request to
/// a server, used to get through header authenticated proxies such as
/// Cloudflare Access.
class CustomHeadersEditor extends StatefulWidget {
  const CustomHeadersEditor({required this.controller, super.key});

  final CustomHeadersController controller;

  @override
  State<CustomHeadersEditor> createState() => _CustomHeadersEditorState();
}

class _CustomHeadersEditorState extends State<CustomHeadersEditor> {
  CustomHeadersController get controller => widget.controller;

  late final List<Listenable> _sources = [
    controller,
    controller.clientId,
    controller.clientSecret,
    controller.name,
    controller.value,
  ];

  @override
  void initState() {
    super.initState();
    for (final source in _sources) {
      source.addListener(_onChanged);
    }
  }

  @override
  void dispose() {
    for (final source in _sources) {
      source.removeListener(_onChanged);
    }
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final listed = controller.listedHeaders;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            context.localized.customHeadersDesc,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SegmentedButton<CustomHeaderPreset>(
          segments: CustomHeaderPreset.values
              .map((preset) => ButtonSegment(value: preset, label: Text(preset.label(context))))
              .toList(),
          selected: {controller.preset},
          onSelectionChanged: (selection) => controller.preset = selection.first,
          showSelectedIcon: false,
        ),
        AnimatedFadeSize(
          child: switch (controller.preset) {
            CustomHeaderPreset.cloudflareAccess => _cloudflareFields(),
            CustomHeaderPreset.custom => _customFields(),
          },
        ),
        if (listed.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: listed.entries
                .map(
                  (header) => InputChip(
                    label: Text('${header.key}: ${header.value}'),
                    onDeleted: () => controller.remove(header.key),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _cloudflareFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        OutlinedTextField(
          label: context.localized.cloudflareAccessClientId,
          subLabel: cloudflareAccessClientIdHeader,
          controller: controller.clientId,
          autocorrect: false,
          textInputAction: TextInputAction.next,
        ),
        OutlinedTextField(
          label: context.localized.cloudflareAccessClientSecret,
          subLabel: cloudflareAccessClientSecretHeader,
          controller: controller.clientSecret,
          autocorrect: false,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _customFields() {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 3,
          child: OutlinedTextField(
            label: context.localized.customHeaderName,
            controller: controller.name,
            autocorrect: false,
            textInputAction: TextInputAction.next,
          ),
        ),
        Expanded(
          flex: 4,
          child: OutlinedTextField(
            label: context.localized.customHeaderValue,
            controller: controller.value,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => controller.commitPending(),
          ),
        ),
        IconButton(
          onPressed: controller.commitPending,
          tooltip: context.localized.addCustomHeader,
          icon: const Icon(IconsaxPlusBold.add_circle),
        ),
      ],
    );
  }
}
