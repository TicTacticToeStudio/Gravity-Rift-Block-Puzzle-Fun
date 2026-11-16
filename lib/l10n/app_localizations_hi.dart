// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Gravity Rift: Block Puzzle Fun';

  @override
  String get scoreLabel => 'स्कोर';

  @override
  String get gameOverTitle => 'शानदार खेल!';

  @override
  String get gameOverBody => 'नए ब्लॉकों के लिए कोई जगह नहीं बची है।';

  @override
  String yourScore(Object score) {
    return 'आपका स्कोर: $score';
  }

  @override
  String get playAgain => 'फिर से खेलें';

  @override
  String get classicMode => 'क्लासिक मोड';

  @override
  String get classicModeSub => 'अनंत ब्लॉक पहेली। अपना स्कोर तोड़ें।';

  @override
  String get treasureMode => 'खज़ाने की खोज';

  @override
  String get treasureModeSub => 'दुर्लभ क्रिस्टल इकट्ठा करें।';

  @override
  String get playFreeOffline => 'मुफ्त में ऑफ़लाइन खेलें';

  @override
  String get comingSoon => 'जल्द आ रहा है!';

  @override
  String get moreGames => 'और गेम';

  @override
  String get myGamesTitle => 'मेरे गेम';

  @override
  String get playNow => 'अभी खेलें';

  @override
  String get sound => 'ध्वनि';

  @override
  String get continueGame => 'जारी रखें';

  @override
  String get newGame => 'नया खेलें';

  @override
  String get saveAndExit => 'सहेजें और बाहर निकलें';

  @override
  String get exitWithoutSaving => 'बिना सहेजे बाहर निकलें';

  @override
  String get pauseTitle => 'विरामित';

  @override
  String get resume => 'फिर से शुरू करें';

  @override
  String get restart => 'पुनः आरंभ';

  @override
  String get soundOn => 'ध्वनि: चालू';

  @override
  String get soundOff => 'ध्वनि: बंद';

  @override
  String get vibrationOn => 'कंपन: चालू';

  @override
  String get vibrationOff => 'कंपन: बंद';

  @override
  String get nothingToUndo => 'अभी कुछ भी अनडू नहीं करना है!';

  @override
  String get outOfUndos => 'सभी अनडू समाप्त!';

  @override
  String get adUnavailableUndo => 'विज्ञापन अनुपलब्ध। यहाँ आपका अनडू है!';

  @override
  String get outOfMovesTitle => 'चाल समाप्त!';

  @override
  String get outOfMovesBody =>
      'हमने आपके लिए एक रेस्क्यू बोनस तैयार किया है। जारी रखने के लिए बोनस का उपयोग करें।';

  @override
  String get openBonuses => 'बोनस खोलें';

  @override
  String get endSession => 'सत्र समाप्त करें';

  @override
  String get sessionEnded => 'आपका सत्र समाप्त हो गया है।';

  @override
  String get startNewGame => 'नई गेम शुरू करें';

  @override
  String get outOfSpace => 'गेम खत्म';

  @override
  String get hexGameTitle => 'हेक्स टिक टैक टो मज़ा और रणनीति';

  @override
  String get hexGameDesc =>
      'हेक्स टिक टैक टो। बॉट या दोस्त के खिलाफ ऑफ़लाइन खेलें। गेम विश्लेषण। टूर्नामेंट्स।';

  @override
  String get tttGameTitle => 'टिक टैक टो: मज़ा और रणनीति';

  @override
  String get tttGameDesc =>
      'बॉट या दोस्त, गहरा विश्लेषण, अनुकूली गेमप्ले। टिक टैक टो — लेकिन रणनीतिक।';

  @override
  String get comingSoonTitle => 'जल्द आ रहा है';

  @override
  String get comingSoonDesc => 'हमारी अगली पहेली के लिए बने रहें!';

  @override
  String get resumeYourGame => 'अपना गेम फिर से शुरू करें';

  @override
  String get startFresh => 'नया गेम शुरू करें';

  @override
  String get topScores => 'शीर्ष स्कोर';

  @override
  String get noRecordsYet => 'अभी तक कोई रिकॉर्ड नहीं है। एक गेम खेलें!';

  @override
  String get close => 'बंद करें';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'कल';

  @override
  String daysAgo(Object days) {
    return '$days दिन पहले';
  }

  @override
  String get veryLongAgo => 'बहुत समय पहले';

  @override
  String get bonusesTitle => 'बोनस';

  @override
  String get rescueBonusesTitle => 'बचाने वाले बोनस';

  @override
  String get selectBonusToSave => 'अपना गेम सहेजने के लिए एक बोनस चुनें';

  @override
  String get bonusSurprise => 'सरप्राइज';

  @override
  String get bonusHammer => 'हथौड़ा';

  @override
  String get bonusNewBlocks => 'नए ब्लॉक';

  @override
  String get bonusHint => 'सुराग';

  @override
  String useBonus(int count) {
    return 'उपयोग करें ($count)';
  }

  @override
  String get adButton => 'विज्ञापन';

  @override
  String get limitLabel => 'सीमा';

  @override
  String get adUnavailableBonus =>
      'विज्ञापन उपलब्ध नहीं है। यहाँ आपका बोनस है!';

  @override
  String get noMovesFound => 'कोई चाल नहीं मिली! कोई दूसरा बोनस इस्तेमाल करें।';

  @override
  String get perfectClear => 'परफेक्ट क्लियर!';

  @override
  String missLabel(int amount) {
    return 'मिस +$amount';
  }

  @override
  String get crossMultiplier => 'क्रॉस x10!';

  @override
  String comboMultiplier(int level) {
    return 'कॉम्बो x$level!';
  }

  @override
  String get languageTitle => 'भाषा';

  @override
  String get infoTitle => 'जानकारी';

  @override
  String get howToPlay => 'कैसे खेलें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get licenses => 'लाइसेंस';

  @override
  String get aboutGame => 'गेम के बारे में';
}
