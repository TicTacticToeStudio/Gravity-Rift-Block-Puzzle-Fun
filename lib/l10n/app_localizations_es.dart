// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'PUNTUACIÓN';

  @override
  String get gameOverTitle => '¡Gran partida!';

  @override
  String get gameOverBody => 'No queda espacio para nuevos bloques.';

  @override
  String yourScore(Object score) {
    return 'Tu puntuación: $score';
  }

  @override
  String get playAgain => 'Jugar de nuevo';

  @override
  String get classicMode => 'MODO CLÁSICO';

  @override
  String get classicModeSub =>
      'Rompecabezas de bloques sin fin. Supera tu puntuación.';

  @override
  String get treasureMode => 'BÚSQUEDA DEL TESORO';

  @override
  String get treasureModeSub => 'Recoge cristales raros.';

  @override
  String get playFreeOffline => 'Jugar gratis sin conexión';

  @override
  String get comingSoon => '¡Próximamente!';

  @override
  String get moreGames => 'Más juegos';

  @override
  String get myGamesTitle => 'Mis juegos';

  @override
  String get playNow => 'Jugar ahora';

  @override
  String get sound => 'Sonido';

  @override
  String get continueGame => 'CONTINUAR';

  @override
  String get newGame => 'NUEVA PARTIDA';

  @override
  String get saveAndExit => 'GUARDAR Y SALIR';

  @override
  String get exitWithoutSaving => 'SALIR SIN GUARDAR';

  @override
  String get pauseTitle => 'EN PAUSA';

  @override
  String get resume => 'REANUDAR';

  @override
  String get restart => 'REINICIAR';

  @override
  String get soundOn => 'SONIDO: ACTIVADO';

  @override
  String get soundOff => 'SONIDO: DESACTIVADO';

  @override
  String get vibrationOn => 'VIBRACIÓN: ACTIVADA';

  @override
  String get vibrationOff => 'VIBRACIÓN: DESACTIVADA';

  @override
  String get nothingToUndo => '¡Aún no hay nada que deshacer!';

  @override
  String get outOfUndos => '¡No hay más acciones que deshacer!';

  @override
  String get adUnavailableUndo =>
      'Anuncio no disponible. ¡Aquí tienes tu acción de deshacer!';

  @override
  String get outOfMovesTitle => '¡No hay más jugadas!';

  @override
  String get outOfMovesBody =>
      'Te hemos preparado una bonificación de rescate. Usa una bonificación para continuar.';

  @override
  String get openBonuses => 'ABRIR BONIFICACIONES';

  @override
  String get endSession => 'FINALIZAR SESIÓN';

  @override
  String get sessionEnded => 'Tu sesión ha finalizado.';

  @override
  String get startNewGame => 'EMPEZAR NUEVA PARTIDA';

  @override
  String get outOfSpace => 'FIN DE LA PARTIDA';

  @override
  String get hexGameTitle => 'Tic-tac-toe hexagonal: diversión y estrategia';

  @override
  String get hexGameDesc =>
      'Tic-tac-toe hexagonal. Juega sin conexión contra un bot o un amigo. Análisis de la partida. Torneos.';

  @override
  String get tttGameTitle => 'Tres en raya: diversión y estrategia';

  @override
  String get tttGameDesc =>
      'Contra el bot o un amigo, análisis en profundidad, jugabilidad adaptativa. Tres en raya, pero táctico.';

  @override
  String get comingSoonTitle => 'Próximamente';

  @override
  String get comingSoonDesc => '¡Estad atentos a nuestro próximo rompecabezas!';

  @override
  String get resumeYourGame => 'Reanuda tu partida';

  @override
  String get startFresh => 'Empezar de cero';

  @override
  String get topScores => 'MEJORES PUNTUACIONES';

  @override
  String get noRecordsYet => 'Aún no hay registros. ¡Juega una partida!';

  @override
  String get close => 'CERRAR';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String daysAgo(Object days) {
    return 'Hace $days días';
  }

  @override
  String get veryLongAgo => 'Hace mucho tiempo';

  @override
  String get bonusesTitle => 'BONIFICACIONES';

  @override
  String get rescueBonusesTitle => 'BONIFICACIONES DE RESCATE';

  @override
  String get selectBonusToSave =>
      'Selecciona una bonificación para guardar tu partida';

  @override
  String get bonusSurprise => 'Sorpresa';

  @override
  String get bonusHammer => 'Martillo';

  @override
  String get bonusNewBlocks => 'Nuevos bloques';

  @override
  String get bonusHint => 'Pista';

  @override
  String useBonus(int count) {
    return 'USAR ($count)';
  }

  @override
  String get adButton => 'ANUNCIO';

  @override
  String get limitLabel => 'LÍMITE';

  @override
  String get adUnavailableBonus =>
      'Anuncio no disponible. ¡Aquí tienes tu bonificación!';

  @override
  String get noMovesFound =>
      '¡No se han encontrado movimientos! Usa otra bonificación.';

  @override
  String get perfectClear => '¡PURGA PERFECTA!';

  @override
  String missLabel(int amount) {
    return 'FALLO +$amount';
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
  String get infoTitle => 'Información';

  @override
  String get howToPlay => 'Cómo jugar';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Condiciones de servicio';

  @override
  String get licenses => 'Licencias';

  @override
  String get aboutGame => 'Acerca del juego';

  @override
  String get takeABreak => 'Time to relax during a short ad! ☕️';
}
