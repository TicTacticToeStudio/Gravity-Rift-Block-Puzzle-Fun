import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:energy_blast/core/providers/locale_provider.dart';
import 'package:energy_blast/core/providers/settings_provider.dart';
import 'package:energy_blast/core/services/rewarded_ad_manager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  RewardedAdManager.initialize();

  final prefs = await SharedPreferences.getInstance();

  final String? savedCode = prefs.getString('app_locale');
  final Locale initialLocale =
  (savedCode != null && savedCode.isNotEmpty) ? Locale(savedCode) : const Locale('en');

  final bool initialSound = prefs.getBool('sound_on') ?? true;
  final bool initialVibration = prefs.getBool('vibration_on') ?? true;

  runApp(
    ProviderScope(
      overrides: [
        initialLocaleProvider.overrideWithValue(initialLocale),
        initialSettingsProvider.overrideWithValue(
          SettingsState(isSoundOn: initialSound, isVibrationOn: initialVibration),
        ),
      ],
      child: const EnergyBlastApp(),
    ),
  );
}