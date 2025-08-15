import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';

///Only use for base translations, under normal circumstances ALWAYS use the widgets provided context
final localizationContextProvider = StateProvider<BuildContext?>((ref) => null);

extension BuildContextExtension on BuildContext {
  AppLocalizations get localized => AppLocalizations.of(this);
}

class LocalizationContextWrapper extends ConsumerStatefulWidget {
  final Widget child;
  final Locale currentLocale;
  const LocalizationContextWrapper({
    required this.child,
    required this.currentLocale,
    super.key,
  });

  @override
  ConsumerState<LocalizationContextWrapper> createState() => _LocalizationContextWrapperState();
}

class _LocalizationContextWrapperState extends ConsumerState<LocalizationContextWrapper> {
  @override
  void initState() {
    super.initState();
    updateLanguageContext();
  }

  @override
  void didUpdateWidget(covariant LocalizationContextWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocale != widget.currentLocale) {
      updateLanguageContext();
    }
  }

  void updateLanguageContext() {
    WidgetsBinding.instance.addPostFrameCallback((value) {
      ref.read(localizationContextProvider.notifier).update((cb) => context);
      ref.read(backgroundDownloaderProvider.notifier).updateTranslations(context);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

extension LocaleDisplayCodeExtension on Locale {
  String toDisplayCode() {
    return countryCode != null && countryCode!.isNotEmpty
        ? "${languageCode.toUpperCase()}-${countryCode!.toUpperCase()}"
        : languageCode.toUpperCase();
  }
}
