import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Gravity Rift: Block Puzzle Fun'**
  String get appTitle;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'SCORE'**
  String get scoreLabel;

  /// No description provided for @gameOverTitle.
  ///
  /// In en, this message translates to:
  /// **'Great Game!'**
  String get gameOverTitle;

  /// No description provided for @gameOverBody.
  ///
  /// In en, this message translates to:
  /// **'There is no space left for new blocks.'**
  String get gameOverBody;

  /// No description provided for @yourScore.
  ///
  /// In en, this message translates to:
  /// **'Your Score: {score}'**
  String yourScore(Object score);

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @classicMode.
  ///
  /// In en, this message translates to:
  /// **'CLASSIC MODE'**
  String get classicMode;

  /// No description provided for @classicModeSub.
  ///
  /// In en, this message translates to:
  /// **'Endless block puzzle. Beat your score.'**
  String get classicModeSub;

  /// No description provided for @treasureMode.
  ///
  /// In en, this message translates to:
  /// **'TREASURE HUNT'**
  String get treasureMode;

  /// No description provided for @treasureModeSub.
  ///
  /// In en, this message translates to:
  /// **'Collect rare crystals.'**
  String get treasureModeSub;

  /// No description provided for @playFreeOffline.
  ///
  /// In en, this message translates to:
  /// **'Play free offline'**
  String get playFreeOffline;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon!'**
  String get comingSoon;

  /// No description provided for @moreGames.
  ///
  /// In en, this message translates to:
  /// **'More Games'**
  String get moreGames;

  /// No description provided for @myGamesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Games'**
  String get myGamesTitle;

  /// No description provided for @playNow.
  ///
  /// In en, this message translates to:
  /// **'Play Now'**
  String get playNow;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @continueGame.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueGame;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'NEW GAME'**
  String get newGame;

  /// No description provided for @saveAndExit.
  ///
  /// In en, this message translates to:
  /// **'SAVE & EXIT'**
  String get saveAndExit;

  /// No description provided for @exitWithoutSaving.
  ///
  /// In en, this message translates to:
  /// **'EXIT WITHOUT SAVING'**
  String get exitWithoutSaving;

  /// No description provided for @pauseTitle.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get pauseTitle;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'RESUME'**
  String get resume;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'RESTART'**
  String get restart;

  /// No description provided for @soundOn.
  ///
  /// In en, this message translates to:
  /// **'SOUND: ON'**
  String get soundOn;

  /// No description provided for @soundOff.
  ///
  /// In en, this message translates to:
  /// **'SOUND: OFF'**
  String get soundOff;

  /// No description provided for @vibrationOn.
  ///
  /// In en, this message translates to:
  /// **'VIBRATION: ON'**
  String get vibrationOn;

  /// No description provided for @vibrationOff.
  ///
  /// In en, this message translates to:
  /// **'VIBRATION: OFF'**
  String get vibrationOff;

  /// No description provided for @nothingToUndo.
  ///
  /// In en, this message translates to:
  /// **'Nothing to undo yet!'**
  String get nothingToUndo;

  /// No description provided for @outOfUndos.
  ///
  /// In en, this message translates to:
  /// **'Out of Undos!'**
  String get outOfUndos;

  /// No description provided for @adUnavailableUndo.
  ///
  /// In en, this message translates to:
  /// **'Ad unavailable. Here is your undo!'**
  String get adUnavailableUndo;

  /// No description provided for @outOfMovesTitle.
  ///
  /// In en, this message translates to:
  /// **'Out of Moves!'**
  String get outOfMovesTitle;

  /// No description provided for @outOfMovesBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ve prepared a rescue bonus for you. Use a bonus to continue.'**
  String get outOfMovesBody;

  /// No description provided for @openBonuses.
  ///
  /// In en, this message translates to:
  /// **'OPEN BONUSES'**
  String get openBonuses;

  /// No description provided for @endSession.
  ///
  /// In en, this message translates to:
  /// **'END SESSION'**
  String get endSession;

  /// No description provided for @sessionEnded.
  ///
  /// In en, this message translates to:
  /// **'Your session has ended.'**
  String get sessionEnded;

  /// No description provided for @startNewGame.
  ///
  /// In en, this message translates to:
  /// **'START NEW GAME'**
  String get startNewGame;

  /// No description provided for @outOfSpace.
  ///
  /// In en, this message translates to:
  /// **'GAME OVER'**
  String get outOfSpace;

  /// No description provided for @hexGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Hex Tic Tac Toe Fun & Strategy'**
  String get hexGameTitle;

  /// No description provided for @hexGameDesc.
  ///
  /// In en, this message translates to:
  /// **'Hex Tic Tac Toe. Play offline vs Bot or friend. Game analysis. Tournaments.'**
  String get hexGameDesc;

  /// No description provided for @tttGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Toe: Fun & Strategy'**
  String get tttGameTitle;

  /// No description provided for @tttGameDesc.
  ///
  /// In en, this message translates to:
  /// **'Bot or friend, deep analysis, adaptive gameplay. Tic Tac Toe — but tactical.'**
  String get tttGameDesc;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonDesc.
  ///
  /// In en, this message translates to:
  /// **'Stay tuned for our next puzzle!'**
  String get comingSoonDesc;

  /// No description provided for @resumeYourGame.
  ///
  /// In en, this message translates to:
  /// **'Resume your game'**
  String get resumeYourGame;

  /// No description provided for @startFresh.
  ///
  /// In en, this message translates to:
  /// **'Start fresh'**
  String get startFresh;

  /// No description provided for @topScores.
  ///
  /// In en, this message translates to:
  /// **'TOP SCORES'**
  String get topScores;

  /// No description provided for @noRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet. Play a game!'**
  String get noRecordsYet;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'CLOSE'**
  String get close;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(Object days);

  /// No description provided for @bonusesTitle.
  ///
  /// In en, this message translates to:
  /// **'BONUSES'**
  String get bonusesTitle;

  /// No description provided for @rescueBonusesTitle.
  ///
  /// In en, this message translates to:
  /// **'RESCUE BONUSES'**
  String get rescueBonusesTitle;

  /// No description provided for @selectBonusToSave.
  ///
  /// In en, this message translates to:
  /// **'Select a bonus to save your game'**
  String get selectBonusToSave;

  /// No description provided for @bonusSurprise.
  ///
  /// In en, this message translates to:
  /// **'Surprise'**
  String get bonusSurprise;

  /// No description provided for @bonusHammer.
  ///
  /// In en, this message translates to:
  /// **'Hammer'**
  String get bonusHammer;

  /// No description provided for @bonusNewBlocks.
  ///
  /// In en, this message translates to:
  /// **'New Blocks'**
  String get bonusNewBlocks;

  /// No description provided for @bonusHint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get bonusHint;

  /// No description provided for @useBonus.
  ///
  /// In en, this message translates to:
  /// **'USE ({count})'**
  String useBonus(int count);

  /// No description provided for @adButton.
  ///
  /// In en, this message translates to:
  /// **'AD'**
  String get adButton;

  /// No description provided for @limitLabel.
  ///
  /// In en, this message translates to:
  /// **'LIMIT'**
  String get limitLabel;

  /// No description provided for @adUnavailableBonus.
  ///
  /// In en, this message translates to:
  /// **'Ad unavailable. Here is your bonus!'**
  String get adUnavailableBonus;

  /// No description provided for @noMovesFound.
  ///
  /// In en, this message translates to:
  /// **'No moves found! Use another bonus.'**
  String get noMovesFound;

  /// No description provided for @perfectClear.
  ///
  /// In en, this message translates to:
  /// **'PERFECT CLEAR!'**
  String get perfectClear;

  /// No description provided for @missLabel.
  ///
  /// In en, this message translates to:
  /// **'MISS +{amount}'**
  String missLabel(int amount);

  /// No description provided for @crossMultiplier.
  ///
  /// In en, this message translates to:
  /// **'CROSS x10!'**
  String get crossMultiplier;

  /// No description provided for @comboMultiplier.
  ///
  /// In en, this message translates to:
  /// **'COMBO x{level}!'**
  String comboMultiplier(int level);

  /// No description provided for @infoComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Info menu coming soon'**
  String get infoComingSoon;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
