import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier to manage the current locale
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Default language: English
    return const Locale('en');
  }

  void changeLocale(Locale newLocale) {
    state = newLocale;
  }
}

// Global provider
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);