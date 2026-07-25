import re

with open('lib/core/ads/ad_service.dart', 'r') as f:
    content = f.read()

# Change the coldStartMaxWait duration from 20 to 6 seconds
content = re.sub(
    r'static const Duration coldStartMaxWait = Duration\(seconds: 20\);',
    r'static const Duration coldStartMaxWait = Duration(seconds: 6);',
    content
)

with open('lib/core/ads/ad_service.dart', 'w') as f:
    f.write(content)

print("Updated ad_service.dart")
