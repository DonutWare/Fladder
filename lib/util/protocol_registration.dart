import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:fladder/util/deep_link_helper.dart';

Future<void> ensureWindowsProtocolRegistered() async {
  if (kIsWeb || !Platform.isWindows || kDebugMode) return;

  const key = r'HKCU\Software\Classes\' + deepLinkScheme;
  try {
    final existing = await Process.run('reg', ['query', 'HKCR\\$deepLinkScheme\\shell\\open\\command', '/ve']);
    final registeredExecutable =
        RegExp(r'"([^"]+\.exe)"', caseSensitive: false).firstMatch(existing.stdout.toString())?.group(1);
    if (existing.exitCode == 0 && registeredExecutable != null && File(registeredExecutable).existsSync()) return;

    final executable = Platform.resolvedExecutable;
    final entries = [
      [key, '/ve', '/d', 'URL:Fladder'],
      [key, '/v', 'URL Protocol', '/d', ''],
      ['$key\\DefaultIcon', '/ve', '/d', '"$executable",0'],
      ['$key\\shell\\open\\command', '/ve', '/d', '"$executable" "%1"'],
    ];
    for (final entry in entries) {
      final result = await Process.run('reg', ['add', ...entry, '/f']);
      if (result.exitCode != 0) {
        log('Failed to register $deepLinkScheme protocol: ${result.stderr}');
        return;
      }
    }
  } catch (e) {
    log('Failed to register $deepLinkScheme protocol: $e');
  }
}
