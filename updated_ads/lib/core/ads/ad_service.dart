import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'ad_helper.dart';

/// Central ad manager for Banner, Interstitial, App Open, Rewarded.
///
/// App Open policy (per product request):
/// - Cold start: wait for App Open to load+show before leaving splash
///   (hard safety timeout so offline devices are not stuck forever)
/// - Resume: show App Open when user returns from another app
class AdService with WidgetsBindingObserver {
  AdService._();
  static final AdService instance = AdService._();

  static const String _boxName = 'ad_prefs';
  static const String _adsFreeUntilKey = 'adsFreeUntilMs';

  bool _initialized = false;
  bool _lifecycleAttached = false;
  bool _showingFullscreen = false;
  bool _appInForeground = true;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoading = false;

  AppOpenAd? _appOpenAd;
  bool _isAppOpenLoading = false;
  DateTime? _appOpenLoadTime;
  Completer<void>? _appOpenLoadCompleter;
  static const Duration _appOpenMaxAge = Duration(hours: 4);

  /// Max wait on splash for app-open load (network safety).
  static const Duration coldStartMaxWait = Duration(seconds: 20);

  /// Show resume app-open if user was away at least this long.
  static const Duration minBackgroundForResumeAd = Duration(seconds: 2);

  /// Tiny gap so we don't double-fire app open.
  static const Duration minAppOpenGap = Duration(seconds: 8);

  RewardedAd? _rewardedAd;
  bool _isRewardedLoading = false;

  int _calculatorActions = 0;
  int _contentOpens = 0;

  DateTime? _lastInterstitialAt;
  DateTime? _lastFullscreenAt;
  DateTime? _lastFullscreenClosedAt;
  DateTime? _lastAppOpenShownAt;
  DateTime? _pausedAt;

  static const Duration _minInterstitialGap = Duration(seconds: 45);
  static const Duration _minAnyFullscreenGap = Duration(seconds: 30);
  static const Duration _rewardedAdsFreeDuration = Duration(hours: 24);

  final ValueNotifier<bool> adsFreeNotifier = ValueNotifier<bool>(false);

  bool get isInitialized => _initialized;
  bool get isAdsFree => adsFreeNotifier.value;
  bool get isRewardedReady => _rewardedAd != null;
  bool get isAppOpenReady => _appOpenAd != null && !_isAppOpenExpired;

