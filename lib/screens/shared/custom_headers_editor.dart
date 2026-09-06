import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';

/// Editor for the extra HTTP headers that are sent along with every request to
/// a server, used to get through header authenticated proxies such as
/// Cloudflare Access.
class CustomHeadersEditor extends StatefulWidget {
  const CustomHeadersEditor({
    required this.headers,
    required this.onChanged,
    super.key,
  });

  /// Headers to show; [onChanged] is called with the updated map on every edit.
  final Map<String, String> headers;
  final ValueChanged<Map<String, String>> onChanged;

  @override
  State<CustomHeadersEditor> createState() => _CustomHeadersEditorState();
}

class _CustomHeadersEditorState extends State<CustomHeadersEditor> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  late final Map<String, String> headers = Map.of(widget.headers);

  @override
  void dispose() {
    nameController.dispose();
    valueController.dispose();
    super.dispose();
  }

  void _addHeader() {
    final name = nameController.text.trim();
    if (name.isEmpty) return;
    setState(() {
      headers[name] = valueController.text.trim();
      nameController.clear();
      valueController.clear();
    });
    widget.onChanged(Map.of(headers));
  }

  void _removeHeader(String name) {
    setState(() => headers.remove(name));
    widget.onChanged(Map.of(headers));
  }

  @override
  Widget build(BuildContext context) {
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
        Row(
          spacing: 8,
          children: [
            Expanded(
              flex: 3,
              child: OutlinedTextField(
                label: context.localized.customHeaderName,
                controller: nameController,
                autocorrect: false,
                textInputAction: TextInputAction.next,
              ),
            ),
            Expanded(
              flex: 4,
              child: OutlinedTextField(
                label: context.localized.customHeaderValue,
                controller: valueController,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _addHeader(),
              ),
            ),
            IconButton(
              onPressed: _addHeader,
              tooltip: context.localized.addCustomHeader,
              icon: const Icon(IconsaxPlusBold.add_circle),
            ),
          ],
        ),
        if (headers.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: headers.entries
                .map(
                  (header) => InputChip(
                    label: Text('${header.key}: ${header.value}'),
                    onDeleted: () => _removeHeader(header.key),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
