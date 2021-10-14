
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uni_dating/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  late Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null as Locale;
    notifyListeners();
  }
}
