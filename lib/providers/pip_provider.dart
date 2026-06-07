import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/wrappers/pip_manager.dart';

final pipManagerProvider = Provider<PipManager>((ref) {
  final manager = PipManager();
  ref.onDispose(manager.dispose);
  return manager;
});

final pipStateProvider = StreamProvider<bool>((ref) {
  final manager = ref.watch(pipManagerProvider);
  return manager.isInPip;
});
