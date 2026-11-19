// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => '점수';

  @override
  String get gameOverTitle => '멋진 게임이었습니다!';

  @override
  String get gameOverBody => '새로운 블록을 놓을 공간이 더 이상 없습니다.';

  @override
  String yourScore(Object score) {
    return '당신의 점수: $score';
  }

  @override
  String get playAgain => '다시 플레이';

  @override
  String get classicMode => '클래식 모드';

  @override
  String get classicModeSub => '끝없는 블록 퍼즐. 자신의 최고 점수를 갱신해 보세요.';

  @override
  String get treasureMode => '보물 찾기';

  @override
  String get treasureModeSub => '희귀한 크리스탈을 모으세요.';

  @override
  String get playFreeOffline => '오프라인에서 무료로 플레이';

  @override
  String get comingSoon => '곧 출시됩니다!';

  @override
  String get moreGames => '더 많은 게임';

  @override
  String get myGamesTitle => '내 게임';

  @override
  String get playNow => '지금 플레이';

  @override
  String get sound => '사운드';

  @override
  String get continueGame => '계속하기';

  @override
  String get newGame => '새로운 게임';

  @override
  String get saveAndExit => '저장 후 종료';

  @override
  String get exitWithoutSaving => '저장하지 않고 종료';

  @override
  String get pauseTitle => '일시 정지';

  @override
  String get resume => '계속';

  @override
  String get restart => '다시 시작';

  @override
  String get soundOn => '사운드: 켜짐';

  @override
  String get soundOff => '사운드: 꺼짐';

  @override
  String get vibrationOn => '진동: 켜짐';

  @override
  String get vibrationOff => '진동: 꺼짐';

  @override
  String get nothingToUndo => '아직 되돌릴 작업이 없습니다!';

  @override
  String get outOfUndos => '되돌릴 수 있는 횟수가 다 되었습니다!';

  @override
  String get adUnavailableUndo => '광고가 없습니다. 대신 이 되돌리기 기능을 사용하세요!';

  @override
  String get outOfMovesTitle => '이동 횟수가 다 되었습니다!';

  @override
  String get outOfMovesBody => '구출 보너스를 준비해 두었습니다. 보너스를 사용하여 게임을 계속하세요.';

  @override
  String get openBonuses => '보너스 열기';

  @override
  String get endSession => '세션 종료';

  @override
  String get sessionEnded => '세션이 종료되었습니다.';

  @override
  String get startNewGame => '새로운 게임 시작';

  @override
  String get outOfSpace => '게임 오버';

  @override
  String get hexGameTitle => '헥스 틱택토: 재미와 전략';

  @override
  String get hexGameDesc => '헥스 틱택토. 오프라인에서 봇이나 친구와 대결하세요. 게임 분석. 토너먼트.';

  @override
  String get tttGameTitle => '틱택토: 재미와 전략';

  @override
  String get tttGameDesc => '봇이나 친구와 대결, 심층 분석, 적응형 게임플레이. 틱택토 — 하지만 전술적입니다.';

  @override
  String get comingSoonTitle => '출시 예정';

  @override
  String get comingSoonDesc => '다음 퍼즐을 기대해 주세요!';

  @override
  String get resumeYourGame => '게임 재개';

  @override
  String get startFresh => '새 게임 시작';

  @override
  String get topScores => '최고 점수';

  @override
  String get noRecordsYet => '아직 기록이 없습니다. 게임을 시작해 보세요!';

  @override
  String get close => '닫기';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String daysAgo(Object days) {
    return '$days 일 전';
  }

  @override
  String get veryLongAgo => '아주 오래전';

  @override
  String get bonusesTitle => '보너스';

  @override
  String get rescueBonusesTitle => '구조 보너스';

  @override
  String get selectBonusToSave => '게임을 저장할 보너스를 선택하세요';

  @override
  String get bonusSurprise => '서프라이즈';

  @override
  String get bonusHammer => '망치';

  @override
  String get bonusNewBlocks => '새로운 블록';

  @override
  String get bonusHint => '힌트';

  @override
  String useBonus(int count) {
    return '($count) 사용';
  }

  @override
  String get adButton => '광고';

  @override
  String get limitLabel => '한도';

  @override
  String get adUnavailableBonus => '광고를 이용할 수 없습니다. 보너스를 드립니다!';

  @override
  String get noMovesFound => '이동할 수 있는 방법이 없습니다! 다른 보너스를 사용하세요.';

  @override
  String get perfectClear => '완벽 클리어!';

  @override
  String missLabel(int amount) {
    return '실패 +$amount';
  }

  @override
  String get crossMultiplier => '크로스 x10!';

  @override
  String comboMultiplier(int level) {
    return '콤보 x$level!';
  }

  @override
  String get languageTitle => '언어';

  @override
  String get infoTitle => '정보';

  @override
  String get howToPlay => '게임 방법';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get termsOfService => '이용약관';

  @override
  String get licenses => '라이선스';

  @override
  String get aboutGame => '게임 소개';

  @override
  String get takeABreak => 'Time to relax during a short ad! ☕️';
}
