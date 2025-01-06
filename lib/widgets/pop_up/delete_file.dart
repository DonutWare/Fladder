import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';

Future<Response<dynamic>?> showDeleteDialog(BuildContext context, ItemBaseModel item, WidgetRef ref) async {
  Response<dynamic>? response;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(context.localized.deleteItem(item.type.label(context))),
      content: Text(
        context.localized.deleteFileFromSystem(item.name),
      ),
      scrollable: true,
      actions: [
        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.cancel)),
        FilledButtonAwait(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            iconColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
          onPressed: () async {
            response = await ref.read(jellyApiProvider).deleteItem(item.id);
            Navigator.of(context).pop();
          },
          child: Text(
            context.localized.delete,
          ),
        )
      ],
    ),
  );
  return response;
}
