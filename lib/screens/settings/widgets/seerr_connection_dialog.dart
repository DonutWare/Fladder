import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_dashboard_provider.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/focused_outlined_text_field.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';

Future<void> showSeerrConnectionDialog(BuildContext context) {
  return showDialogAdaptive(
    context: context,
    builder: (context) => const SeerrConnectionDialog(),
  );
}

enum SeerrAuthTab {
  jellyfin,
  local,
  apiKey;

  String label(BuildContext context) => switch (this) {
        SeerrAuthTab.apiKey => context.localized.seerrAuthApiKey,
        SeerrAuthTab.local => context.localized.seerrAuthLocal,
        SeerrAuthTab.jellyfin => context.localized.seerrAuthJellyfin,
      };
}

class SeerrConnectionDialog extends ConsumerStatefulWidget {
  const SeerrConnectionDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeerrConnectionDialogState();
}

class _SeerrConnectionDialogState extends ConsumerState<SeerrConnectionDialog> {
  late final TextEditingController apiKeyController;
  late final TextEditingController serverController;
  late final TextEditingController localEmailController;
  late final TextEditingController localPasswordController;
  late final TextEditingController jfUsernameController;
  late final TextEditingController jfPasswordController;

  SeerrAuthTab selectedTab = SeerrAuthTab.jellyfin;
  SeerrUserModel? seerrUser;
  bool loading = true;
  bool processing = false;
  String? error;

  @override
  void initState() {
    super.initState();
    final creds = ref.read(userProvider)?.seerrCredentials;
    apiKeyController = TextEditingController(text: creds?.apiKey ?? '');
    serverController = TextEditingController(text: creds?.serverUrl ?? '');
    localEmailController = TextEditingController();
    localPasswordController = TextEditingController();
    jfUsernameController = TextEditingController();
    jfPasswordController = TextEditingController();
    Future.microtask(_refreshSession);
  }

  @override
  void dispose() {
    apiKeyController.dispose();
    serverController.dispose();
    localEmailController.dispose();
    localPasswordController.dispose();
    jfUsernameController.dispose();
    jfPasswordController.dispose();
    super.dispose();
  }

  Future<void> _refreshSession() async {
    final serverUrl = serverController.text.trim().isNotEmpty
        ? serverController.text.trim()
        : ref.read(userProvider)?.seerrCredentials?.serverUrl.trim();
    if (serverUrl != null && serverUrl.isNotEmpty) {
      ref.read(userProvider.notifier).setSeerrServerUrl(serverUrl);
      serverController.text = serverUrl;
    }

    final creds = ref.read(userProvider)?.seerrCredentials;
    final hasApiKey = creds?.apiKey.isNotEmpty == true;
    final hasSessionCookie = creds?.sessionCookie.isNotEmpty == true;

    if (!hasApiKey && !hasSessionCookie) {
      if (!mounted) return;
      setState(() {
        seerrUser = null;
        error = null;
        loading = false;
      });
      return;
    }

    setState(() {
      loading = true;
      error = null;
    });

    try {
      final user = await ref.read(seerrUserProvider.notifier).refreshUser();
      if (!mounted) return;

      seerrUser = user;
      error = user == null ? context.localized.seerrUserFetchFailed : null;
    } catch (e) {
      if (!mounted) return;
      seerrUser = null;
      error = e.toString();
    } finally {
      if (mounted) {
        loading = false;
        setState(() {});
      }
    }
  }

  bool _applyServerUrl({bool showError = true}) {
    final serverUrl = serverController.text.trim();
    if (serverUrl.isEmpty) {
      if (showError && mounted) {
        setState(() {
          error = context.localized.seerrEnterServerUrlFirst;
        });
      }
      return false;
    }
    ref.read(userProvider.notifier).setSeerrServerUrl(serverUrl);
    return true;
  }

  Future<void> _useApiKey() async {
    if (!_applyServerUrl()) return;
    setState(() {
      processing = true;
      error = null;
    });

    final apiKey = apiKeyController.text.trim();
    ref.read(userProvider.notifier).setSeerrApiKey(apiKey);
    if (apiKey.isNotEmpty) {
      ref.read(userProvider.notifier).setSeerrSessionCookie('');
    }

    await _refreshSession();

    if (mounted) {
      fladderSnackbar(context, title: context.localized.seerrApiKeySaved);
    }

    if (mounted) {
      setState(() {
        processing = false;
      });
      ref.read(seerrDashboardProvider.notifier).clear();
    }
  }

