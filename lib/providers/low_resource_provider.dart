import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';

final lowResourceModeProvider = Provider<bool>((ref) {
  final lowResourceDevice = ref.watch(argumentsStateProvider.select((value) => value.lowResourceDevice));
  final mode = ref.watch(clientSettingsProvider.select((value) => value.lowResourceMode));
  return mode.isActive(lowResourceDevice);
});
