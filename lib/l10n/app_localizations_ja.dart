// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'スコア';

  @override
  String get gameOverTitle => '素晴らしいゲームでした！';

  @override
  String get gameOverBody => '新しいブロックを置くスペースがなくなりました。';

  @override
  String yourScore(Object score) {
    return 'あなたのスコア: $score';
  }

  @override
  String get playAgain => 'もう一度プレイ';

  @override
  String get classicMode => 'クラシックモード';

  @override
  String get classicModeSub => 'エンドレスなブロックパズル。自分の最高得点を更新しよう。';

  @override
  String get treasureMode => 'トレジャーハント';

  @override
  String get treasureModeSub => 'レアなクリスタルを集めよう。';

  @override
  String get playFreeOffline => 'オフラインで無料でプレイ';

  @override
  String get comingSoon => '近日公開！';

  @override
  String get moreGames => 'その他のゲーム';

  @override
  String get myGamesTitle => 'マイゲーム';

  @override
  String get playNow => '今すぐプレイ';

  @override
  String get sound => 'サウンド';

  @override
  String get continueGame => '続きからプレイ';

  @override
  String get newGame => '新規ゲーム';

  @override
  String get saveAndExit => 'セーブして終了';

  @override
  String get exitWithoutSaving => 'セーブせずに終了';

  @override
  String get pauseTitle => '一時停止';

  @override
  String get resume => '再開';

  @override
  String get restart => '再スタート';

  @override
  String get soundOn => 'サウンド：オン';

  @override
  String get soundOff => 'サウンド：オフ';

  @override
  String get vibrationOn => 'バイブレーション：オン';

  @override
  String get vibrationOff => 'バイブレーション：オフ';

  @override
  String get nothingToUndo => 'まだ元に戻す操作はありません！';

  @override
  String get outOfUndos => '元に戻す操作が尽きました！';

  @override
  String get adUnavailableUndo => '広告が利用できません。代わりに、元に戻す操作をご利用ください！';

  @override
  String get outOfMovesTitle => '手番が尽きました！';

  @override
  String get outOfMovesBody => '救済ボーナスを用意しました。ボーナスを使ってゲームを続行してください。';

  @override
  String get openBonuses => 'ボーナスを開く';

  @override
  String get endSession => 'セッションを終了';

  @override
  String get sessionEnded => 'セッションが終了しました。';

  @override
  String get startNewGame => '新しいゲームを開始';

  @override
  String get outOfSpace => 'ゲームオーバー';

  @override
  String get hexGameTitle => 'ヘックス三目並べ：楽しさと戦略';

  @override
  String get hexGameDesc => 'ヘックス三目並べ。オフラインでボットや友達と対戦。ゲーム分析。トーナメント。';

  @override
  String get tttGameTitle => '三目並べ：楽しさと戦略';

  @override
  String get tttGameDesc => 'ボットや友達との対戦、詳細な分析、状況に応じたゲームプレイ。三目並べ――しかし戦術的。';

  @override
  String get comingSoonTitle => '近日公開';

  @override
  String get comingSoonDesc => '次のパズルにご期待ください！';

  @override
  String get resumeYourGame => 'ゲームを再開';

  @override
  String get startFresh => '新規開始';

  @override
  String get topScores => 'ハイスコア';

  @override
  String get noRecordsYet => 'まだ記録はありません。ゲームをプレイしましょう！';

  @override
  String get close => '閉じる';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String daysAgo(Object days) {
    return '$days日前';
  }

  @override
  String get veryLongAgo => 'ずいぶん昔';

  @override
  String get bonusesTitle => 'ボーナス';

  @override
  String get rescueBonusesTitle => 'レスキューボーナス';

  @override
  String get selectBonusToSave => 'ゲームをセーブするためのボーナスを選択してください';

  @override
  String get bonusSurprise => 'サプライズ';

  @override
  String get bonusHammer => 'ハンマー';

  @override
  String get bonusNewBlocks => '新しいブロック';

  @override
  String get bonusHint => 'ヒント';

  @override
  String useBonus(int count) {
    return '($count)を使用';
  }

  @override
  String get adButton => '広告';

  @override
  String get limitLabel => '制限';

  @override
  String get adUnavailableBonus => '広告は利用できません。こちらがボーナスです！';

  @override
  String get noMovesFound => '次の手が見つかりません！別のボーナスを使ってください。';

  @override
  String get perfectClear => 'パーフェクトクリア！';

  @override
  String missLabel(int amount) {
    return 'ミス +$amount';
  }

  @override
  String get crossMultiplier => 'クロス x10！';

  @override
  String comboMultiplier(int level) {
    return 'コンボ x$level！';
  }

  @override
  String get languageTitle => '言語';

  @override
  String get infoTitle => '情報';

  @override
  String get howToPlay => '遊び方';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get licenses => 'ライセンス';

  @override
  String get aboutGame => 'ゲームについて';

  @override
  String get takeABreak => 'Time to relax during a short ad! ☕️';
}
