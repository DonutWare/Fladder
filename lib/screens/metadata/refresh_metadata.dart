import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';

Future<void> showRefreshPopup(BuildContext context, String itemId, String itemName) async {
  return showDialog(
    context: context,
    builder: (context) => RefreshPopupDialog(
      itemId: itemId,
      name: itemName,
    ),
  );
}

class RefreshPopupDialog extends ConsumerStatefulWidget {
  final String itemId;
  final String name;

  const RefreshPopupDialog({required this.itemId, required this.name, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RefreshPopupDialogState();
}

class _RefreshPopupDialogState extends ConsumerState<RefreshPopupDialog> {
  MetadataRefresh refreshMode = MetadataRefresh.defaultRefresh;
  bool replaceAllMetadata = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: AdaptiveLayout.of(context).inputDevice == InputDevice.pointer ? 700 : double.infinity),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          context.localized.refreshPopup(widget.name),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: EnumBox(
                  current: refreshMode.label(context),
                  itemBuilder: (context) => MetadataRefresh.values
                      .map((value) => PopupMenuItem(
                            value: value,
                            child: Text(value.label(context)),
                            onTap: () => setState(() {
                              refreshMode = value;
                            }),
                          ))
                      .toList(),
                ),
              ),
              if (refreshMode != MetadataRefresh.defaultRefresh)
                SettingsListTile(
                  label: Text(context.localized.replaceExistingImages),
                  trailing: Switch.adaptive(
                    value: replaceAllMetadata,
                    onChanged: (value) => setState(() => replaceAllMetadata = value),
                  ),
                ),
              SettingsListTile(
                label: Text(
                  context.localized.refreshPopupContentMetadata,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                          onPressed: () async {
                            final response = await ref.read(userProvider.notifier).refreshMetaData(
                                  widget.itemId,
                                  metadataRefreshMode: refreshMode,
                                  replaceAllMetadata: replaceAllMetadata,
                                );
                            if (!response.isSuccessful) {
                              fladderSnackbarResponse(context, response);
                            } else {
                              fladderSnackbar(context, title: context.localized.scanningName(widget.name));
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(context.localized.refresh)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
