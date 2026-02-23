import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/deep_link_helper.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';

Future<void> openAuthLinkDialog(
  BuildContext context, {
  required String serverUrl,
  String? seerrUrl,
  required AccountModel user,
}) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AuthLinkDialog(
      serverUrl: serverUrl,
      seerrUrl: seerrUrl,
      user: user,
    ),
  );
}

class AuthLinkDialog extends StatefulWidget {
  final String serverUrl;
  final String? seerrUrl;
  final AccountModel user;

  const AuthLinkDialog({
    required this.serverUrl,
    this.seerrUrl,
    required this.user,
    super.key,
  });

  @override
  State<AuthLinkDialog> createState() => _AuthLinkDialogState();
}

class _AuthLinkDialogState extends State<AuthLinkDialog> {
  late final serverTextController = TextEditingController(text: widget.serverUrl);
  late final seerrTextController = TextEditingController(text: widget.seerrUrl);
  late final usernameController = TextEditingController(text: widget.user.name);
  late final passwordController = TextEditingController();

  AuthLinkData linkData = AuthLinkData(
    serverUrl: '',
    userName: '',
  );

  String linkUrl = '';

  @override
  void initState() {
    super.initState();
    _updateLink();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  late final qrDecoration = PrettyQrDecoration(
    image: PrettyQrDecorationImage(
      image: Image.asset("icons/fladder_notification_icon.png").image,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.primary,
        BlendMode.srcIn,
      ),
      scale: 0.25,
      isAntiAlias: true,
      padding: const EdgeInsets.all(8),
      clipper: const PrettyQrCircleClipper(),
    ),
    quietZone: const PrettyQrPixelsQuietZone(24),
    background: Theme.of(context).colorScheme.surfaceContainer,
    shape: PrettyQrShape.custom(
      PrettyQrSmoothSymbol(
        roundFactor: 1,
        color: Theme.of(context).colorScheme.primary,
      ),
      finderPattern: PrettyQrSmoothSymbol(
        color: Theme.of(context).colorScheme.primary,
      ),
      alignmentPatterns: PrettyQrSmoothSymbol(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Row(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      Text(
                        context.localized.generateLoginLink(widget.user.name),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Container(
                        width: 275,
                        height: 275,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: PrettyQrView(
                          qrImage: QrImage(
                            QrCode.fromData(data: linkUrl, errorCorrectLevel: QrErrorCorrectLevel.M),
                          ),
                          decoration: qrDecoration,
                        ),
                      ),
                      Flexible(
                        child: FocusButton(
                          onTap: () => _copyLink(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              linkUrl,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.localized.linkData,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      OutlinedTextField(
                        controller: serverTextController,
                        label: context.localized.server,
                        onChanged: (_) => setState(_updateLink),
                      ),
                      OutlinedTextField(
                        controller: seerrTextController,
                        label: context.localized.seerr,
                        onChanged: (_) => setState(_updateLink),
                      ),
                      OutlinedTextField(
                        controller: usernameController,
                        label: context.localized.username,
                        onChanged: (_) => setState(_updateLink),
                      ),
                      OutlinedTextField(
                        controller: passwordController,
                        label: context.localized.password,
                        keyboardType: TextInputType.visiblePassword,
                        autocorrect: false,
                        subLabel: context.localized.passwordNotRequired,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) => setState(_updateLink),
                      ),
                      const Expanded(child: Divider()),
                      FilledButtonAwait.tonal(
                        onPressed: () => SharePlus.instance.share(
                          ShareParams(text: linkUrl),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            const Icon(IconsaxPlusLinear.share),
                            Text(context.localized.shareLoginLink),
                          ],
                        ),
                      ),
                      FilledButtonAwait.tonal(
                        onPressed: _shareQr,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            const Icon(IconsaxPlusLinear.command_square),
                            Text(context.localized.shareQRCode),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                        onPressed: () => context.pop(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            const Icon(IconsaxPlusLinear.close_circle),
                            Text(context.localized.close),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateLink() {
    linkData = AuthLinkData(
      serverUrl: serverTextController.text,
      seerrUrl: seerrTextController.text.isEmpty ? null : seerrTextController.text,
      userName: usernameController.text,
      password: passwordController.text.isEmpty ? null : passwordController.text,
    );
    linkUrl = buildAuthUrl(linkData);
  }

  Future<void> _shareQr() async {
    final qrCode = QrCode.fromData(
      data: linkUrl,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    final qrImage = QrImage(qrCode);
    final qrImageBytes = await qrImage.toImageAsBytes(
      size: 512,
      format: ui.ImageByteFormat.png,
      decoration: qrDecoration,
    );
    if (qrImageBytes == null) {
      if (context.mounted) {
        FladderSnack.show(
          context.localized.invalidAuthLink,
        );
      }
      return;
    }
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/auth_qr.png');
    await file.writeAsBytes(qrImageBytes.buffer.asUint8List());
    await SharePlus.instance.share(
      ShareParams(
        title: context.localized.generateLoginLink(widget.user.name),
        uri: Uri.parse(linkUrl),
        fileNameOverrides: [context.localized.generateLoginLink(widget.user.name)],
        files: [XFile(file.path, bytes: qrImageBytes.buffer.asUint8List())],
        previewThumbnail: XFile(file.path, bytes: qrImageBytes.buffer.asUint8List()),
      ),
    );
    await file.delete();
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: linkUrl));
    if (context.mounted) {
      FladderSnack.show(
        context.localized.copiedToClipboard,
      );
    }
  }
}
