import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_tuner_edit_provider.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class ListingProviderEditDialog extends StatefulWidget {
  final ListingsProviderInfo? provider;

  const ListingProviderEditDialog({super.key, this.provider});

  @override
  State<ListingProviderEditDialog> createState() => _ListingProviderEditDialogState();
}

class _ListingProviderEditDialogState extends State<ListingProviderEditDialog> {
  late TextEditingController _pathController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  EPGProviderType _selectedType = EPGProviderType.xmltv;

  @override
  void initState() {
    super.initState();
    _pathController = TextEditingController(text: widget.provider?.path ?? '');
    _usernameController = TextEditingController(text: widget.provider?.username ?? '');
    _passwordController = TextEditingController(text: widget.provider?.password ?? '');
    _selectedType = EPGProviderType.fromString(widget.provider?.type);
  }

  @override
  void dispose() {
    _pathController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.provider == null ? context.localized.addEpgProvider : context.localized.editEpgProvider),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.localized.type(1),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                EnumBox(
                  current: _selectedType.value,
                  itemBuilder: (context) => widget.provider != null
                      ? []
                      : EPGProviderType.values
                          .map(
                            (type) => ItemActionButton(
                              label: Text(type.value),
                              action: () => setState(() => _selectedType = type),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
            if (_selectedType != EPGProviderType.schedulesDirect)
              OutlinedTextField(
                controller: _pathController,
                label: context.localized.xmltvPathUrl,
              ),
            if (_selectedType != EPGProviderType.xmltv) ...[
              OutlinedTextField(
                controller: _usernameController,
                label: context.localized.username,
              ),
              OutlinedTextField(
                controller: _passwordController,
                label: context.localized.password,
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
        TextButton(
          onPressed: () {
            final provider = ListingsProviderInfo(
              id: widget.provider?.id,
              type: _selectedType.value,
              path: _pathController.text.isEmpty ? null : _pathController.text,
              username: _usernameController.text.isEmpty ? null : _usernameController.text,
              password: _passwordController.text.isEmpty ? null : _passwordController.text,
            );
            Navigator.of(context).pop(provider);
          },
          child: Text(context.localized.save),
        ),
      ],
    );
  }
}
