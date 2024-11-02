import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/widgets/login_icon.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/passcode_input.dart';
import 'package:fladder/util/auth_service.dart';
import 'package:fladder/util/localization_helper.dart';

final lockScreenActiveProvider = StateProvider<bool>((ref) => false);

@RoutePage()
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> with WidgetsBindingObserver {
  bool poppingLockScreen = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        hackyFixForBlackNavbar();
      default:
        break;
    }
  }

  void hackyFixForBlackNavbar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() {
      ref.read(lockScreenActiveProvider.notifier).update((state) => true);
    });
    hackyFixForBlackNavbar();
  }

  void handleLogin(AccountModel user) {
    ref.read(lockScreenActiveProvider.notifier).update((state) => false);
    poppingLockScreen = true;
    context.router.popForced();
  }

  void tapLoggedInAccount(AccountModel user) async {
    switch (user.authMethod) {
      case Authentication.autoLogin:
        handleLogin(user);
        break;
      case Authentication.biometrics:
        final authenticated = await AuthService.authenticateUser(context, user);
        if (authenticated && context.mounted) {
          handleLogin(user);
        }
        break;
      case Authentication.passcode:
        if (context.mounted) {
          showPassCodeDialog(context, (newPin) {
            if (newPin == user.localPin) {
              handleLogin(user);
            } else {
              fladderSnackbar(context, title: context.localized.incorrectPinTryAgain);
            }
          });
        }
        break;
      case Authentication.none:
        handleLogin(user);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!poppingLockScreen) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: context.localized.login,
          onPressed: () {
            ref.read(lockScreenActiveProvider.notifier).update((state) => false);
            context.router.push(const LoginRoute());
          },
          child: const Icon(IconsaxOutline.arrow_swap_horizontal),
        ),
        body: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            direction: Axis.vertical,
            children: [
              const Icon(
                IconsaxOutline.lock_1,
                size: 38,
              ),
              if (user != null)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 400,
                    maxWidth: 400,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: LoginIcon(
                      user: user,
                      onPressed: () => tapLoggedInAccount(user),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
