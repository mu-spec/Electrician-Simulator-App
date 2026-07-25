import re

with open('lib/core/ads/ad_service.dart', 'r') as f:
    content = f.read()

# Insert the variable
content = content.replace("DateTime? _lastFullscreenAt;", "DateTime? _lastFullscreenAt;\n  DateTime? _lastFullscreenClosedAt;")

# Add a check to showAppOpenIfAvailable
app_open_check = """  Future<bool> showAppOpenIfAvailable({
    String reason = 'open',
    bool force = false,
  }) async {
    if (isAdsFree) return false;
    if (_showingFullscreen) return false;

    if (_lastFullscreenClosedAt != null && DateTime.now().difference(_lastFullscreenClosedAt!) < const Duration(seconds: 3)) {
      debugPrint('[Ads] app open skipped (a fullscreen ad was just closed)');
      return false;
    }"""

content = re.sub(
    r"  Future<bool> showAppOpenIfAvailable\(\{\s*String reason = 'open',\s*bool force = false,\s*\}\) async \{\s*if \(isAdsFree\) return false;\s*if \(_showingFullscreen\) return false;",
    app_open_check,
    content
)

# Insert _lastFullscreenClosedAt whenever _showingFullscreen = false; is executed.
# But wait, there are places where ad show fails. Should we prevent AppOpen if show failed? Yes, doesn't hurt to wait 3 seconds.
# Let's replace _showingFullscreen = false; with both lines.
# Note: In some places it's _showingFullscreen = false;, in others there are tabs/spaces.
# Let's use regex to replace `_showingFullscreen = false;`

content = re.sub(r'_showingFullscreen\s*=\s*false;', '_showingFullscreen = false;\n        _lastFullscreenClosedAt = DateTime.now();', content)

with open('lib/core/ads/ad_service.dart', 'w') as f:
    f.write(content)
print("Done")

