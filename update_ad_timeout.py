import re

with open('lib/core/ads/ad_service.dart', 'r') as f:
    content = f.read()

# Change the minBackgroundForResumeAd duration from 2 to 30 seconds
content = re.sub(
    r'static const Duration minBackgroundForResumeAd = Duration\(seconds: 2\);',
    r'static const Duration minBackgroundForResumeAd = Duration(seconds: 30);',
    content
)

with open('lib/core/ads/ad_service.dart', 'w') as f:
    f.write(content)

print("Updated ad timeout")
