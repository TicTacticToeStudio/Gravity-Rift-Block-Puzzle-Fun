// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => '得分';

  @override
  String get gameOverTitle => '玩得真棒！';

  @override
  String get gameOverBody => '没有空间放置新方块了。';

  @override
  String yourScore(Object score) {
    return '您的得分：$score';
  }

  @override
  String get playAgain => '再次游玩';

  @override
  String get classicMode => '经典模式';

  @override
  String get classicModeSub => '无尽方块解谜。挑战自己的最高分。';

  @override
  String get treasureMode => '寻宝模式';

  @override
  String get treasureModeSub => '收集稀有水晶。';

  @override
  String get playFreeOffline => '免费离线游玩';

  @override
  String get comingSoon => '即将上线！';

  @override
  String get moreGames => '更多游戏';

  @override
  String get myGamesTitle => '我的游戏';

  @override
  String get playNow => '立即游玩';

  @override
  String get sound => '声音';

  @override
  String get continueGame => '继续游戏';

  @override
  String get newGame => '新游戏';

  @override
  String get saveAndExit => '保存并退出';

  @override
  String get exitWithoutSaving => '不保存直接退出';

  @override
  String get pauseTitle => '暂停';

  @override
  String get resume => '继续';

  @override
  String get restart => '重新开始';

  @override
  String get soundOn => '声音：开';

  @override
  String get soundOff => '声音：关';

  @override
  String get vibrationOn => '振动：开';

  @override
  String get vibrationOff => '振动：关闭';

  @override
  String get nothingToUndo => '暂无可撤销的操作！';

  @override
  String get outOfUndos => '撤销次数用尽！';

  @override
  String get adUnavailableUndo => '广告不可用。请使用您的撤销机会！';

  @override
  String get outOfMovesTitle => '步数用尽！';

  @override
  String get outOfMovesBody => '我们为您准备了救援奖励。使用奖励继续游戏。';

  @override
  String get openBonuses => '打开奖励';

  @override
  String get endSession => '结束本局';

  @override
  String get sessionEnded => '您的本局已结束。';

  @override
  String get startNewGame => '开始新游戏';

  @override
  String get outOfSpace => '游戏结束';

  @override
  String get hexGameTitle => '六边形井字棋：趣味与策略';

  @override
  String get hexGameDesc => '六边形井字棋。离线对战机器人或好友。游戏分析。锦标赛。';

  @override
  String get tttGameTitle => '井字棋：趣味与策略';

  @override
  String get tttGameDesc => '对战机器人或好友，深度分析，自适应玩法。井字棋——但更具战术性。';

  @override
  String get comingSoonTitle => '即将上线';

  @override
  String get comingSoonDesc => '敬请期待我们的下一款益智游戏！';

  @override
  String get resumeYourGame => '继续游戏';

  @override
  String get startFresh => '重新开始';

  @override
  String get topScores => '最高分榜';

  @override
  String get noRecordsYet => '暂无记录。快来玩一局吧！';

  @override
  String get close => '关闭';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String daysAgo(Object days) {
    return '$days 天前';
  }

  @override
  String get veryLongAgo => '很久以前';

  @override
  String get bonusesTitle => '奖励';

  @override
  String get rescueBonusesTitle => '救援奖励';

  @override
  String get selectBonusToSave => '选择一个奖励来保存游戏进度';

  @override
  String get bonusSurprise => '惊喜';

  @override
  String get bonusHammer => '锤子';

  @override
  String get bonusNewBlocks => '新方块';

  @override
  String get bonusHint => '提示';

  @override
  String useBonus(int count) {
    return '使用 ($count)';
  }

  @override
  String get adButton => '广告';

  @override
  String get limitLabel => '限制';

  @override
  String get adUnavailableBonus => '广告不可用。这是你的奖励！';

  @override
  String get noMovesFound => '未找到可操作步数！请使用其他奖励。';

  @override
  String get perfectClear => '完美通关！';

  @override
  String missLabel(int amount) {
    return '失误 +$amount';
  }

  @override
  String get crossMultiplier => '连线 x10！';

  @override
  String comboMultiplier(int level) {
    return '连击 x$level！';
  }

  @override
  String get languageTitle => '语言';

  @override
  String get infoTitle => '信息';

  @override
  String get howToPlay => '游戏玩法';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get licenses => '许可协议';

  @override
  String get aboutGame => '关于游戏';
}
