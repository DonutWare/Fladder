import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/login_screen_model.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/screens/login/login_edit_user.dart';
import 'package:fladder/screens/login/login_screen_credentials.dart';
import 'package:fladder/screens/login/login_user_grid.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_logo.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/keyboard/slide_in_keyboard.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_app_bar.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginScreen> {
  late final TextEditingController serverTextController = TextEditingController(text: '');
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool editUsersMode = false;

  @override
  Widget build(BuildContext context) {
    final screen = ref.watch(authProvider.select((value) => value.screen));
    final accounts = ref.watch(authProvider.select((value) => value.accounts));
    return NotificationManagerInitializer(
      child: CustomKeyboardWrapper(
        child: Scaffold(
          appBar: const FladderAppBar(),
          extendBody: true,
          extendBodyBehindAppBar: true,
          floatingActionButton: switch (screen) {
            LoginScreenType.users => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 16,
                children: [
                  if (AdaptiveLayout.of(context).isDesktop)
                    AdaptiveFab(
                      context: context,
                      key: const Key("edit_user_button"),
                      heroTag: "edit_user_button",
                      backgroundColor: editUsersMode ? Theme.of(context).colorScheme.errorContainer : null,
                      child: const Icon(IconsaxPlusLinear.edit_2),
                      onPressed: () => setState(() => editUsersMode = !editUsersMode),
                    ).normal,
                  AdaptiveFab(
                    context: context,
                    key: const Key("new_user_button"),
                    heroTag: "new_user_button",
                    child: const Icon(IconsaxPlusLinear.add_square),
                    onPressed: () => ref.read(authProvider.notifier).addNewUser(),
                  ).normal,
                ],
              ),
            _ => null,
          },
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: MediaQuery.paddingOf(context).add(const EdgeInsetsGeometry.all(16)),
                children: [
                  const FladderLogo(),
                  const SizedBox(height: 24),
                  AnimatedFadeSize(
                    child: switch (screen) {
                      LoginScreenType.login || LoginScreenType.code => const LoginScreenCredentials(),
                      _ => LoginUserGrid(
                          users: accounts,
                          editMode: editUsersMode,
                          onPressed: (user) => tapLoggedInAccount(context, user, ref),
                          onLongPress: (user) => openUserEditDialogue(context, user),
                        ),
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openUserEditDialogue(BuildContext context, AccountModel user) {
    showDialog(
      context: context,
      builder: (context) => LoginEditUser(
        user: user,
        onTapServer: (value) {
          ref.read(authProvider.notifier).setServer(value);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
