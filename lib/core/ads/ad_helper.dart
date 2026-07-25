import 'dart:io';

/// Google official **test** AdMob IDs.
/// Replace with your real AdMob app/unit IDs before production release.
class AdHelper {
  AdHelper._();

  /// Sample AdMob App ID (Android) — for testing only.
  static const String androidAppId = 'ca-app-pub-3940256099942544~3347511713';

  /// Sample AdMob App ID (iOS) — for testing only.
  static const String iosAppId = 'ca-app-pub-3940256099942544~1458002511';

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    return 'ca-app-pub-3940256099942544/1033173712';
  }

  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/9257395921';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5575463023';
    }
    return 'ca-app-pub-3940256099942544/9257395921';
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    }
    return 'ca-app-pub-3940256099942544/5224354917';
  }

  /// True while using Google sample IDs (safe for development).
  static const bool usingTestAds = true;
}
