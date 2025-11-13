import 'dart:async';

import 'package:async/async.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> openLoginCodeDialog(
  BuildContext context, {
  required QuickConnectResult quickConnectInfo,
  required Function(BuildContext context, String secret) onAuthenticated,
}) {
  return showDialog(
    context: context,
    builder: (context) => LoginCodeDialog(
      quickConnectInfo: quickConnectInfo,
      onAuthenticated: onAuthenticated,
    ),
  );
}

class LoginCodeDialog extends ConsumerStatefulWidget {
  final QuickConnectResult quickConnectInfo;
  final Function(BuildContext context, String secret) onAuthenticated;
  const LoginCodeDialog({
    required this.quickConnectInfo,
    required this.onAuthenticated,
    super.key,
  });

  @override
  ConsumerState<LoginCodeDialog> createState() => _LoginCodeDialogState();
}

class _LoginCodeDialogState extends ConsumerState<LoginCodeDialog> {
  late QuickConnectResult quickConnectInfo = widget.quickConnectInfo;

  RestartableTimer? timer;

  @override
  void initState() {
    super.initState();
    createTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void createTimer() {
    timer?.cancel();
    timer = RestartableTimer(const Duration(seconds: 1), () async {
      final result = await ref.read(jellyApiProvider).quickConnectConnectGet(
            secret: quickConnectInfo.secret,
          );
      final newSecret = result.body?.secret;
      if (result.isSuccessful &&
          result.body?.authenticated == true &&
          newSecret != null) {
        widget.onAuthenticated.call(context, newSecret);
      } else {
        timer?.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final code = quickConnectInfo.code;
    final serverName = ref.watch(authProvider
        .select((value) => value.serverLoginModel?.tempCredentials.serverName));
    return Dialog(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              serverName?.isNotEmpty == true
                  ? "${context.localized.quickConnectTitle} - $serverName"
                  : context.localized.quickConnectTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                if (code != null) ...[
                  Text(
                    context.localized.quickConnectEnterCodeDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  IntrinsicWidth(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          code,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    wordSpacing: 8,
                                    letterSpacing: 8,
                                  ),
                          textAlign: TextAlign.center,
                          semanticsLabel: code,
                        ),
                      ),
                    ),
                  ),
                ],
                FilledButton(
                  onPressed: () async {
                    final response =
                        await ref.read(jellyApiProvider).quickConnectInitiate();
                    if (response.isSuccessful && response.body != null) {
                      setState(() {
                        quickConnectInfo = response.body!;
                      });
                      createTimer();
                    }
                  },
                  child: Text(
                    context.localized.refresh,
                  ),
                )
              ].addInBetween(const SizedBox(height: 16)),
            )
          ],
        ),
      ),
    );
  }
}
