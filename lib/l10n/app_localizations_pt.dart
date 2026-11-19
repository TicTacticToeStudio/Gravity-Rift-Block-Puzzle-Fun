// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'PONTUAÇÃO';

  @override
  String get gameOverTitle => 'Excelente jogo!';

  @override
  String get gameOverBody => 'Não há mais espaço para novos blocos.';

  @override
  String yourScore(Object score) {
    return 'A tua pontuação: $score';
  }

  @override
  String get playAgain => 'Jogar de novo';

  @override
  String get classicMode => 'MODO CLÁSSICO';

  @override
  String get classicModeSub =>
      'Quebra-cabeças de blocos sem fim. Bate a tua pontuação.';

  @override
  String get treasureMode => 'CAÇA AO TESOURO';

  @override
  String get treasureModeSub => 'Recolhe cristais raros.';

  @override
  String get playFreeOffline => 'Jogar offline gratuitamente';

  @override
  String get comingSoon => 'Em breve!';

  @override
  String get moreGames => 'Mais jogos';

  @override
  String get myGamesTitle => 'Os meus jogos';

  @override
  String get playNow => 'Jogar agora';

  @override
  String get sound => 'Som';

  @override
  String get continueGame => 'CONTINUAR';

  @override
  String get newGame => 'NOVO JOGO';

  @override
  String get saveAndExit => 'GUARDAR E SAIR';

  @override
  String get exitWithoutSaving => 'SAIR SEM GUARDAR';

  @override
  String get pauseTitle => 'EM PAUSA';

  @override
  String get resume => 'RETOMAR';

  @override
  String get restart => 'REINICIAR';

  @override
  String get soundOn => 'SOM: LIGADO';

  @override
  String get soundOff => 'SOM: DESLIGADO';

  @override
  String get vibrationOn => 'VIBRAÇÃO: LIGADA';

  @override
  String get vibrationOff => 'VIBRAÇÃO: DESLIGADO';

  @override
  String get nothingToUndo => 'Ainda não há nada para desfazer!';

  @override
  String get outOfUndos => 'Sem opções de desfazer!';

  @override
  String get adUnavailableUndo =>
      'Anúncio indisponível. Aqui está a tua opção de desfazer!';

  @override
  String get outOfMovesTitle => 'Sem jogadas!';

  @override
  String get outOfMovesBody =>
      'Preparámos um bónus de resgate para ti. Usa um bónus para continuar.';

  @override
  String get openBonuses => 'ABRIR BÓNUS';

  @override
  String get endSession => 'TERMINAR SESSÃO';

  @override
  String get sessionEnded => 'A tua sessão terminou.';

  @override
  String get startNewGame => 'INICIAR NOVO JOGO';

  @override
  String get outOfSpace => 'FIM DO JOGO';

  @override
  String get hexGameTitle => 'Jogo da Velha Hexagonal: Diversão e Estratégia';

  @override
  String get hexGameDesc =>
      'Jogo da Velha Hexagonal. Joga offline contra um bot ou um amigo. Análise do jogo. Torneios.';

  @override
  String get tttGameTitle => 'Jogo da Velha: Diversão e Estratégia';

  @override
  String get tttGameDesc =>
      'Bot ou amigo, análise aprofundada, jogabilidade adaptativa. Jogo da Velha — mas tático.';

  @override
  String get comingSoonTitle => 'Em breve';

  @override
  String get comingSoonDesc => 'Fique atento ao nosso próximo quebra-cabeças!';

  @override
  String get resumeYourGame => 'Retomar o jogo';

  @override
  String get startFresh => 'Começar do zero';

  @override
  String get topScores => 'MELHORES RESULTADOS';

  @override
  String get noRecordsYet => 'Ainda não há registos. Joga uma partida!';

  @override
  String get close => 'FECHAR';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String daysAgo(Object days) {
    return '$days dias atrás';
  }

  @override
  String get veryLongAgo => 'Há muito tempo';

  @override
  String get bonusesTitle => 'BÓNUS';

  @override
  String get rescueBonusesTitle => 'BÓNUS DE RESGATE';

  @override
  String get selectBonusToSave =>
      'Seleciona um bónus para guardares o teu jogo';

  @override
  String get bonusSurprise => 'Surpresa';

  @override
  String get bonusHammer => 'Martelo';

  @override
  String get bonusNewBlocks => 'Novos blocos';

  @override
  String get bonusHint => 'Dica';

  @override
  String useBonus(int count) {
    return 'USAR ($count)';
  }

  @override
  String get adButton => 'ANÚNCIO';

  @override
  String get limitLabel => 'LIMITE';

  @override
  String get adUnavailableBonus =>
      'Anúncio indisponível. Aqui está o teu bónus!';

  @override
  String get noMovesFound => 'Não foram encontradas jogadas! Usa outro bónus.';

  @override
  String get perfectClear => 'JOGO PERFEITO!';

  @override
  String missLabel(int amount) {
    return 'ERRO +$amount';
  }

  @override
  String get crossMultiplier => 'CRUZ x10!';

  @override
  String comboMultiplier(int level) {
    return 'COMBO x$level!';
  }

  @override
  String get languageTitle => 'Idioma';

  @override
  String get infoTitle => 'Informações';

  @override
  String get howToPlay => 'Como jogar';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get licenses => 'Licenças';

  @override
  String get aboutGame => 'Sobre o jogo';

  @override
  String get takeABreak => 'Time to relax during a short ad! ☕️';
}
