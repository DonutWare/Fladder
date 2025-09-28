import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/arguments_provider.dart';

Future<void> showDefaultAlertDialog(
  BuildContext context,
  String title,
  String? content,
  FutureOr Function(BuildContext context)? accept,
  String? acceptTitle,
  FutureOr Function(BuildContext context)? decline,
  String declineTitle,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: [
        if (decline != null)
          Consumer(
            builder: (context, ref, child) => ElevatedButton(
              autofocus: ref.read(argumentsStateProvider).htpcMode,
              onPressed: () => decline.call(context),
              child: Text(declineTitle),
            ),
          ),
        if (accept != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
              iconColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
            onPressed: () => accept.call(context),
            child: Text(acceptTitle ?? "Accept"),
          ),
      ],
    ),
  );
}

Future<void> showDefaultActionDialog(
  BuildContext context,
  String title,
  String? content,
  FutureOr Function(BuildContext context)? accept,
  String? acceptTitle,
  FutureOr Function(BuildContext context)? decline,
  String declineTitle,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: [
        if (decline != null)
          ElevatedButton(
            onPressed: () => decline.call(context),
            child: Text(declineTitle),
          ),
        if (accept != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () => accept.call(context),
            child: Text(acceptTitle ?? "Accept"),
          ),
      ],
    ),
  );
}
