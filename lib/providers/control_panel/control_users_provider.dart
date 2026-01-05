import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_users_provider.freezed.dart';
part 'control_users_provider.g.dart';

@riverpod
class ControlUsers extends _$ControlUsers {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  ControlUsersModel build() {
    return ControlUsersModel();
  }

  Future<void> fetchUsers() async {
    final users = (await api.getAllUsers()).body ?? [];
    state = state.copyWith(users: users);
  }

  Future<void> updateSelectedUserPolicy(UserPolicy? policy) async {
    if (state.selectedUser == null || policy == null) return;
    state = state.copyWith(
      editingPolicy: policy,
    );
  }

  Future<String?> saveUserPolicy() async {
    if (state.editingPolicy == null) return null;
    final response = await api.setUserPolicy(id: state.selectedUser!.id, policy: state.editingPolicy!);
    return response.isSuccessful ? null : "${response.statusCode}: ${response.body}";
  }

  Future<void> startEditingUser(AccountModel user) async {
    state = state.copyWith(selectedUser: user);
  }

  Future<void> fetchSpecificUser(String? userId) async {
    if (userId == null) return;
    final user = (await api.getAllUsers()).body;
    if (user != null) {
      final selectedUser = user.firstWhereOrNull((element) => element.id == userId);
      final devices = await api.getAllDevices();
      final parentalRatings = await api.getParentalRatings();
      final virtualFolders = (await api.libraryVirtualFoldersGet()).body ?? [];
      final libraries = virtualFolders
          .map((e) => ViewModel.fromVirtualFolder(
                e,
                ref,
              ))
          .toList();
      state = state.copyWith(
        selectedUser: selectedUser,
        editingPolicy: selectedUser?.policy,
        availableDevices: devices,
        parentalRatings: parentalRatings,
        views: libraries,
      );
    }
  }

  Future<void> deleteUser(String userId) async {
    await api.deleteUser(userId);
    await fetchUsers();
  }

  Future<String?> setUserPassword(
    String? userId, {
    required String current,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await api.setNewPassword(
      userId: userId,
      currentPassword: current,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    return response.isSuccessful ? null : "${response.statusCode}: ${response.bodyString}";
  }

  Future<bool> resetUserPassword() async {
    final response = await api.resetPassword(
      userId: state.selectedUser!.id,
    );
    return response.isSuccessful;
  }
}

@Freezed(copyWith: true)
abstract class ControlUsersModel with _$ControlUsersModel {
  factory ControlUsersModel({
    @Default([]) List<AccountModel> users,
    @Default([]) List<ViewModel> views,
    AccountModel? selectedUser,
    UserPolicy? editingPolicy,
    List<DeviceInfoDto>? availableDevices,
    List<ParentalRating>? parentalRatings,
  }) = _ControlUsersModel;
}
