import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/deep_link_helper.dart';
import 'package:fladder/util/localization_helper.dart';

Future<void> showConnectLinkDialog(
  BuildContext context,
  Function(AuthLinkData link) initLink,
) {
  return showDialog(
    context: context,
    builder: (context) {
      final textController = TextEditingController();
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: AlertDialog(
          title: Row(
            spacing: 8,
            children: [
              Expanded(child: Text(context.localized.connectWithAuthLink)),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(IconsaxPlusBold.close_square),
              )
            ],
          ),
          content: Column(
            spacing: 4,
            children: [
              OutlinedTextField(
                controller: textController,
                placeHolder: context.localized.pasteFladderAuthLink,
              ),
              Text(
                context.localized.authLinkDesc,
              )
            ],
          ),
          scrollable: true,
          actions: [
            FilledButton(
              onPressed: () {
                final link = textController.text;
                final data = AuthLinkData.parse(link);
                if (data != null) {
                  initLink(data);
                } else {
                  FladderSnack.show(context.localized.invalidAuthLink);
                }
                Navigator.of(context).pop();
              },
              child: Text(context.localized.connect),
            )
          ],
        ),
      );
    },
  );
}
