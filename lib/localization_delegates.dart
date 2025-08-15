import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: implementation_imports
import 'package:flutter_localizations/src/utils/date_localizations.dart' as util;
import 'package:intl/intl.dart' as intl;

import 'package:fladder/l10n/generated/app_localizations.dart';

class FladderLocalizations {
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    AppLocalizations.delegate,
    FladderMaterialLocalizationsDelegate(),
    FladderCupertinoLocalizationsDelegate(),
    FladderWidgetsLocalizationsDelegate(),
  ];
}

class FladderMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const FladderMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  static final Map<Locale, Future<MaterialLocalizations>> _loadedTranslations =
      <Locale, Future<MaterialLocalizations>>{};

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    Locale correctedLocale = locale;
    if (!kMaterialSupportedLanguages.contains(locale.languageCode)) {
      correctedLocale = const Locale("en");
    }
    assert(isSupported(correctedLocale));
    return _loadedTranslations.putIfAbsent(correctedLocale, () {
      util.loadDateIntlDataIfNotLoaded();

      final String localeName = intl.Intl.canonicalizedLocale(correctedLocale.toString());
      assert(
        correctedLocale.toString() == localeName,
        'Flutter does not support the non-standard locale form $correctedLocale (which '
        'might be $localeName',
      );

      intl.DateFormat fullYearFormat;
      intl.DateFormat compactDateFormat;
      intl.DateFormat shortDateFormat;
      intl.DateFormat mediumDateFormat;
      intl.DateFormat longDateFormat;
      intl.DateFormat yearMonthFormat;
      intl.DateFormat shortMonthDayFormat;
      if (intl.DateFormat.localeExists(localeName)) {
        fullYearFormat = intl.DateFormat.y(localeName);
        compactDateFormat = intl.DateFormat.yMd(localeName);
        shortDateFormat = intl.DateFormat.yMMMd(localeName);
        mediumDateFormat = intl.DateFormat.MMMEd(localeName);
        longDateFormat = intl.DateFormat.yMMMMEEEEd(localeName);
        yearMonthFormat = intl.DateFormat.yMMMM(localeName);
        shortMonthDayFormat = intl.DateFormat.MMMd(localeName);
      } else if (intl.DateFormat.localeExists(correctedLocale.languageCode)) {
        fullYearFormat = intl.DateFormat.y(correctedLocale.languageCode);
        compactDateFormat = intl.DateFormat.yMd(correctedLocale.languageCode);
        shortDateFormat = intl.DateFormat.yMMMd(correctedLocale.languageCode);
        mediumDateFormat = intl.DateFormat.MMMEd(correctedLocale.languageCode);
        longDateFormat = intl.DateFormat.yMMMMEEEEd(correctedLocale.languageCode);
        yearMonthFormat = intl.DateFormat.yMMMM(correctedLocale.languageCode);
        shortMonthDayFormat = intl.DateFormat.MMMd(correctedLocale.languageCode);
      } else {
        fullYearFormat = intl.DateFormat.y();
        compactDateFormat = intl.DateFormat.yMd();
        shortDateFormat = intl.DateFormat.yMMMd();
        mediumDateFormat = intl.DateFormat.MMMEd();
        longDateFormat = intl.DateFormat.yMMMMEEEEd();
        yearMonthFormat = intl.DateFormat.yMMMM();
        shortMonthDayFormat = intl.DateFormat.MMMd();
      }

      intl.NumberFormat decimalFormat;
      intl.NumberFormat twoDigitZeroPaddedFormat;
      if (intl.NumberFormat.localeExists(localeName)) {
        decimalFormat = intl.NumberFormat.decimalPattern(localeName);
        twoDigitZeroPaddedFormat = intl.NumberFormat('00', localeName);
      } else if (intl.NumberFormat.localeExists(correctedLocale.languageCode)) {
        decimalFormat = intl.NumberFormat.decimalPattern(correctedLocale.languageCode);
        twoDigitZeroPaddedFormat = intl.NumberFormat('00', correctedLocale.languageCode);
      } else {
        decimalFormat = intl.NumberFormat.decimalPattern();
        twoDigitZeroPaddedFormat = intl.NumberFormat('00');
      }

      return SynchronousFuture<MaterialLocalizations>(
        getMaterialTranslation(
          correctedLocale,
          fullYearFormat,
          compactDateFormat,
          shortDateFormat,
          mediumDateFormat,
          longDateFormat,
          yearMonthFormat,
          shortMonthDayFormat,
          decimalFormat,
          twoDigitZeroPaddedFormat,
        )!,
      );
    });
  }

  @override
  bool shouldReload(FladderMaterialLocalizationsDelegate old) => false;

  @override
  String toString() => 'GlobalMaterialLocalizations.delegate(${kMaterialSupportedLanguages.length} locales)';
}

class FladderWidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const FladderWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  static final Map<Locale, Future<WidgetsLocalizations>> _loadedTranslations = <Locale, Future<WidgetsLocalizations>>{};

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    Locale correctedLocale = locale;
    if (!kMaterialSupportedLanguages.contains(locale.languageCode)) {
      correctedLocale = const Locale("en");
    }
    assert(isSupported(correctedLocale));
    return _loadedTranslations.putIfAbsent(correctedLocale, () {
      return SynchronousFuture<WidgetsLocalizations>(getWidgetsTranslation(correctedLocale)!);
    });
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<WidgetsLocalizations> old) => false;
}

class FladderCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FladderCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  static final Map<Locale, Future<CupertinoLocalizations>> _loadedTranslations =
      <Locale, Future<CupertinoLocalizations>>{};

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    Locale correctedLocale = locale;
    if (!kMaterialSupportedLanguages.contains(locale.languageCode)) {
      correctedLocale = const Locale("en");
    }
    assert(isSupported(correctedLocale));
    return _loadedTranslations.putIfAbsent(correctedLocale, () {
      util.loadDateIntlDataIfNotLoaded();

      final String localeName = intl.Intl.canonicalizedLocale(correctedLocale.toString());
      assert(
        correctedLocale.toString() == localeName,
        'Flutter does not support the non-standard locale form $correctedLocale (which '
        'might be $localeName',
      );

      late intl.DateFormat fullYearFormat;
      late intl.DateFormat dayFormat;
      late intl.DateFormat weekdayFormat;
      late intl.DateFormat mediumDateFormat;
      // We don't want any additional decoration here. The am/pm is handled in
      // the date picker. We just want an hour number localized.
      late intl.DateFormat singleDigitHourFormat;
      late intl.DateFormat singleDigitMinuteFormat;
      late intl.DateFormat doubleDigitMinuteFormat;
      late intl.DateFormat singleDigitSecondFormat;
      late intl.NumberFormat decimalFormat;

      void loadFormats(String? correctedLocale) {
        fullYearFormat = intl.DateFormat.y(correctedLocale);
        dayFormat = intl.DateFormat.d(correctedLocale);
        weekdayFormat = intl.DateFormat.E(correctedLocale);
        mediumDateFormat = intl.DateFormat.MMMEd(correctedLocale);
        singleDigitHourFormat = intl.DateFormat('HH', correctedLocale);
        singleDigitMinuteFormat = intl.DateFormat.m(correctedLocale);
        doubleDigitMinuteFormat = intl.DateFormat('mm', correctedLocale);
        singleDigitSecondFormat = intl.DateFormat.s(correctedLocale);
        decimalFormat = intl.NumberFormat.decimalPattern(correctedLocale);
      }

      if (intl.DateFormat.localeExists(localeName)) {
        loadFormats(localeName);
      } else if (intl.DateFormat.localeExists(correctedLocale.languageCode)) {
        loadFormats(correctedLocale.languageCode);
      } else {
        loadFormats(null);
      }

      return SynchronousFuture<CupertinoLocalizations>(
        getCupertinoTranslation(
          correctedLocale,
          fullYearFormat,
          dayFormat,
          weekdayFormat,
          mediumDateFormat,
          singleDigitHourFormat,
          singleDigitMinuteFormat,
          doubleDigitMinuteFormat,
          singleDigitSecondFormat,
          decimalFormat,
        )!,
      );
    });
  }

  @override
  bool shouldReload(FladderCupertinoLocalizationsDelegate old) => false;

  @override
  String toString() => 'GlobalCupertinoLocalizations.delegate(${kCupertinoSupportedLanguages.length} locales)';
}
