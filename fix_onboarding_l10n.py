import re

with open('lib/presentation/screens/onboarding_screen.dart', 'r') as f:
    content = f.read()

# 1. Add UiText import
if "import 'package:voltmaster_pro/core/localization/ui_text.dart';" not in content:
    content = content.replace(
        "import 'package:flutter/material.dart';", 
        "import 'package:flutter/material.dart';\nimport 'package:voltmaster_pro/core/localization/ui_text.dart';"
    )

# 2. Replace 'Skip'
content = re.sub(
    r"Text\(\s*'Skip',",
    r"Text(\n                      UiText.t(context, 'Skip'),",
    content
)

# 3. Replace the Get Started / Next ternary
old_ternary = """                    child: Text(
                      _currentPage == _images.length - 1
                          ? 'Get Started'
                          : 'Next',"""

new_ternary = """                    child: Text(
                      _currentPage == _images.length - 1
                          ? UiText.t(context, 'Get Started')
                          : UiText.t(context, 'Next'),"""

content = content.replace(old_ternary, new_ternary)

with open('lib/presentation/screens/onboarding_screen.dart', 'w') as f:
    f.write(content)

print("Fixed localization in onboarding")
