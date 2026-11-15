import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';

const _applicationId = "nl.jknaapen.fladder";

File get _flagFile {
  final dataHome = Platform.environment['XDG_DATA_HOME'];
  final base = dataHome != null && dataHome.isNotEmpty
      ? dataHome
      : "${Platform.environment['HOME']}/.local/share";
  return File("$base/$_applicationId/disable_impeller");
}

final linuxImpellerProvider = StateNotifierProvider<LinuxImpellerNotifier, bool>((ref) => LinuxImpellerNotifier());

class LinuxImpellerNotifier extends StateNotifier<bool> {
  LinuxImpellerNotifier() : super(!_flagFile.existsSync());

  Future<void> setEnabled(bool enabled) async {
    final file = _flagFile;
    if (!enabled) {
      await file.create(recursive: true);
    } else if (await file.exists()) {
      await file.delete();
    }
    state = enabled;
  }
}
