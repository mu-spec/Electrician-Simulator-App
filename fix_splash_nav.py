import re

with open('lib/presentation/screens/splash_screen.dart', 'r') as f:
    content = f.read()

# Make sure Hive is imported
if "import 'package:hive_flutter/hive_flutter.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:hive_flutter/hive_flutter.dart';\nimport 'onboarding_screen.dart';")

nav_logic = """  Future<void> _goToHome() async {
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

content = re.sub(
    r'  Future<void> _goToHome\(\) async \{.*?\).pushReplacement\(MaterialPageRoute\(builder: \(_\) => const MainScaffold\(\)\)\);\s*\}',
    nav_logic,
    content,
    flags=re.DOTALL
)

with open('lib/presentation/screens/splash_screen.dart', 'w') as f:
    f.write(content)

print("Updated splash nav logic")
