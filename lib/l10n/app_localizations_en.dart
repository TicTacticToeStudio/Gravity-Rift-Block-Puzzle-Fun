// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SpaceCore: Block Puzzle & Fun';

  @override
  String get scoreLabel => 'SCORE';

  @override
  String get gameOverTitle => 'Great Game!';

  @override
  String get gameOverBody => 'There is no space left for new blocks.';

  @override
  String yourScore(int score) {
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
}
