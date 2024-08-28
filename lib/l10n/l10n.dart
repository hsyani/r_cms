import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ko'),
  ];

  static Future<Map<String, String>> loadJson(String locale) async {
    final String response =
        await rootBundle.loadString('assets/lang/$locale.json');
    final data = await json.decode(response);
    return Map<String, String>.from(data);
  }

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;
    return _LocalizedStrings.of(context)?.localizedStrings[key] ??
        key; // key를 기본 값으로 반환
  }
}

class _LocalizedStrings {
  final Map<String, String> localizedStrings;
  _LocalizedStrings(this.localizedStrings);

  static _LocalizedStrings? of(BuildContext context) {
    return Localizations.of<_LocalizedStrings>(context, _LocalizedStrings);
  }
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<_LocalizedStrings> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ko'].contains(locale.languageCode);

  @override
  Future<_LocalizedStrings> load(Locale locale) async {
    final localizedStrings = await L10n.loadJson(locale.languageCode);
    return _LocalizedStrings(localizedStrings);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
