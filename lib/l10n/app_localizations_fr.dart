// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'SCORE';

  @override
  String get gameOverTitle => 'Super partie !';

  @override
  String get gameOverBody => 'Il n\'y a plus de place pour de nouveaux blocs.';

  @override
  String yourScore(Object score) {
    return 'Votre score : $score';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get classicMode => 'MODE CLASSIQUE';

  @override
  String get classicModeSub => 'Puzzle de blocs sans fin. Battez votre record.';

  @override
  String get treasureMode => 'CHASSE AU TRÉSOR';

  @override
  String get treasureModeSub => 'Récupérez des cristaux rares.';

  @override
  String get playFreeOffline => 'Jouer gratuitement hors ligne';

  @override
  String get comingSoon => 'Bientôt disponible !';

  @override
  String get moreGames => 'Plus de jeux';

  @override
  String get myGamesTitle => 'Mes jeux';

  @override
  String get playNow => 'Jouer maintenant';

  @override
  String get sound => 'Son';

  @override
  String get continueGame => 'CONTINUER';

  @override
  String get newGame => 'NOUVELLE PARTIE';

  @override
  String get saveAndExit => 'ENREGISTRER ET QUITTER';

  @override
  String get exitWithoutSaving => 'QUITTER SANS ENREGISTRER';

  @override
  String get pauseTitle => 'EN PAUSE';

  @override
  String get resume => 'REPRENDRE';

  @override
  String get restart => 'REDÉMARRER';

  @override
  String get soundOn => 'SON : ACTIVÉ';

  @override
  String get soundOff => 'SON : DÉSACTIVÉ';

  @override
  String get vibrationOn => 'VIBRATION : ACTIVÉE';

  @override
  String get vibrationOff => 'VIBRATION : DÉSACTIVÉE';

  @override
  String get nothingToUndo => 'Rien à annuler pour l\'instant !';

  @override
  String get outOfUndos => 'Plus d\'annulations disponibles !';

  @override
  String get adUnavailableUndo =>
      'Publicité indisponible. Voici votre annulation !';

  @override
  String get outOfMovesTitle => 'Plus de coups !';

  @override
  String get outOfMovesBody =>
      'Nous vous avons préparé un bonus de secours. Utilisez un bonus pour continuer.';

  @override
  String get openBonuses => 'OUVRIR LES BONUS';

  @override
  String get endSession => 'TERMINER LA SESSION';

  @override
  String get sessionEnded => 'Votre session est terminée.';

  @override
  String get startNewGame => 'COMMENCER UNE NOUVELLE PARTIE';

  @override
  String get outOfSpace => 'FIN DE PARTIE';

  @override
  String get hexGameTitle => 'Tic-tac-toe hexagonal : amusement et stratégie';

  @override
  String get hexGameDesc =>
      'Tic-tac-toe hexagonal. Jouez hors ligne contre un bot ou un ami. Analyse de partie. Tournois.';

  @override
  String get tttGameTitle => 'Tic-tac-toe : Fun & Strategy';

  @override
  String get tttGameDesc =>
      'Contre un bot ou un ami, analyse approfondie, gameplay adaptatif. Tic-tac-toe — mais tactique.';

  @override
  String get comingSoonTitle => 'Bientôt disponible';

  @override
  String get comingSoonDesc =>
      'Restez à l\'écoute pour notre prochain casse-tête !';

  @override
  String get resumeYourGame => 'Reprendre votre partie';

  @override
  String get startFresh => 'Commencer une nouvelle partie';

  @override
  String get topScores => 'MEILLEURS SCORES';

  @override
  String get noRecordsYet => 'Aucun record pour l\'instant. Jouez une partie !';

  @override
  String get close => 'FERMER';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get yesterday => 'Hier';

  @override
  String daysAgo(Object days) {
    return 'Il y a $days jours';
  }

  @override
  String get veryLongAgo => 'Il y a très longtemps';

  @override
  String get bonusesTitle => 'BONUS';

  @override
  String get rescueBonusesTitle => 'BONUS DE SAUVETAGE';

  @override
  String get selectBonusToSave =>
      'Sélectionnez un bonus pour sauvegarder votre partie';

  @override
  String get bonusSurprise => 'Surprise';

  @override
  String get bonusHammer => 'Marteau';

  @override
  String get bonusNewBlocks => 'Nouveaux blocs';

  @override
  String get bonusHint => 'Indice';

  @override
  String useBonus(int count) {
    return 'UTILISER ($count)';
  }

  @override
  String get adButton => 'PUBLICITÉ';

  @override
  String get limitLabel => 'LIMITE';

  @override
  String get adUnavailableBonus =>
      'Publicité indisponible. Voici votre bonus !';

  @override
  String get noMovesFound => 'Aucun coup trouvé ! Utilisez un autre bonus.';

  @override
  String get perfectClear => 'PARFAITEMENT TERMINÉ !';

  @override
  String missLabel(int amount) {
    return 'ÉCHEC +$amount';
  }

  @override
  String get crossMultiplier => 'CROSS x10 !';

  @override
  String comboMultiplier(int level) {
    return 'COMBO x$level !';
  }

  @override
  String get languageTitle => 'Langue';

  @override
  String get infoTitle => 'Informations';

  @override
  String get howToPlay => 'Comment jouer';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get licenses => 'Licences';

  @override
  String get aboutGame => 'À propos du jeu';

  @override
  String get takeABreak => 'Time to relax during a short ad! ☕️';
}
