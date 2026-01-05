import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';

part 'seerr_user_provider.g.dart';

@riverpod
class SeerrUser extends _$SeerrUser {
  @override
  SeerrUserModel? build() {
    _fetchUser();
    return null;
  }

  Future<void> _fetchUser() async {
    final api = ref.read(seerrApiProvider);
    final response = await api.me();
    if (response.isSuccessful && response.body != null) {
      state = response.body;
    }
  }

  Future<SeerrUserModel?> refreshUser() async {
    final api = ref.read(seerrApiProvider);
    final response = await api.me();
    if (response.isSuccessful) {
      state = response.body;
      return response.body;
    }
    return null;
  }

  void clearUser() {
    state = null;
  }
}
