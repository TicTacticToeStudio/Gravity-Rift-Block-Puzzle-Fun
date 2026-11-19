// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'РЕЗУЛЬТАТ';

  @override
  String get gameOverTitle => 'Чудова гра!';

  @override
  String get gameOverBody => 'Не залишилося місця для нових блоків.';

  @override
  String yourScore(Object score) {
    return 'Ваш результат: $score';
  }

  @override
  String get playAgain => 'Зіграти ще раз';

  @override
  String get classicMode => 'КЛАСИЧНИЙ РЕЖИМ';

  @override
  String get classicModeSub =>
      'Безкінечна головоломка з блоками. Побийте свій рекорд.';

  @override
  String get treasureMode => 'ПОШУК СКАРБІВ';

  @override
  String get treasureModeSub => 'Збирайте рідкісні кристали.';

  @override
  String get playFreeOffline => 'Грати безкоштовно в автономному режимі';

  @override
  String get comingSoon => 'Скоро з\'явиться!';

  @override
  String get moreGames => 'Більше ігор';

  @override
  String get myGamesTitle => 'Мої ігри';

  @override
  String get playNow => 'Грати зараз';

  @override
  String get sound => 'Звук';

  @override
  String get continueGame => 'ПРОДОВЖИТИ';

  @override
  String get newGame => 'НОВА ГРА';

  @override
  String get saveAndExit => 'ЗБЕРЕГТИ ТА ВИЙТИ';

  @override
  String get exitWithoutSaving => 'ВИЙТИ БЕЗ ЗБЕРЕЖЕННЯ';

  @override
  String get pauseTitle => 'ПАУЗА';

  @override
  String get resume => 'ПРОДОВЖИТИ';

  @override
  String get restart => 'ПЕРЕЗАПУСТИТИ';

  @override
  String get soundOn => 'ЗВУК: УВІМКНЕНО';

  @override
  String get soundOff => 'ЗВУК: ВИМКНЕНО';

  @override
  String get vibrationOn => 'ВІБРАЦІЯ: УВІМКНЕНО';

  @override
  String get vibrationOff => 'ВІБРАЦІЯ: ВИМКНЕНО';

  @override
  String get nothingToUndo => 'Поки що немає чого скасувати!';

  @override
  String get outOfUndos => 'Немає більше можливостей скасування!';

  @override
  String get adUnavailableUndo =>
      'Реклама недоступна. Ось ваша можливість скасування!';

  @override
  String get outOfMovesTitle => 'Немає більше ходів!';

  @override
  String get outOfMovesBody =>
      'Ми підготували для вас рятувальний бонус. Використайте бонус, щоб продовжити.';

  @override
  String get openBonuses => 'ВІДКРИТИ БОНУСИ';

  @override
  String get endSession => 'ЗАВЕРШИТИ СЕСІЮ';

  @override
  String get sessionEnded => 'Ваша сесія завершилася.';

  @override
  String get startNewGame => 'ПОЧАТИ НОВУ ГРУ';

  @override
  String get outOfSpace => 'ГРА ЗАВЕРШЕНА';

  @override
  String get hexGameTitle => 'Hex Tic Tac Toe: Розвага та стратегія';

  @override
  String get hexGameDesc =>
      'Hex Tic Tac Toe. Грайте офлайн проти бота або друга. Аналіз гри. Турніри.';

  @override
  String get tttGameTitle => 'Хрестики-нулики: розвага та стратегія';

  @override
  String get tttGameDesc =>
      'Бот або друг, глибокий аналіз, адаптивний ігровий процес. Хрестики-нулики — але тактичні.';

  @override
  String get comingSoonTitle => 'Скоро';

  @override
  String get comingSoonDesc =>
      'Слідкуйте за новинами про нашу наступну головоломку!';

  @override
  String get resumeYourGame => 'Продовжити гру';

  @override
  String get startFresh => 'Почати з нуля';

  @override
  String get topScores => 'РЕКОРДИ';

  @override
  String get noRecordsYet => 'Рекордів ще немає. Пограйте!';

  @override
  String get close => 'ЗАКРИТИ';

  @override
  String get today => 'Сьогодні';

  @override
  String get yesterday => 'Вчора';

  @override
  String daysAgo(Object days) {
    return '$days днів тому';
  }

  @override
  String get veryLongAgo => 'Дуже давно';

  @override
  String get bonusesTitle => 'БОНУСИ';

  @override
  String get rescueBonusesTitle => 'БОНУСИ РЯТУВАННЯ';

  @override
  String get selectBonusToSave => 'Виберіть бонус, щоб зберегти гру';

  @override
  String get bonusSurprise => 'Сюрприз';

  @override
  String get bonusHammer => 'Молоток';

  @override
  String get bonusNewBlocks => 'Нові блоки';

  @override
  String get bonusHint => 'Підказка';

  @override
  String useBonus(int count) {
    return 'ВИКОРИСТАТИ ($count)';
  }

  @override
  String get adButton => 'РЕКЛАМА';

  @override
  String get limitLabel => 'ЛІМІТ';

  @override
  String get adUnavailableBonus => 'Реклама недоступна. Ось ваш бонус!';

  @override
  String get noMovesFound => 'Хідів не знайдено! Використайте інший бонус.';

  @override
  String get perfectClear => 'ІДЕАЛЬНЕ ПРОХОДЖЕННЯ!';

  @override
  String missLabel(int amount) {
    return 'ПРОМАХ +$amount';
  }

  @override
  String get crossMultiplier => 'КРОС x10!';

  @override
  String comboMultiplier(int level) {
    return 'КОМБО x$level!';
  }

  @override
  String get languageTitle => 'Мова';

  @override
  String get infoTitle => 'Інформація';

  @override
  String get howToPlay => 'Як грати';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get termsOfService => 'Умови надання послуг';

  @override
  String get licenses => 'Ліцензії';

  @override
  String get aboutGame => 'Про гру';

  @override
  String get takeABreak => 'Time to relax during a short ad! ☕️';
}
