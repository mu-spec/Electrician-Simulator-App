import re

with open('lib/core/ads/ad_service.dart', 'r') as f:
    content = f.read()

# Force isAdsFree to true
content = content.replace("bool get isAdsFree => adsFreeNotifier.value;", "bool get isAdsFree => true; // ADS DISABLED GLOBALLY")

# Force the notifier to be true by default so the UI knows it's "Ads Free"
content = content.replace("final ValueNotifier<bool> adsFreeNotifier = ValueNotifier<bool>(false);", "final ValueNotifier<bool> adsFreeNotifier = ValueNotifier<bool>(true); // ADS DISABLED GLOBALLY")

with open('lib/core/ads/ad_service.dart', 'w') as f:
    f.write(content)
print("Updated ad_service.dart")
