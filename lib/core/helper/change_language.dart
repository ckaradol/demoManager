import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/app_translate.dart';

void changeLanguage(BuildContext context) {
  final current = context.locale;
  final index = AppTranslate.supportedLocales.indexOf(current);

  // sonraki index → sona geldiyse başa dön
  final nextIndex = (index + 1) % AppTranslate.supportedLocales.length;

  final nextLocale = AppTranslate.supportedLocales[nextIndex];

  context.setLocale(nextLocale);
}
