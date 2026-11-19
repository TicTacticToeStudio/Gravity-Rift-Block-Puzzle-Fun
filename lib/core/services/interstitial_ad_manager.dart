import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isLoading = false;

  static void loadAd() {
    if (_interstitialAd != null || _isLoading) return;
    _isLoading = true;

    InterstitialAd.load(
      // Official Google Test Ad Unit ID for Android Interstitial Ads
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
          debugPrint('InterstitialAd loaded.');
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  static void showAd({
    required VoidCallback onAdDismissed,
    required VoidCallback onAdFailed,
  }) {
    if (_interstitialAd == null) {
      debugPrint('InterstitialAd is not ready yet. Triggering fallback.');
      onAdFailed();
      loadAd(); // Try to load again in background
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        loadAd();
        onAdDismissed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        loadAd();
        onAdFailed();
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }
}