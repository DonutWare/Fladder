import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/src/translations_pigeon.g.dart' as messenger;

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
  _TranslationsMessgener? _messenger;
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
    if (_messenger == null) {
      _messenger = _TranslationsMessgener(context: context);
      messenger.TranslationsPigeon.setUp(_messenger);
    }

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
    final buffer = StringBuffer();

    buffer.write(languageCode.toLowerCase());

    if (scriptCode != null && scriptCode!.isNotEmpty) {
      buffer.write('_${scriptCode![0].toUpperCase()}${scriptCode!.substring(1).toLowerCase()}');
    }

    if (countryCode != null && countryCode!.isNotEmpty) {
      buffer.write('_${countryCode!.toUpperCase()}');
    }

    return buffer.toString();
  }
}

class _TranslationsMessgener extends messenger.TranslationsPigeon {
  _TranslationsMessgener({required this.context});

  final BuildContext context;

  @override
  String chapters(int count) => context.localized.chapter(count);

  @override
  String close() => context.localized.close;

  @override
  String endsAt(String time) => context.localized.endsAt(DateTime.parse(time).toLocal());

  @override
  String next() => context.localized.nextVideo;

  @override
  String nextUpInSeconds(int seconds) => context.localized.nextUpInCount(seconds);

  @override
  String nextVideo() => context.localized.nextVideo;

  @override
  String off() => context.localized.off;

  @override
  String skip(String name) => context.localized.skipButtonLabel(name);

  @override
  String subtitles() => context.localized.subtitles;

  @override
  String hoursAndMinutes(String time) => context.localized.formattedTime(DateTime.parse(time).toLocal());

  @override
  String decline() => context.localized.decline;

  @override
  String now() => context.localized.now;

  @override
  String switchChannel() => context.localized.switchChannel;

  @override
  String switchChannelDesc(String programName, String channelName) =>
      context.localized.switchChannelDesc(programName, channelName);

  @override
  String watch() => context.localized.watch;
}
