import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

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

    final scriptCode = this.scriptCode;
    final countryCode = this.countryCode;

    if (scriptCode != null && scriptCode.isNotEmpty) {
      buffer.write('_${scriptCode[0].toUpperCase()}${scriptCode.substring(1).toLowerCase()}');
    }

    if (countryCode != null && countryCode.isNotEmpty) {
      buffer.write('_${countryCode.toUpperCase()}');
    }

    return buffer.toString();
  }
}

class _TranslationsMessgener extends messenger.TranslationsPigeon {
  _TranslationsMessgener({required this.context});

  final BuildContext context;

  @override
  Future<String> chapters(int count) async => context.localized.chapter(count);

  @override
  Future<String> close() async => context.localized.close;

  @override
  Future<String> endsAt(String time) async => context.localized.endsAt(DateTime.parse(time).toLocal());

  @override
  Future<String> next() async => context.localized.nextVideo;

  @override
  Future<String> nextUpInSeconds(int seconds) async => context.localized.nextUpInCount(seconds);

  @override
  Future<String> nextVideo() async => context.localized.nextVideo;

  @override
  Future<String> off() async => context.localized.off;

  @override
  Future<String> skip(String name) async => context.localized.skipButtonLabel(name);

  @override
  Future<String> subtitles() async => context.localized.subtitles;

  @override
  Future<String> hoursAndMinutes(String time) async => context.localized.formattedTime(DateTime.parse(time).toLocal());

  @override
  Future<String> decline() async => context.localized.decline;

  @override
  Future<String> now() async => context.localized.now;

  @override
  Future<String> switchChannel() async => context.localized.switchChannel;

  @override
  Future<String> switchChannelDesc(String programName, String channelName) async =>
      context.localized.switchChannelDesc(programName, channelName);

  @override
  Future<String> watch() async => context.localized.watch;
}
