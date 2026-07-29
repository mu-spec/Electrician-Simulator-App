import 'package:flutter/material.dart';
import 'package:electrician_simulator_app/core/localization/ui_text.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:electrician_simulator_app/presentation/screens/main_scaffold.dart';
import 'package:electrician_simulator_app/core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // These are the 3 distinct images for your tutorial pages.
  // Please make sure you place your 3 images in the assets/images/ folder 
  // and name them exactly like this:
  final List<String> _images = [
    'assets/images/tutorial_1.png',
    'assets/images/tutorial_2.png',
    'assets/images/tutorial_3.png',
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _finishOnboarding() async {
    final box = await Hive.openBox('settings');
    await box.put('hasSeenOnboarding', true);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScaffold()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Controls (Skip)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    style: TextButton.styleFrom(
                      backgroundColor: isDark ? Colors.white10 : Colors.grey[100],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      UiText.t(context, 'Skip'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Image PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                  );
                },
              ),
            ),

            // Bottom Controls (Now safely below the image, not overlapping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black26 : Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, -3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicators
                  Row(
                    children: List.generate(
                      _images.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppTheme.primaryBlue
                              : (isDark ? Colors.white24 : Colors.grey[300]),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  // Next / Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _images.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == _images.length - 1
                          ? UiText.t(context, 'Get Started')
                          : UiText.t(context, 'Next'),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
