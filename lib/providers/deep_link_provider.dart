import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/screens/login/login_screen_credentials.dart';
import 'package:fladder/screens/shared/deep_link_account_dialog.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/deep_link_helper.dart';
import 'package:fladder/util/localization_helper.dart';

final deepLinkProvider = NotifierProvider<DeepLinkNotifier, DeepLinkTarget?>(DeepLinkNotifier.new);

class DeepLinkNotifier extends Notifier<DeepLinkTarget?> {
  static const _accessTimeout = Duration(seconds: 6);
  static const _blockingRoutes = {SplashRoute.name, LoginRoute.name, LockRoute.name};

  StackRouter? _router;
  WidgetRef? _widgetRef;
  bool _opening = false;
  (Uri, DateTime)? _lastLink;

  @override
  DeepLinkTarget? build() {
    ref.listen(userProvider.select((value) => value?.id), (_, __) => _openPending());
    ref.listen(lockScreenActiveProvider, (_, __) => _openPending());
    return null;
  }

  void attach(StackRouter router, WidgetRef widgetRef) {
    _router?.removeListener(_openPending);
    _router = router..addListener(_openPending);
    _widgetRef = widgetRef;
    _openPending();
  }

  void detach(StackRouter router) {
    if (_router != router) return;
    router.removeListener(_openPending);
    _router = null;
    _widgetRef = null;
  }

  void handleLink(String? link) {
    if (link == null || link.trim().isEmpty) return;
    handle(Uri.tryParse(link.trim()));
  }

  void handle(Uri? uri) {
    final now = DateTime.now();
    final last = _lastLink;
    if (uri != null && last != null && last.$1 == uri && now.difference(last.$2) < const Duration(seconds: 2)) return;
    if (uri != null) _lastLink = (uri, now);

    final target = DeepLinkTarget.parse(uri);
    if (target == null) {
      log('Ignoring unsupported deep link: $uri');
      return;
    }
    state = target;
    _openPending();
  }

  bool _canOpen(DeepLinkTarget target) {
    final router = _router;
    if (router == null || _widgetRef == null || router.stack.isEmpty) return false;
    if (router.current.name == SplashRoute.name) return false;
    if (!target.requiresUser) return true;
    if (ref.read(userProvider) == null || ref.read(lockScreenActiveProvider)) return false;
    return !_blockingRoutes.contains(router.current.name);
  }

  void _openPending() {
    final target = state;
    if (target == null || _opening || !_canOpen(target)) return;
    state = null;
    _opening = true;
    Future.microtask(() => _open(target)).whenComplete(() {
      _opening = false;
      _openPending();
    });
  }

  Future<void> _open(DeepLinkTarget target) async {
    final router = _router;
    if (router == null) {
      state = target;
      return;
    }

    if (!target.requiresUser) {
      await router.replaceAll([target.route]);
      return;
    }

    final currentUser = ref.read(userProvider);
    if (currentUser == null) {
      state = target;
      return;
    }

    final otherAccounts = ref
        .read(sharedUtilityProvider)
        .getAccounts()
        .where((account) => !_isSameAccount(account, currentUser))
        .toList();

    final linkedAccount = otherAccounts.firstWhereOrNull(
      (account) =>
          account.id == target.userId && (target.serverId == null || account.credentials.serverId == target.serverId),
    );
    if (linkedAccount != null) {
      await _switchAccount(target, currentUser, [linkedAccount], linkedAccount: true);
      return;
    }

    final itemId = target.itemId;
    if (itemId == null || ref.read(offlineStateProvider) || await _currentUserCanOpen(itemId)) {
      await router.push(target.route);
      return;
    }

    final candidates = otherAccounts.sortedBy<num>(
      (account) => account.credentials.serverId == currentUser.credentials.serverId ? 0 : 1,
    );
    final access = await Future.wait(candidates.map((account) => _accountCanOpen(account, itemId)));
    final accountsWithAccess = [
      for (final (index, account) in candidates.indexed)
        if (access[index]) account,
    ];

    if (accountsWithAccess.isEmpty) {
      final context = router.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        FladderSnack.show(context.localized.deepLinkItemNotFound, context: context);
      }
      return;
    }

    await _switchAccount(target, currentUser, accountsWithAccess);
  }

  Future<void> _switchAccount(
    DeepLinkTarget target,
    AccountModel currentUser,
    List<AccountModel> accounts, {
    bool linkedAccount = false,
  }) async {
    final router = _router;
    final context = router?.navigatorKey.currentContext;
    if (router == null || context == null || !context.mounted) return;

    final selected = await showDeepLinkAccountDialog(
      context,
      currentUser: currentUser,
      accounts: accounts,
      linkedAccount: linkedAccount,
    );

    final widgetRef = _widgetRef;
    final loginContext = router.navigatorKey.currentContext;
    if (selected == null || widgetRef == null || loginContext == null || !loginContext.mounted) return;

    tapLoggedInAccount(loginContext, selected, widgetRef, redirect: target.route);
  }

  Future<bool> _currentUserCanOpen(String itemId) async {
    try {
      final response =
          await ref.read(jellyApiProvider).usersUserIdItemsItemIdGet(itemId: itemId).timeout(_accessTimeout);
      return response.isSuccessful && response.body != null;
    } catch (e) {
      log('Unable to check deep link access for current user: $e');
      return false;
    }
  }

  Future<bool> _accountCanOpen(AccountModel account, String itemId) async {
    final api = createJellyfinApiForAccount(ref, account.credentials.url, account.credentials.header(ref));
    try {
      final response = await api.itemsItemIdGet(userId: account.id, itemId: itemId).timeout(_accessTimeout);
      return response.isSuccessful && response.body != null;
    } catch (e) {
      log('Unable to check deep link access for ${account.name}: $e');
      return false;
    } finally {
      api.client.dispose();
    }
  }

  bool _isSameAccount(AccountModel a, AccountModel b) =>
      a.id == b.id && a.credentials.serverId == b.credentials.serverId;
}
