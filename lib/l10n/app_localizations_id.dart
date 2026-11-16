// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'SKOR';

  @override
  String get gameOverTitle => 'Permainan yang Seru!';

  @override
  String get gameOverBody => 'Tidak ada ruang lagi untuk balok baru.';

  @override
  String yourScore(Object score) {
    return 'Skor Anda: $score';
  }

  @override
  String get playAgain => 'Main Lagi';

  @override
  String get classicMode => 'MODUS KLASIK';

  @override
  String get classicModeSub =>
      'Teka-teki balok tanpa akhir. Kalahkan skor Anda sendiri.';

  @override
  String get treasureMode => 'PERBURUAN HARTA KARUN';

  @override
  String get treasureModeSub => 'Kumpulkan kristal langka.';

  @override
  String get playFreeOffline => 'Mainkan secara gratis tanpa koneksi internet';

  @override
  String get comingSoon => 'Segera Hadir!';

  @override
  String get moreGames => 'Game Lainnya';

  @override
  String get myGamesTitle => 'Game Saya';

  @override
  String get playNow => 'Main Sekarang';

  @override
  String get sound => 'Suara';

  @override
  String get continueGame => 'LANJUTKAN';

  @override
  String get newGame => 'PERMAINAN BARU';

  @override
  String get saveAndExit => 'SIMPAN & KELUAR';

  @override
  String get exitWithoutSaving => 'KELUAR TANPA MENYIMPAN';

  @override
  String get pauseTitle => 'DIJEDA';

  @override
  String get resume => 'LANJUTKAN';

  @override
  String get restart => 'MULAI ULANG';

  @override
  String get soundOn => 'SUARA: AKTIF';

  @override
  String get soundOff => 'SUARA: NONAKTIF';

  @override
  String get vibrationOn => 'GETARAN: AKTIF';

  @override
  String get vibrationOff => 'GETARAN: MATI';

  @override
  String get nothingToUndo => 'Belum ada yang bisa dibatalkan!';

  @override
  String get outOfUndos => 'Tidak ada lagi opsi pembatalan!';

  @override
  String get adUnavailableUndo =>
      'Iklan tidak tersedia. Ini opsi pembatalanmu!';

  @override
  String get outOfMovesTitle => 'Tidak ada langkah lagi!';

  @override
  String get outOfMovesBody =>
      'Kami telah menyiapkan bonus penyelamat untuk Anda. Gunakan bonus tersebut untuk melanjutkan.';

  @override
  String get openBonuses => 'BUKA BONUS';

  @override
  String get endSession => 'AKHIRI SESI';

  @override
  String get sessionEnded => 'Sesi Anda telah berakhir.';

  @override
  String get startNewGame => 'MULAI PERMAINAN BARU';

  @override
  String get outOfSpace => 'GAME OVER';

  @override
  String get hexGameTitle => 'Hex Tic Tac Toe: Seru & Strategis';

  @override
  String get hexGameDesc =>
      'Hex Tic Tac Toe. Mainkan secara offline melawan Bot atau teman. Analisis permainan. Turnamen.';

  @override
  String get tttGameTitle => 'Tic Tac Toe: Seru & Strategi';

  @override
  String get tttGameDesc =>
      'Melawan Bot atau teman, analisis mendalam, gameplay adaptif. Tic Tac Toe — tapi taktis.';

  @override
  String get comingSoonTitle => 'Segera Hadir';

  @override
  String get comingSoonDesc => 'Nantikan teka-teki kami berikutnya!';

  @override
  String get resumeYourGame => 'Lanjutkan permainanmu';

  @override
  String get startFresh => 'Mulai dari awal';

  @override
  String get topScores => 'SKOR TERATAS';

  @override
  String get noRecordsYet => 'Belum ada rekor. Mainkan permainannya!';

  @override
  String get close => 'TUTUP';

  @override
  String get today => 'Hari ini';

  @override
  String get yesterday => 'Kemarin';

  @override
  String daysAgo(Object days) {
    return '$days hari yang lalu';
  }

  @override
  String get veryLongAgo => 'Sudah sangat lama';

  @override
  String get bonusesTitle => 'BONUS';

  @override
  String get rescueBonusesTitle => 'BONUS PENYELAMATAN';

  @override
  String get selectBonusToSave => 'Pilih bonus untuk menyimpan permainanmu';

  @override
  String get bonusSurprise => 'Kejutan';

  @override
  String get bonusHammer => 'Palu';

  @override
  String get bonusNewBlocks => 'Blok Baru';

  @override
  String get bonusHint => 'Petunjuk';

  @override
  String useBonus(int count) {
    return 'GUNAKAN ($count)';
  }

  @override
  String get adButton => 'IKLAN';

  @override
  String get limitLabel => 'BATAS';

  @override
  String get adUnavailableBonus => 'Iklan tidak tersedia. Ini bonusmu!';

  @override
  String get noMovesFound => 'Tidak ditemukan langkah! Gunakan bonus lain.';

  @override
  String get perfectClear => 'SELESAI SEMPURNA!';

  @override
  String missLabel(int amount) {
    return 'GAGAL +$amount';
  }

  @override
  String get crossMultiplier => 'CROSS x10!';

  @override
  String comboMultiplier(int level) {
    return 'COMBO x$level!';
  }

  @override
  String get languageTitle => 'Bahasa';

  @override
  String get infoTitle => 'Informasi';

  @override
  String get howToPlay => 'Cara Bermain';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get termsOfService => 'Ketentuan Layanan';

  @override
  String get licenses => 'Lisensi';

  @override
  String get aboutGame => 'Tentang Game';
}
