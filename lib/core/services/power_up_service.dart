import 'package:shared_preferences/shared_preferences.dart';

enum PowerUpType { surprise, hammer, shuffle, hint, undo }

class PowerUpService {
  static const String _keySurprise = 'count_surprise';
  static const String _keyHammer = 'count_hammer';
  static const String _keyShuffle = 'count_shuffle';
  static const String _keyHint = 'count_hint';
  static const String _keyUndo = 'count_undo';

  // Load current counts from device memory
  static Future<Map<PowerUpType, int>> loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      PowerUpType.surprise: prefs.getInt(_keySurprise) ?? 2,
      PowerUpType.hammer: prefs.getInt(_keyHammer) ?? 2,
      PowerUpType.shuffle: prefs.getInt(_keyShuffle) ?? 2,
      PowerUpType.hint: prefs.getInt(_keyHint) ?? 2,
      PowerUpType.undo: prefs.getInt(_keyUndo) ?? 3,
    };
  }

  // Save a specific power-up count
  static Future<void> saveCount(PowerUpType type, int count) async {
    final prefs = await SharedPreferences.getInstance();
    switch (type) {
      case PowerUpType.surprise:
        await prefs.setInt(_keySurprise, count);
        break;
      case PowerUpType.hammer:
        await prefs.setInt(_keyHammer, count);
        break;
      case PowerUpType.shuffle:
        await prefs.setInt(_keyShuffle, count);
        break;
      case PowerUpType.hint:
        await prefs.setInt(_keyHint, count);
        break;
      case PowerUpType.undo:
        await prefs.setInt(_keyUndo, count);
        break;
    }
  }

  // NEW: Resets all bonuses to factory defaults for a brand new game
  static Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySurprise, 2);
    await prefs.setInt(_keyHammer, 2);
    await prefs.setInt(_keyShuffle, 2);
    await prefs.setInt(_keyHint, 2);
    await prefs.setInt(_keyUndo, 3);
  }
}