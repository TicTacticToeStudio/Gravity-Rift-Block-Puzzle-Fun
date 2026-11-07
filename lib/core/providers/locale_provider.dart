import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Storage key for the persisted language code (e.g. "en", "ru").
const String _kLocaleStorageKey = 'app_locale';

// Provides the locale that should be used when the LocaleNotifier is first
// built. Defaults to English. Overridden in main() with the value loaded
// from SharedPreferences, so the very first frame of the app is already
// rendered in the player's chosen language (no English flash).
final initialLocaleProvider = Provider<Locale>((ref) => const Locale('en'));

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return ref.read(initialLocaleProvider);
  }

  void changeLocale(Locale newLocale) {
    if (newLocale == state) return;
    state = newLocale;
    _persist(newLocale);
  }

  Future<void> _persist(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleStorageKey, locale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);