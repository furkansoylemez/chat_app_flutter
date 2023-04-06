import 'dart:ui' as ui;

import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localizationsProvider = Provider<AppLocalizations>((ref) {
  ref.state = lookupAppLocalizations(ui.window.locale);

  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(ui.window.locale);
  });

  final binding = WidgetsBinding.instance..addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));

  return ref.state;
});

class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);

  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
