import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import 'main_scaffold.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/ui_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeInOutCubic,
    );
    _scaleAnimation = Tween<double>(begin: 0.72, end: 1).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutBack),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(
          CurvedAnimation(parent: _introController, curve: Curves.easeOutCubic),
        );

    _introController.forward();
    _progressController.forward();

    Timer(const Duration(milliseconds: 2600), () {
      if (mounted) {
        _goToHome();
      }
    });
  }

  Future<void> _goToHome() async {
    // Block leaving splash until App Open is shown (or load fails / max wait).
    try {
      await AdService.instance.waitAndShowColdStartAppOpen(
        timeout: AdService.coldStartMaxWait, // 20s safety max
      );
    } catch (_) {
      // Ignore ad errors; still enter app.
    }
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScaffold()));
  }

  @override
  void dispose() {
    _introController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColors = isDark
        ? const [Color(0xFF020617), Color(0xFF0F172A), Color(0xFF1E3A8A)]
        : const [Color(0xFFEFF6FF), Color(0xFFF8FAFC), Color(0xFFDBEAFE)];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -70,
              child: _GlowCircle(
                color: AppTheme.primaryBlue.withOpacity(0.20),
                size: 220,
              ),
            ),
            Positioned(
              bottom: -110,
              left: -80,
              child: _GlowCircle(
                color: AppTheme.accentCyan.withOpacity(0.18),
                size: 280,
              ),
            ),
            Positioned(
              top: 110,
              left: 28,
              child: Icon(
                Icons.electrical_services,
                size: 46,
                color: Colors.white.withOpacity(isDark ? 0.08 : 0.16),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 34,
              child: Icon(
                Icons.bolt,
                size: 54,
                color: AppTheme.accentOrange.withOpacity(isDark ? 0.18 : 0.25),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 148,
                            height: 148,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryBlue.withOpacity(
                                    isDark ? 0.34 : 0.18,
                                  ),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: Image.asset(
                                'assets/images/app_icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context).t('appTitle'),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1.2,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF0F172A),
                                ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            UiText.t(
                              context,
                              'Electrical Engineering Companion',
                            ),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFCBD5E1)
                                      : const Color(0xFF475569),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 44),
                          SizedBox(
                            width: 230,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: AnimatedBuilder(
                                    animation: _progressController,
                                    builder: (context, _) =>
                                        LinearProgressIndicator(
                                          value: _progressController.value,
                                          minHeight: 8,
                                          backgroundColor: isDark
                                              ? const Color(0xFF334155)
                                              : const Color(0xFFE2E8F0),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                Color
                                              >(AppTheme.primaryBlue),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                AnimatedBuilder(
                                  animation: _progressController,
                                  builder: (context, _) => Text(
                                    _progressController.isCompleted
                                        ? UiText.t(context, 'Preparing ads...')
                                        : "${UiText.t(context, 'Loading')} ${(100 * _progressController.value).clamp(0, 100).toStringAsFixed(0)}%",
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: isDark
                                              ? const Color(0xFF94A3B8)
                                              : const Color(0xFF64748B),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Bottom ad disclaimer - informs user about 20s ad wait so they don't feel stuck
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        UiText.t(context, 'This action may contain ads'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        UiText.t(context, 'Please wait up to 6 seconds on first launch'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
