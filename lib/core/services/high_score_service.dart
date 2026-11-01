import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreRecord {
  final String runId; // NEW: Unique ID for the game session
  final int score;
  final DateTime date;

  ScoreRecord({required this.runId, required this.score, required this.date});

  Map<String, dynamic> toJson() => {
    'runId': runId,
    'score': score,
    'date': date.toIso8601String(),
  };

  factory ScoreRecord.fromJson(Map<String, dynamic> json) => ScoreRecord(
    runId: json['runId'] ?? '',
    score: json['score'],
    date: DateTime.parse(json['date']),
  );
}

class HighScoreService {
  static const String _key = 'top_scores';

  static Future<List<ScoreRecord>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<ScoreRecord> scores = jsonList.map((e) => ScoreRecord.fromJson(e)).toList();

    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores;
  }

  // Now requires runId to update existing scores instead of duplicating them
  static Future<void> saveScore(int newScore, String runId) async {
    if (newScore <= 0) return;

    final scores = await getScores();

    // Check if this run already exists in the leaderboard
    final existingIndex = scores.indexWhere((s) => s.runId == runId);

    if (existingIndex != -1) {
      // Update the score if it's higher
      if (newScore > scores[existingIndex].score) {
        scores[existingIndex] = ScoreRecord(runId: runId, score: newScore, date: DateTime.now());
      }
    } else {
      // Add as new record
      scores.add(ScoreRecord(runId: runId, score: newScore, date: DateTime.now()));
    }

    scores.sort((a, b) => b.score.compareTo(a.score));
    final topScores = scores.take(5).toList();

    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(topScores.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  static String formatDate(DateTime date, String localeCode) {
    final formatter = DateFormat.yMMMd(localeCode);
    return formatter.format(date);
  }
}