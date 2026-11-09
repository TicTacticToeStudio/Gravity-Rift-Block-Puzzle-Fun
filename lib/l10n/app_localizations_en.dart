// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'SCORE';

  @override
  String get gameOverTitle => 'Great Game!';

  @override
  String get gameOverBody => 'There is no space left for new blocks.';

  @override
  String yourScore(Object score) {
    return 'Your Score: $score';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get classicMode => 'CLASSIC MODE';

  @override
  String get classicModeSub => 'Endless block puzzle. Beat your score.';

  @override
  String get treasureMode => 'TREASURE HUNT';

  @override
  String get treasureModeSub => 'Collect rare crystals.';

  @override
  String get playFreeOffline => 'Play free offline';

  @override
  String get comingSoon => 'Coming Soon!';

  @override
  String get moreGames => 'More Games';

  @override
  String get myGamesTitle => 'My Games';

  @override
  String get playNow => 'Play Now';

  @override
  String get sound => 'Sound';

  @override
  String get continueGame => 'CONTINUE';

  @override
  String get newGame => 'NEW GAME';

  @override
  String get saveAndExit => 'SAVE & EXIT';

  @override
  String get exitWithoutSaving => 'EXIT WITHOUT SAVING';

  @override
  String get pauseTitle => 'PAUSED';

  @override
  String get resume => 'RESUME';

  @override
  String get restart => 'RESTART';

  @override
  String get soundOn => 'SOUND: ON';

  @override
  String get soundOff => 'SOUND: OFF';

  @override
  String get vibrationOn => 'VIBRATION: ON';

  @override
  String get vibrationOff => 'VIBRATION: OFF';

  @override
  String get nothingToUndo => 'Nothing to undo yet!';

  @override
  String get outOfUndos => 'Out of Undos!';

  @override
  String get adUnavailableUndo => 'Ad unavailable. Here is your undo!';

  @override
  String get outOfMovesTitle => 'Out of Moves!';

  @override
  String get outOfMovesBody =>
      'We\'ve prepared a rescue bonus for you. Use a bonus to continue.';

  @override
  String get openBonuses => 'OPEN BONUSES';

  @override
  String get endSession => 'END SESSION';

  @override
  String get sessionEnded => 'Your session has ended.';

  @override
  String get startNewGame => 'START NEW GAME';

  @override
  String get outOfSpace => 'GAME OVER';

  @override
  String get hexGameTitle => 'Hex Tic Tac Toe Fun & Strategy';

  @override
  String get hexGameDesc =>
      'Hex Tic Tac Toe. Play offline vs Bot or friend. Game analysis. Tournaments.';

  @override
  String get tttGameTitle => 'Tic Tac Toe: Fun & Strategy';

  @override
  String get tttGameDesc =>
      'Bot or friend, deep analysis, adaptive gameplay. Tic Tac Toe — but tactical.';

  @override
  String get comingSoonTitle => 'Coming Soon';

  @override
  String get comingSoonDesc => 'Stay tuned for our next puzzle!';

  @override
  String get resumeYourGame => 'Resume your game';

  @override
  String get startFresh => 'Start fresh';

  @override
  String get topScores => 'TOP SCORES';

  @override
  String get noRecordsYet => 'No records yet. Play a game!';

  @override
  String get close => 'CLOSE';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(Object days) {
    return '$days days ago';
  }

  @override
  String get bonusesTitle => 'BONUSES';

  @override
  String get rescueBonusesTitle => 'RESCUE BONUSES';

  @override
  String get selectBonusToSave => 'Select a bonus to save your game';

  @override
  String get bonusSurprise => 'Surprise';

  @override
  String get bonusHammer => 'Hammer';

  @override
  String get bonusNewBlocks => 'New Blocks';

  @override
  String get bonusHint => 'Hint';

  @override
  String useBonus(int count) {
    return 'USE ($count)';
  }

  @override
  String get adButton => 'AD';

  @override
  String get limitLabel => 'LIMIT';

  @override
  String get adUnavailableBonus => 'Ad unavailable. Here is your bonus!';

  @override
  String get noMovesFound => 'No moves found! Use another bonus.';

  @override
  String get perfectClear => 'PERFECT CLEAR!';

  @override
  String missLabel(int amount) {
    return 'MISS +$amount';
  }

  @override
  String get crossMultiplier => 'CROSS x10!';

  @override
  String comboMultiplier(int level) {
    return 'COMBO x$level!';
  }

  @override
  String get infoComingSoon => 'Info menu coming soon';

  @override
  String get languageTitle => 'Language';
}
