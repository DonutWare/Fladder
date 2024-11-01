import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/list_padding.dart';

enum MessageType {
  info,
  warning,
  error;

  Color color(BuildContext context) => switch (this) {
        MessageType.info => Theme.of(context).colorScheme.secondaryContainer,
        MessageType.warning => Theme.of(context).colorScheme.primaryContainer,
        MessageType.error => Theme.of(context).colorScheme.errorContainer,
      };
}

class SettingsMessageBox extends ConsumerWidget {
  final String message;
  final MessageType messageType;
  const SettingsMessageBox(this.message, {this.messageType = MessageType.info, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).add(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.paddingOf(context).horizontal,
          ),
        ),
        child: Card(
          elevation: 2,
          color: messageType.color(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  switch (messageType) {
                    MessageType.info => IconsaxOutline.information,
                    MessageType.warning => IconsaxOutline.warning_2,
                    MessageType.error => IconsaxOutline.danger,
                  },
                ),
                Flexible(
                  child: Text(message),
                ),
              ].addInBetween(const SizedBox(width: 12)),
            ),
          ),
        ),
      ),
    );
  }
}
