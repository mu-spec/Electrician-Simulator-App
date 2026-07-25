import re

with open('lib/presentation/screens/splash_screen.dart', 'r') as f:
    content = f.read()

# We need to change the logic in splash_screen to show the ad BEFORE onboarding, 
# or just rethink how it navigates. Wait, the user said they saw the splash, then the ad, then main menu.
# That means AdService.instance.waitAndShowColdStartAppOpen was called BEFORE Onboarding! 
# Let's look at the exact code in splash_screen.dart.

old_go_to_home = """  Future<void> _goToHome() async {
    final box = await Hive.openBox('settings');
    final hasSeenOnboarding = box.get('hasSeenOnboarding', defaultValue: false);

    if (!hasSeenOnboarding) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
      return;
    }

    // Block leaving splash until App Open is shown (or load fails / max wait).
    try {
      await AdService.instance.waitAndShowColdStartAppOpen(
        timeout: AdService.coldStartMaxWait, // safety max
      );
    } catch (_) {
      // Ignore ad errors; still enter app.
    }
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScaffold()));
  }"""

new_go_to_home = """  Future<void> _goToHome() async {
    final box = await Hive.openBox('settings');
    final hasSeenOnboarding = box.get('hasSeenOnboarding', defaultValue: false);

    // Block leaving splash until App Open is shown (or load fails / max wait).
    // We do this FOR EVERYONE, so the ad shows on the splash screen before any navigation.
    try {
      await AdService.instance.waitAndShowColdStartAppOpen(
        timeout: AdService.coldStartMaxWait, // safety max
      );
    } catch (_) {
      // Ignore ad errors; still enter app.
    }

    if (!mounted) return;

    if (!hasSeenOnboarding) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScaffold()),
      );
    }
  }"""

content = content.replace(old_go_to_home, new_go_to_home)

with open('lib/presentation/screens/splash_screen.dart', 'w') as f:
    f.write(content)
print("Updated splash screen")
