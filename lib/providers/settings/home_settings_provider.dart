import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/shared_provider.dart';

final homeSettingsProvider = StateNotifierProvider<HomeSettingsNotifier, HomeSettingsModel>((ref) {
  return HomeSettingsNotifier(ref);
});

class HomeSettingsNotifier extends StateNotifier<HomeSettingsModel> {
  HomeSettingsNotifier(this.ref) : super(HomeSettingsModel());

  final Ref ref;

  @override
  set state(HomeSettingsModel value) {
    super.state = value;
    ref.read(sharedUtilityProvider).homeSettings = value;
  }

  HomeSettingsModel update(HomeSettingsModel Function(HomeSettingsModel currentState) value) => state = value(state);
}
