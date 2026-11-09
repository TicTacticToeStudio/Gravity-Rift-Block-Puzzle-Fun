// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'ОЧКИ';

  @override
  String get gameOverTitle => 'Отличная игра!';

  @override
  String get gameOverBody => 'Не осталось места для новых блоков.';

  @override
  String yourScore(Object score) {
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

  @override
  String get vibrationOn => 'ВИБРАЦИЯ: ВКЛ';

  @override
  String get vibrationOff => 'ВИБРАЦИЯ: ВЫКЛ';

  @override
  String get nothingToUndo => 'Пока нечего отменять!';

  @override
  String get outOfUndos => 'Отмены закончились!';

  @override
  String get adUnavailableUndo => 'Реклама недоступна. Вот ваша отмена!';

  @override
  String get outOfMovesTitle => 'Нет ходов!';

  @override
  String get outOfMovesBody =>
      'Мы подготовили для вас бонус спасения. Используйте бонус, чтобы продолжить.';

  @override
  String get openBonuses => 'ОТКРЫТЬ БОНУСЫ';

  @override
  String get endSession => 'ЗАВЕРШИТЬ СЕССИЮ';

  @override
  String get sessionEnded => 'Ваша сессия завершена.';

  @override
  String get startNewGame => 'НАЧАТЬ НОВУЮ ИГРУ';

  @override
  String get outOfSpace => 'ИГРА ОКОНЧЕНА';

  @override
  String get hexGameTitle => 'Hex Крестики-нолики: Веселье и Стратегия';

  @override
  String get hexGameDesc =>
      'Hex Крестики-нолики. Играйте офлайн против Бота или друга. Анализ игр. Турниры.';

  @override
  String get tttGameTitle => 'Крестики-нолики: Веселье и Стратегия';

  @override
  String get tttGameDesc =>
      'Бот или друг, глубокий анализ, адаптивный геймплей. Крестики-нолики — но тактически.';

  @override
  String get comingSoonTitle => 'Скоро';

  @override
  String get comingSoonDesc => 'Следите за нашими новыми головоломками!';

  @override
  String get resumeYourGame => 'Продолжить игру';

  @override
  String get startFresh => 'Начать заново';

  @override
  String get topScores => 'РЕКОРДЫ';

  @override
  String get noRecordsYet => 'Пока нет рекордов. Сыграйте!';

  @override
  String get close => 'ЗАКРЫТЬ';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String daysAgo(Object days) {
    return '$days дн. назад';
  }

  @override
  String get bonusesTitle => 'БОНУСЫ';

  @override
  String get rescueBonusesTitle => 'БОНУСЫ СПАСЕНИЯ';

  @override
  String get selectBonusToSave => 'Выберите бонус, чтобы спасти игру';

  @override
  String get bonusSurprise => 'Сюрприз';

  @override
  String get bonusHammer => 'Молот';

  @override
  String get bonusNewBlocks => 'Новые блоки';

  @override
  String get bonusHint => 'Подсказка';

  @override
  String useBonus(int count) {
    return 'ИСП. ($count)';
  }

  @override
  String get adButton => 'РЕКЛАМА';

  @override
  String get limitLabel => 'ЛИМИТ';

  @override
  String get adUnavailableBonus => 'Реклама недоступна. Вот ваш бонус!';

  @override
  String get noMovesFound => 'Ходов не найдено! Используйте другой бонус.';

  @override
  String get perfectClear => 'ИДЕАЛЬНАЯ ОЧИСТКА!';

  @override
  String missLabel(int amount) {
    return 'МИМО +$amount';
  }

  @override
  String get crossMultiplier => 'КРЕСТ x10!';

  @override
  String comboMultiplier(int level) {
    return 'КОМБО x$level!';
  }

  @override
  String get infoComingSoon => 'Меню информации скоро появится';

  @override
  String get languageTitle => 'Язык';
}
