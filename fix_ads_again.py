import re

with open('lib/core/ads/ad_service.dart', 'r') as f:
    content = f.read()

# Fix the broken declaration
content = content.replace("  bool _showingFullscreen = false;\n        _lastFullscreenClosedAt = DateTime.now();", "  bool _showingFullscreen = false;")

with open('lib/core/ads/ad_service.dart', 'w') as f:
    f.write(content)

print("Fixed")
