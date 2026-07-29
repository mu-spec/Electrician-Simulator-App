import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';
import 'ad_service.dart';

/// Adaptive banner used above the bottom navigation bar.
/// Hidden automatically while rewarded "ads free" period is active.
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _loaded = false;
  int _retryCount = 0;
  bool _loadStarted = false;

  @override
  void initState() {
    super.initState();
    AdService.instance.adsFreeNotifier.addListener(_onAdsFreeChanged);
  }

  void _onAdsFreeChanged() {
    if (!mounted) return;
    if (AdService.instance.isAdsFree) {
      _bannerAd?.dispose();
      setState(() {
        _bannerAd = null;
        _loaded = false;
        _loadStarted = false;
      });
    } else {
      _loadBanner();
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadStarted && !AdService.instance.isAdsFree) {
      _loadBanner();
    }
  }

  Future<void> _loadBanner() async {
    if (_bannerAd != null || AdService.instance.isAdsFree) return;
    _loadStarted = true;
    if (!AdService.instance.isInitialized) {
      await AdService.instance.initialize();
    }

    final width = MediaQuery.sizeOf(context).width.truncate();
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);
    if (size == null) {
      debugPrint('[Ads] adaptive banner size unavailable');
      return;
    }

    final ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted || AdService.instance.isAdsFree) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
            _loaded = true;
            _retryCount = 0;
          });
          debugPrint('[Ads] banner loaded');
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('[Ads] banner failed: $error');
          ad.dispose();
          if (!mounted) return;
          setState(() {
            _bannerAd = null;
            _loaded = false;
          });
          if (_retryCount < 3 && !AdService.instance.isAdsFree) {
            _retryCount++;
            Future.delayed(Duration(seconds: 8 * _retryCount), () {
              if (mounted && !AdService.instance.isAdsFree) {
                _loadStarted = false;
                _loadBanner();
              }
            });
          }
        },
      ),
    );

    await ad.load();
  }

  @override
  void dispose() {
    AdService.instance.adsFreeNotifier.removeListener(_onAdsFreeChanged);
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AdService.instance.isAdsFree || !_loaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      alignment: Alignment.center,
      // bottom: true is required for Android 16 (targetSdk 36).
      //
      // Android 16 enforces edge-to-edge and removes the
      // windowOptOutEdgeToEdgeEnforcement escape hatch, so the app window now
      // extends behind the system navigation bar. This widget is anchored at
      // the bottom of every route by the global builder in main.dart, which
      // makes it exactly the kind of fixed bottom element that ends up
      // underneath the gesture/nav bar.
      //
      // This previously read `bottom: false`, which explicitly discarded the
      // bottom inset. On Android 16 that would let the navigation bar overlap
      // the banner. Keeping top: false is still correct: this widget never
      // touches the status bar.
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      ),
    );
  }
}
