import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SaveGameService {
  // The key used to store the game state in SharedPreferences
  static const String _keySave = 'saved_game_state';

  // Saves the current game state as a JSON string
  static Future<void> saveGame(Map<String, dynamic> stateJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySave, jsonEncode(stateJson));
  }

  // Loads the saved game state. Returns null if no save exists.
  static Future<Map<String, dynamic>?> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_keySave);
    if (str == null) return null;

    try {
      return jsonDecode(str);
    } catch (e) {
      // If the JSON is corrupted, clear it and return null
      await clearSave();
      return null;
    }
  }

  // Deletes the saved game from memory
  static Future<void> clearSave() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySave);
  }

  // Checks if a saved game exists
  static Future<bool> hasSavedGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keySave);
  }
}