// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'SpaceCore: Block Puzzle & Fun';

  @override
  String get scoreLabel => 'ОЧКИ';

  @override
  String get gameOverTitle => 'Отличная игра!';

  @override
  String get gameOverBody => 'Не осталось места для новых блоков.';

  @override
  String yourScore(int score) {
    return 'Твой счет: $score';
  }

  @override
  String get playAgain => 'Играть снова';

  @override
  String get classicMode => 'КЛАССИЧЕСКИЙ РЕЖИМ';

  @override
  String get classicModeSub => 'Бесконечный пазл. Побей свой рекорд.';

  @override
  String get treasureMode => 'ОХОТА ЗА СОКРОВИЩАМИ';

  @override
  String get treasureModeSub => 'Собирай редкие кристаллы.';

  @override
  String get playFreeOffline => 'Играйте бесплатно офлайн';

  @override
  String get comingSoon => 'Скоро!';

  @override
  String get moreGames => 'Другие игры';

  @override
  String get myGamesTitle => 'Мои игры';

  @override
  String get playNow => 'Играть';

  @override
  String get sound => 'Звук';

  @override
  String get continueGame => 'ПРОДОЛЖИТЬ';

  @override
  String get newGame => 'НОВАЯ ИГРА';

  @override
  String get saveAndExit => 'СОХРАНИТЬ И ВЫЙТИ';

  @override
  String get exitWithoutSaving => 'ВЫЙТИ БЕЗ СОХРАНЕНИЯ';

  @override
  String get pauseTitle => 'ПАУЗА';

  @override
  String get resume => 'ПРОДОЛЖИТЬ';

  @override
  String get restart => 'ЗАНОВО';

  @override
  String get soundOn => 'ЗВУК: ВКЛ';

  @override
  String get soundOff => 'ЗВУК: ВЫКЛ';
}
