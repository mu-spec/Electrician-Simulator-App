import re

with open('lib/presentation/screens/onboarding_screen.dart', 'r') as f:
    content = f.read()

# We no longer need to manually start loading the App Open ad here because it already happened on the Splash screen
old_init = """  @override
  void initState() {
    super.initState();
    // Start loading the App Open Ad in the background quietly
    AdService.instance.loadAppOpen();
  }"""

new_init = """  @override
  void initState() {
    super.initState();
  }"""

content = content.replace(old_init, new_init)

with open('lib/presentation/screens/onboarding_screen.dart', 'w') as f:
    f.write(content)
