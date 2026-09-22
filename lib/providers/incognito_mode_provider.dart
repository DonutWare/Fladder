import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';

final incognitoModeProvider = StateProvider<bool>((ref) => kDebugMode);

final incognitoProvider = Provider<bool>((ref) {
  final userOverride = ref.watch(userProvider.select((value) => value?.incognitoMode));
  return userOverride ?? ref.watch(incognitoModeProvider);
});