  Future<void> _loginLocal() async {
    if (!_applyServerUrl()) return;
    setState(() {
      processing = true;
      error = null;
    });

    try {
      final cookie = await ref.read(seerrApiProvider).authenticateLocal(
            email: localEmailController.text.trim(),
            password: localPasswordController.text,
          );
      ref.read(userProvider.notifier).setSeerrSessionCookie(cookie);
      ref.read(userProvider.notifier).setSeerrApiKey('');
      await _refreshSession();
      if (mounted) {
        fladderSnackbar(context, title: context.localized.seerrLoggedIn);
      }
    } catch (e) {
      if (mounted) {
        error = e.toString();
        fladderSnackbar(context, title: e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          processing = false;
        });
        ref.read(seerrDashboardProvider.notifier).clear();
      }
    }
  }

  Future<void> _loginJellyfin() async {
    if (!_applyServerUrl()) return;
    setState(() {
      processing = true;
      error = null;
    });

    try {
      final cookie = await ref.read(seerrApiProvider).authenticateJellyfin(
            username: jfUsernameController.text.trim(),
            password: jfPasswordController.text,
          );
      ref.read(userProvider.notifier).setSeerrSessionCookie(cookie);
      ref.read(userProvider.notifier).setSeerrApiKey('');
      await _refreshSession();
      if (mounted) {
        fladderSnackbar(context, title: context.localized.seerrLoggedIn);
      }
    } catch (e) {
      if (mounted) {
        error = e.toString();
        fladderSnackbar(context, title: e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          processing = false;
        });
        ref.read(seerrDashboardProvider.notifier).clear();
      }
    }
  }

  Future<void> _logout() async {
    _applyServerUrl(showError: false);
    setState(() {
      processing = true;
      error = null;
    });

    try {
      await ref.read(seerrApiProvider).logout();
    } catch (e) {
      if (mounted) {
        error = e.toString();
        fladderSnackbar(context, title: e.toString());
      }
    } finally {
      ref.read(userProvider.notifier).logoutSeerr();
      await _refreshSession();
      if (mounted) {
        setState(() {
          processing = false;
        });
      }
    }
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            context.localized.seerr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsaxPlusBold.close_circle),
        ),
      ],
    );
  }

  Widget _errorBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(IconsaxPlusLinear.warning_2, color: Theme.of(context).colorScheme.onErrorContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loggedInContent() {
    final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl ?? '';
    final displayName =
        seerrUser?.displayName ?? seerrUser?.username ?? seerrUser?.email ?? context.localized.seerrUnknownUser;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        if (error != null) _errorBanner(),
        if (serverUrl.isNotEmpty)
          Flexible(
            child: Text(
              context.localized.seerrConnectedToServer(serverUrl),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        Row(
          spacing: 8,
          children: [
            seerrUser?.avatar != null && seerrUser!.avatar!.isNotEmpty
                ? CircleAvatar(backgroundImage: NetworkImage(seerrUser!.avatar!))
                : CircleAvatar(child: Icon(FladderItemType.person.icon)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName),
                Text(seerrUser?.email ?? seerrUser?.username ?? ''),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              onPressed: processing ? null : _logout,
              child: Text(context.localized.logout),
            ),
          ],
        ),
      ],
    );
  }

  Widget _authContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        if (error != null) _errorBanner(),
        FocusedOutlinedTextField(
          label: context.localized.seerrServer,
          controller: serverController,
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            _applyServerUrl();
            _refreshSession();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SegmentedButton<SeerrAuthTab>(
            segments: SeerrAuthTab.values
                .map(
                  (tab) => ButtonSegment(
                    value: tab,
                    label: Text(tab.label(context)),
                  ),
                )
                .toList(),
            selected: {selectedTab},
            onSelectionChanged: (value) {
              setState(() {
                selectedTab = value.first;
              });
            },
            showSelectedIcon: false,
          ),
        ),
        AnimatedFadeSize(child: _authForm()),
      ],
    );
  }

  Widget _authForm() {
    switch (selectedTab) {
      case SeerrAuthTab.apiKey:
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            FocusedOutlinedTextField(
              label: context.localized.seerrAuthApiKey,
              controller: apiKeyController,
              keyboardType: TextInputType.visiblePassword,
              onSubmitted: (_) => _useApiKey(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: processing ? null : _useApiKey,
                  child: processing
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                      : Text(context.localized.save),
                ),
              ],
            ),
          ],
        );
      case SeerrAuthTab.local:
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  OutlinedTextField(
                    label: context.localized.emailUsername,
                    controller: localEmailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  OutlinedTextField(
                    controller: localPasswordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    label: context.localized.password,
                    onSubmitted: (_) => _loginLocal(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: processing ? null : _loginLocal,
                  child: processing
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                      : Text(context.localized.login),
                ),
              ],
            ),
          ],
        );
      case SeerrAuthTab.jellyfin:
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  OutlinedTextField(
                    label: context.localized.username,
                    controller: jfUsernameController,
                    textInputAction: TextInputAction.next,
                  ),
                  OutlinedTextField(
                    controller: jfPasswordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    label: context.localized.password,
                    onSubmitted: (_) => _loginJellyfin(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: processing ? null : _loginJellyfin,
                  child: processing
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                      : Text(context.localized.login),
                ),
              ],
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 640,
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            _header(context),
            if (loading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
              )
            else
              AnimatedFadeSize(child: seerrUser != null ? _loggedInContent() : _authContent()),
          ],
        ),
      ),
    );
  }
}
