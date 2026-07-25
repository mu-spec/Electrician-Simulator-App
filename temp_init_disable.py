import re

with open('lib/core/ads/ad_service.dart', 'r') as f:
    content = f.read()

content = content.replace("  Future<void> initialize() async {\n    if (_initialized) return;\n    try {\n      await MobileAds.instance.initialize();", "  Future<void> initialize() async {\n    _initialized = true; return; // ADS DISABLED\n    if (_initialized) return;\n    try {\n      await MobileAds.instance.initialize();")

with open('lib/core/ads/ad_service.dart', 'w') as f:
    f.write(content)
print("Updated initialize")
