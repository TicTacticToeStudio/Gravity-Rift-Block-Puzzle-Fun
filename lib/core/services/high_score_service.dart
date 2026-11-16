import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:energy_blast/l10n/app_localizations.dart';

class ScoreRecord {
  final String runId; // Unique ID for the game session
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

  static Future<void> saveScore(int newScore, String runId) async {
    if (newScore <= 0) return;

    // Use the current time when the score is saved.
    // This ensures the leaderboard always shows "Today" if the record was just set.
    final DateTime scoreDate = DateTime.now();

    final scores = await getScores();

    // Check if this run already exists in the leaderboard
    final existingIndex = scores.indexWhere((s) => s.runId == runId);

    if (existingIndex != -1) {
      // Update the score if it's higher, and refresh the date
      if (newScore > scores[existingIndex].score) {
        scores[existingIndex] = ScoreRecord(runId: runId, score: newScore, date: scoreDate);
      }
    } else {
      // Add as new record
      scores.add(ScoreRecord(runId: runId, score: newScore, date: scoreDate));
    }

    scores.sort((a, b) => b.score.compareTo(a.score));
    final topScores = scores.take(5).toList();

    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(topScores.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  // Changed to use relative dates for better localization and added 30+ days cap
  static String formatRelativeDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final recordDate = DateTime(date.year, date.month, date.day);

    final difference = today.difference(recordDate).inDays;

    // difference <= 0 handles "Today" and protects against timezone weirdness
    if (difference <= 0) {
      return l10n.today;
    } else if (difference == 1) {
      return l10n.yesterday;
    } else if (difference > 30) {
      return l10n.veryLongAgo;
    } else {
      return l10n.daysAgo(difference);
    }
  }
}