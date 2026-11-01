import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/core/services/rewarded_ad_manager.dart'; // ИМПОРТ

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RewardedAdManager.initialize(); // ИНИЦИАЛИЗАЦИЯ РЕКЛАМЫ

  runApp(const ProviderScope(child: EnergyBlastApp()));
}