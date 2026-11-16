// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'PUNKTESTAND';

  @override
  String get gameOverTitle => 'Tolles Spiel!';

  @override
  String get gameOverBody => 'Es ist kein Platz mehr für neue Blöcke.';

  @override
  String yourScore(Object score) {
    return 'Dein Punktestand: $score';
  }

  @override
  String get playAgain => 'Noch einmal spielen';

  @override
  String get classicMode => 'KLASSISCHER MODUS';

  @override
  String get classicModeSub =>
      'Endloses Block-Puzzle. Übertriff deine Punktzahl.';

  @override
  String get treasureMode => 'SCHATZSUCHE';

  @override
  String get treasureModeSub => 'Sammle seltene Kristalle.';

  @override
  String get playFreeOffline => 'Kostenlos offline spielen';

  @override
  String get comingSoon => 'Demnächst verfügbar!';

  @override
  String get moreGames => 'Weitere Spiele';

  @override
  String get myGamesTitle => 'Meine Spiele';

  @override
  String get playNow => 'Jetzt spielen';

  @override
  String get sound => 'Sound';

  @override
  String get continueGame => 'WEITERSPIELEN';

  @override
  String get newGame => 'NEUES SPIEL';

  @override
  String get saveAndExit => 'SPEICHERN & BEENDEN';

  @override
  String get exitWithoutSaving => 'BEENDEN OHNE ZU SPEICHERN';

  @override
  String get pauseTitle => 'PAUSE';

  @override
  String get resume => 'WEITERSPIELEN';

  @override
  String get restart => 'NEUSTART';

  @override
  String get soundOn => 'TON: EIN';

  @override
  String get soundOff => 'TON: AUS';

  @override
  String get vibrationOn => 'VIBRATION: EIN';

  @override
  String get vibrationOff => 'VIBRATION: AUS';

  @override
  String get nothingToUndo => 'Noch nichts rückgängig zu machen!';

  @override
  String get outOfUndos => 'Keine Rückgängig-Möglichkeiten mehr!';

  @override
  String get adUnavailableUndo =>
      'Anzeige nicht verfügbar. Hier ist deine Rückgängig-Möglichkeit!';

  @override
  String get outOfMovesTitle => 'Keine Züge mehr!';

  @override
  String get outOfMovesBody =>
      'Wir haben einen Rettungsbonus für dich vorbereitet. Nutze einen Bonus, um weiterzuspielen.';

  @override
  String get openBonuses => 'BONUSSE ÖFFNEN';

  @override
  String get endSession => 'SITZUNG BEENDEN';

  @override
  String get sessionEnded => 'Deine Sitzung ist beendet.';

  @override
  String get startNewGame => 'NEUES SPIEL STARTEN';

  @override
  String get outOfSpace => 'SPIEL VORBEI';

  @override
  String get hexGameTitle => 'Hex Tic Tac Toe – Spaß & Strategie';

  @override
  String get hexGameDesc =>
      'Hex Tic Tac Toe. Offline gegen den Bot oder einen Freund spielen. Spielanalyse. Turniere.';

  @override
  String get tttGameTitle => 'Tic Tac Toe: Spaß & Strategie';

  @override
  String get tttGameDesc =>
      'Gegen den Bot oder einen Freund, tiefgehende Analyse, anpassungsfähiges Gameplay. Tic Tac Toe – aber taktisch.';

  @override
  String get comingSoonTitle => 'Demnächst';

  @override
  String get comingSoonDesc => 'Seid gespannt auf unser nächstes Rätselspiel!';

  @override
  String get resumeYourGame => 'Spiel fortsetzen';

  @override
  String get startFresh => 'Neu starten';

  @override
  String get topScores => 'TOP-ERGEBNISSE';

  @override
  String get noRecordsYet => 'Noch keine Rekorde. Spiel eine Partie!';

  @override
  String get close => 'SCHLIESSEN';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String daysAgo(Object days) {
    return 'vor $days Tagen';
  }

  @override
  String get veryLongAgo => 'Vor sehr langer Zeit';

  @override
  String get bonusesTitle => 'BONUSSE';

  @override
  String get rescueBonusesTitle => 'RETTUNGSBONUSSE';

  @override
  String get selectBonusToSave =>
      'Wähle einen Bonus aus, um dein Spiel zu speichern';

  @override
  String get bonusSurprise => 'Überraschung';

  @override
  String get bonusHammer => 'Hammer';

  @override
  String get bonusNewBlocks => 'Neue Blöcke';

  @override
  String get bonusHint => 'Hinweis';

  @override
  String useBonus(int count) {
    return '($count) EINSETZEN';
  }

  @override
  String get adButton => 'WERBUNG';

  @override
  String get limitLabel => 'LIMIT';

  @override
  String get adUnavailableBonus =>
      'Werbung nicht verfügbar. Hier ist dein Bonus!';

  @override
  String get noMovesFound =>
      'Keine Züge gefunden! Verwende einen anderen Bonus.';

  @override
  String get perfectClear => 'PERFEKT GELÖST!';

  @override
  String missLabel(int amount) {
    return 'FEHLER +$amount';
  }

  @override
  String get crossMultiplier => 'KREUZ x10!';

  @override
  String comboMultiplier(int level) {
    return 'KOMBO x$level!';
  }

  @override
  String get languageTitle => 'Sprache';

  @override
  String get infoTitle => 'Informationen';

  @override
  String get howToPlay => 'Spielanleitung';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get licenses => 'Lizenzen';

  @override
  String get aboutGame => 'Über das Spiel';
}