  bool get _isAppOpenExpired {
    if (_appOpenLoadTime == null) return true;
    return DateTime.now().difference(_appOpenLoadTime!) > _appOpenMaxAge;
  }

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      await MobileAds.instance.initialize();
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: const <String>[]),
      );

      await _restoreAdsFreeState();
      _attachLifecycle();

      _initialized = true;
      _loadInterstitial();
      _loadAppOpen();
      _loadRewarded();
      debugPrint('[Ads] initialized (test IDs: ${AdHelper.usingTestAds})');
    } catch (e, st) {
      debugPrint('[Ads] init failed: $e\n$st');
    }
  }

  void _attachLifecycle() {
    if (_lifecycleAttached) return;
    WidgetsBinding.instance.addObserver(this);
    _lifecycleAttached = true;
  }

  Future<void> _restoreAdsFreeState() async {
    try {
      final box = await Hive.openBox(_boxName);
      final untilMs = box.get(_adsFreeUntilKey) as int?;
      if (untilMs != null) {
        final until = DateTime.fromMillisecondsSinceEpoch(untilMs);
        adsFreeNotifier.value = DateTime.now().isBefore(until);
        if (!adsFreeNotifier.value) {
          await box.delete(_adsFreeUntilKey);
        }
      }
    } catch (e) {
      debugPrint('[Ads] restore ads-free failed: $e');
    }
  }

  AdRequest get _request => const AdRequest();

  // ---------------------------------------------------------------------------
  // Lifecycle — App Open on every meaningful resume
  // ---------------------------------------------------------------------------

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      if (_appInForeground) {
        _pausedAt ??= DateTime.now();
        _appInForeground = false;
      }
      return;
    }
    if (state == AppLifecycleState.resumed) {
      final wasBackground = !_appInForeground;
      _appInForeground = true;
      final pausedAt = _pausedAt;
      _pausedAt = null;
      if (!wasBackground || pausedAt == null) return;

      final away = DateTime.now().difference(pausedAt);
      debugPrint('[Ads] resumed after ${away.inSeconds}s');
      if (away >= minBackgroundForResumeAd) {
        // Fire-and-forget; do not await in lifecycle callback.
        unawaited(showAppOpenIfAvailable(reason: 'resume', force: true));
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Interstitial
  // ---------------------------------------------------------------------------

  void _loadInterstitial() {
    if (!_initialized || isAdsFree) return;
    if (_isInterstitialLoading || _interstitialAd != null) return;
    _isInterstitialLoading = true;
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: _request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoading = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (_) => _showingFullscreen = true,
            onAdDismissedFullScreenContent: (ad) {
              _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
              ad.dispose();
              _interstitialAd = null;
              _loadInterstitial();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('[Ads] interstitial show failed: $error');
              _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
              ad.dispose();
              _interstitialAd = null;
              _loadInterstitial();
            },
          );
          debugPrint('[Ads] interstitial loaded');
        },
        onAdFailedToLoad: (error) {
          debugPrint('[Ads] interstitial load failed: $error');
          _isInterstitialLoading = false;
          _interstitialAd = null;
          Future.delayed(const Duration(seconds: 20), _loadInterstitial);
        },
      ),
    );
  }

  bool get _canShowAnyFullscreen {
    if (isAdsFree || _showingFullscreen) return false;
    final last = _lastFullscreenAt;
    if (last != null && DateTime.now().difference(last) < _minAnyFullscreenGap) {
      return false;
    }
    return true;
  }

  bool get _canShowInterstitialNow {
    if (!_canShowAnyFullscreen || _interstitialAd == null) return false;
    final last = _lastInterstitialAt;
    if (last != null && DateTime.now().difference(last) < _minInterstitialGap) {
      return false;
    }
    return true;
  }

  Future<bool> showInterstitialIfReady({String reason = ''}) async {
    if (!_canShowInterstitialNow) {
      _loadInterstitial();
      return false;
    }
    final ad = _interstitialAd;
    if (ad == null) return false;
    _lastInterstitialAt = DateTime.now();
    _lastFullscreenAt = DateTime.now();
    _interstitialAd = null;
    debugPrint('[Ads] showing interstitial ($reason)');
    await ad.show();
    return true;
  }

  Future<void> onCalculatorResult() async {
    if (isAdsFree) return;
    _calculatorActions++;
    if (_calculatorActions % 2 == 0) {
      await showInterstitialIfReady(reason: 'calculator');
    } else {
      _loadInterstitial();
    }
  }

  Future<void> onQuizCompleted() async {
    if (isAdsFree) return;
    await showInterstitialIfReady(reason: 'quiz_complete');
  }

  Future<void> onContentDetailOpened({required String type}) async {
    if (isAdsFree) return;
    _contentOpens++;
    if (_contentOpens % 3 == 0) {
      await showInterstitialIfReady(reason: 'content_$type');
    } else {
      _loadInterstitial();
    }
  }

  // ---------------------------------------------------------------------------
  // App Open
  // ---------------------------------------------------------------------------

  void _loadAppOpen() {
    if (!_initialized || isAdsFree) return;
    if (_isAppOpenLoading || (_appOpenAd != null && !_isAppOpenExpired)) return;
    if (_appOpenAd != null && _isAppOpenExpired) {
      _appOpenAd?.dispose();
      _appOpenAd = null;
    }

    _isAppOpenLoading = true;
    _appOpenLoadCompleter = Completer<void>();

    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdUnitId,
      request: _request,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenLoadTime = DateTime.now();
          _isAppOpenLoading = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (_) {
              _showingFullscreen = true;
              debugPrint('[Ads] app open showed');
            },
            onAdDismissedFullScreenContent: (ad) {
              _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
              ad.dispose();
              _appOpenAd = null;
              _appOpenLoadTime = null;
              _loadAppOpen();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('[Ads] app open show failed: $error');
              _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
              ad.dispose();
              _appOpenAd = null;
              _appOpenLoadTime = null;
              _loadAppOpen();
            },
          );
          debugPrint('[Ads] app open loaded');
          if (!(_appOpenLoadCompleter?.isCompleted ?? true)) {
            _appOpenLoadCompleter?.complete();
          }
        },
        onAdFailedToLoad: (error) {
          debugPrint('[Ads] app open load failed: $error');
          _isAppOpenLoading = false;
          _appOpenAd = null;
          if (!(_appOpenLoadCompleter?.isCompleted ?? true)) {
            _appOpenLoadCompleter?.complete();
          }
          Future.delayed(const Duration(seconds: 15), _loadAppOpen);
        },
      ),
    );
  }

  Future<void> _waitForAppOpenLoad(Duration timeout) async {
    if (isAppOpenReady) return;
    if (!_initialized) {
      await initialize();
    }
    if (_appOpenAd == null && !_isAppOpenLoading) {
      _loadAppOpen();
    }
    final completer = _appOpenLoadCompleter;
    if (completer == null || completer.isCompleted) {
      // Poll until ready or timeout.
      final start = DateTime.now();
      while (!isAppOpenReady && DateTime.now().difference(start) < timeout) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        if (_appOpenAd == null && !_isAppOpenLoading) _loadAppOpen();
      }
      return;
    }
    try {
      await completer.future.timeout(timeout);
    } catch (_) {}
  }

  /// Shows App Open if ready.
  /// [force] skips interstitial-style gaps for resume/cold-start priority.
  Future<bool> showAppOpenIfAvailable({
    String reason = 'open',
    bool force = false,
  }) async {
    if (isAdsFree) return false;
    if (_showingFullscreen) return false;

    if (_lastFullscreenClosedAt != null && DateTime.now().difference(_lastFullscreenClosedAt!) < const Duration(seconds: 3)) {
      debugPrint('[Ads] app open skipped (a fullscreen ad was just closed)');
      return false;
    }

    if (!force) {
      final lastFs = _lastFullscreenAt;
      if (lastFs != null && DateTime.now().difference(lastFs) < _minAnyFullscreenGap) {
        return false;
      }
    }

    final lastOpen = _lastAppOpenShownAt;
    if (lastOpen != null && DateTime.now().difference(lastOpen) < minAppOpenGap) {
      debugPrint('[Ads] app open skipped (min gap)');
      return false;
    }

    if (_appOpenAd == null || _isAppOpenExpired) {
      _loadAppOpen();
      return false;
    }

    final ad = _appOpenAd;
    if (ad == null) return false;

    final dismissed = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _showingFullscreen = true;
        debugPrint('[Ads] app open showed ($reason)');
      },
      onAdDismissedFullScreenContent: (ad) {
        _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
        ad.dispose();
        _appOpenAd = null;
        _appOpenLoadTime = null;
        if (!dismissed.isCompleted) dismissed.complete();
        _loadAppOpen();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('[Ads] app open show failed: $error');
        _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
        ad.dispose();
        _appOpenAd = null;
        _appOpenLoadTime = null;
        if (!dismissed.isCompleted) dismissed.complete();
        _loadAppOpen();
      },
    );

    _appOpenAd = null;
    _lastFullscreenAt = DateTime.now();
    _lastAppOpenShownAt = DateTime.now();
    debugPrint('[Ads] showing app open ($reason)');
    await ad.show();
    // Wait until user closes the ad (or show fails).
    await dismissed.future.timeout(
      const Duration(minutes: 2),
      onTimeout: () {},
    );
    return true;
  }

  /// Cold start: WAIT for app open to load and show before continuing.
  /// Only continues without ad if load fails within [timeout] (offline safety).
  Future<bool> waitAndShowColdStartAppOpen({
    Duration timeout = coldStartMaxWait,
  }) async {
    if (isAdsFree) return false;

    if (!_initialized) {
      await initialize();
    }

    debugPrint('[Ads] cold start: waiting up to ${timeout.inSeconds}s for app open...');
    await _waitForAppOpenLoad(timeout);

    if (!isAppOpenReady) {
      debugPrint('[Ads] cold start: app open not ready after wait — continue');
      return false;
    }

    final shown = await showAppOpenIfAvailable(reason: 'cold_start', force: true);
    debugPrint('[Ads] cold start: shown=$shown');
    return shown;
  }

  // ---------------------------------------------------------------------------
  // Rewarded
  // ---------------------------------------------------------------------------

  void _loadRewarded() {
    if (!_initialized || _isRewardedLoading || _rewardedAd != null) return;
    _isRewardedLoading = true;
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: _request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoading = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (_) => _showingFullscreen = true,
            onAdDismissedFullScreenContent: (ad) {
              _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
              ad.dispose();
              _rewardedAd = null;
              _loadRewarded();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('[Ads] rewarded show failed: $error');
              _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
              ad.dispose();
              _rewardedAd = null;
              _loadRewarded();
            },
          );
          debugPrint('[Ads] rewarded loaded');
        },
        onAdFailedToLoad: (error) {
          debugPrint('[Ads] rewarded load failed: $error');
          _isRewardedLoading = false;
          _rewardedAd = null;
          Future.delayed(const Duration(seconds: 25), _loadRewarded);
        },
      ),
    );
  }

  Future<bool> showRewarded({
    required void Function(RewardItem reward) onReward,
    String reason = '',
  }) async {
    if (_showingFullscreen) return false;
    if (_rewardedAd == null) {
      _loadRewarded();
      return false;
    }

    final ad = _rewardedAd!;
    var earned = false;
    _rewardedAd = null;
    _lastFullscreenAt = DateTime.now();

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) => _showingFullscreen = true,
      onAdDismissedFullScreenContent: (ad) {
        _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
        ad.dispose();
        _loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('[Ads] rewarded show failed: $error');
        _showingFullscreen = false;
        _lastFullscreenClosedAt = DateTime.now();
        ad.dispose();
        _loadRewarded();
      },
    );

    debugPrint('[Ads] showing rewarded ($reason)');
    await ad.show(
      onUserEarnedReward: (ad, reward) {
        earned = true;
        onReward(reward);
      },
    );
    return earned;
  }

  Future<bool> watchAdToRemoveAdsForOneDay() async {
    var granted = false;
    final shown = await showRewarded(
      reason: 'remove_ads_24h',
      onReward: (_) async {
        granted = true;
        final until = DateTime.now().add(_rewardedAdsFreeDuration);
        try {
          final box = await Hive.openBox(_boxName);
          await box.put(_adsFreeUntilKey, until.millisecondsSinceEpoch);
        } catch (_) {}
        adsFreeNotifier.value = true;
        _interstitialAd?.dispose();
        _interstitialAd = null;
        _appOpenAd?.dispose();
        _appOpenAd = null;
        debugPrint('[Ads] ads free until $until');
      },
    );
    return shown && granted;
  }

  Future<bool> watchAdForQuizRetry({required VoidCallback onEarned}) async {
    var granted = false;
    final shown = await showRewarded(
      reason: 'quiz_retry',
      onReward: (_) {
        granted = true;
        onEarned();
      },
    );
    return shown && granted;
  }

  void dispose() {
    if (_lifecycleAttached) {
      WidgetsBinding.instance.removeObserver(this);
      _lifecycleAttached = false;
    }
    _interstitialAd?.dispose();
    _appOpenAd?.dispose();
    _rewardedAd?.dispose();
    _interstitialAd = null;
    _appOpenAd = null;
    _rewardedAd = null;
  }
}
