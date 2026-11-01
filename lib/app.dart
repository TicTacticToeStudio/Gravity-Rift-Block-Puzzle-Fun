import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/theme/app_theme.dart';
import 'package:energy_blast/core/providers/locale_provider.dart';
import 'package:energy_blast/features/game/presentation/pages/main_menu_page.dart';
import 'package:energy_blast/l10n/app_localizations.dart';

class EnergyBlastApp extends ConsumerWidget { // Changed to ConsumerWidget
  const EnergyBlastApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the locale from our provider
    final currentLocale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: currentLocale, // Apply the selected language
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.darkTheme,
      home: const MainMenuPage(),
    );
  }
}