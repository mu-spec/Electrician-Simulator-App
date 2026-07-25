#!/usr/bin/env python3
"""Static 50-language coverage audit for VoltMaster Pro.

Checks the exact translation catalogs, the current display-content fields,
literal UiText calls, placeholders, the rewarded-ad strings, app-title wiring,
and common hard-coded/raw-content regressions. No network access is required.
"""

from pathlib import Path
import gzip
import json
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / "lib/core/localization"


class DartMapParser:
    def __init__(self, source: str):
        self.source = source
        self.index = 0

    def _skip(self):
        while self.index < len(self.source):
            if self.source[self.index].isspace():
                self.index += 1
            elif self.source.startswith("//", self.index):
                end = self.source.find("\n", self.index)
                self.index = len(self.source) if end < 0 else end + 1
            elif self.source.startswith("/*", self.index):
                end = self.source.find("*/", self.index + 2)
                self.index = len(self.source) if end < 0 else end + 2
            else:
                return

    def string(self) -> str:
        self._skip()
        quote = self.source[self.index]
        if quote not in "'\"":
            raise ValueError(f"Expected string at {self.index}")
        triple = self.source.startswith(quote * 3, self.index)
        self.index += 3 if triple else 1
        result = []
        escapes = {
            "n": "\n", "r": "\r", "t": "\t", "b": "\b", "f": "\f",
            "v": "\v", "\\": "\\", "'": "'", '"': '"', "$": "$",
        }
        while self.index < len(self.source):
            if triple and self.source.startswith(quote * 3, self.index):
                self.index += 3
                return "".join(result)
            if not triple and self.source[self.index] == quote:
                self.index += 1
                return "".join(result)
            char = self.source[self.index]
            self.index += 1
            if char != "\\" or self.index >= len(self.source):
                result.append(char)
                continue
            escaped = self.source[self.index]
            self.index += 1
            if escaped == "u":
                if self.index < len(self.source) and self.source[self.index] == "{":
                    end = self.source.find("}", self.index)
                    value = self.source[self.index + 1:end]
                    self.index = end + 1
                else:
                    value = self.source[self.index:self.index + 4]
                    self.index += 4
                result.append(chr(int(value, 16)))
            elif escaped == "x":
                value = self.source[self.index:self.index + 2]
                self.index += 2
                result.append(chr(int(value, 16)))
            else:
                result.append(escapes.get(escaped, "\\" + escaped))
        raise ValueError("Unterminated Dart string")

    def value(self):
        self._skip()
        if self.source[self.index] in "'\"":
            return self.string()
        if self.source[self.index] == "{":
            return self.map()
        if self.source.startswith("const", self.index):
            self.index += 5
            return self.value()
        start = self.index
        depth = 0
        while self.index < len(self.source):
            char = self.source[self.index]
            if char in "'\"":
                self.string()
                continue
            if char in "([{":
                depth += 1
            elif char in ")]} ".replace(" ", ""):
                if depth == 0:
                    break
                depth -= 1
            elif char == "," and depth == 0:
                break
            self.index += 1
        return self.source[start:self.index].strip()

    def map(self) -> dict:
        self._skip()
        if self.source[self.index] != "{":
            raise ValueError(f"Expected map at {self.index}")
        self.index += 1
        result = {}
        while True:
            self._skip()
            if self.source[self.index] == "}":
                self.index += 1
                return result
            key = self.string() if self.source[self.index] in "'\"" else self.value()
            self._skip()
            if self.source[self.index] != ":":
                raise ValueError(f"Expected colon at {self.index}")
            self.index += 1
            result[key] = self.value()
            self._skip()
            if self.index < len(self.source) and self.source[self.index] == ",":
                self.index += 1


def parse_map(path: Path, marker: str) -> dict:
    source = path.read_text(encoding="utf-8")
    pattern = marker
    if " " in marker:
        pattern = r"\s*".join(re.escape(part) for part in marker.split())
    
    alternates = [
        pattern,
        r"(_translations|_localizedValues|_translationsMap|translations|_data|_strings|_phrases)\s*=",
        r"Map<String,\s*Map<String,\s*String>>\s*\w+\s*="
    ]
    match = None
    for alt in alternates:
        match = re.search(alt, source)
        if match:
            break
            
    if match:
        start = source.index("{", match.end() - 1 if "{" in match.group(0) else match.end())
    else:
        lang_match = re.search(r"[\x27\"](en|it|ur|es)[\x27\"]\s*:\s*\{", source)
        if not lang_match:
            raise ValueError(f"Could not find translation map structure in {path}")
        start = source.rfind("{", 0, lang_match.start())
        if start < 0:
            raise ValueError(f"Could not find outer opening brace in {path}")
            
    return DartMapParser(source[start:]).map()


def fail(message: str, errors: list[str]):
    errors.append(message)


def main() -> int:
    errors: list[str] = []
    app_file = L10N / "app_localizations.dart"
    app_source = app_file.read_text(encoding="utf-8")
    supported = re.findall(r"AppLanguage\(code: '([^']+)'", app_source)
    if len(supported) != 50 or len(set(supported)) != 50:
        fail(f"Expected 50 unique supported languages, found {len(set(supported))}", errors)
    non_english = [code for code in supported if code != "en"]

    app_maps = parse_map(app_file, "_translations =")
    if set(app_maps) != set(supported):
        fail("AppLocalizations language set does not match supportedLanguages", errors)
    english_app_keys = set(app_maps.get("en", {}))
    for code in supported:
        missing = english_app_keys - set(app_maps.get(code, {}))
        if missing:
            fail(f"{code}: missing {len(missing)} AppLocalizations keys", errors)
        if not app_maps.get(code, {}).get("appTitle"):
            fail(f"{code}: appTitle is missing", errors)

    required = json.loads((ROOT / "scripts/localization_required_strings.json").read_text(encoding="utf-8"))
    required_set = set(required)
    placeholder_re = re.compile(r"\{[A-Za-z_][A-Za-z0-9_]*\}|\$\{[^}]+\}")
    
    base_keys = set()
    for code in non_english:
        path = ROOT / f"assets/l10n/{code}.json.gz"
        if not path.exists():
            fail(f"{code}: compressed asset catalog file is missing", errors)
            continue
        try:
            with gzip.open(path, "rt", encoding="utf-8") as f:
                catalog = json.load(f)
        except Exception as e:
            fail(f"{code}: failed to read json.gz asset ({e})", errors)
            continue
            
        if not base_keys:
            base_keys = set(catalog.keys())
        else:
            if set(catalog.keys()) != base_keys:
                fail(f"{code}: catalog key set differs (found {len(catalog)}, expected {len(base_keys)})", errors)
                
        missing = required_set - set(catalog)
        if missing:
            fail(f"{code}: asset catalog missing {len(missing)} required strings", errors)
            
        for source, translated in catalog.items():
            if not isinstance(translated, str) or not translated.strip():
                fail(f"{code}: empty translation for {source!r}", errors)
                break
            if "\ufffd" in translated:
                fail(f"{code}: replacement character found for {source!r}", errors)
                break
            if set(placeholder_re.findall(source)) != set(placeholder_re.findall(translated)):
                fail(f"{code}: placeholder mismatch for {source!r}", errors)
                break

    # New rewarded-ad strings explicitly requested by product.
    rewarded_strings = {
        "Ads", "Ads paused (reward active)", "Watch Ad · Remove Ads 24h",
        "Optional. Watch a short ad to hide ads for 24 hours.",
        "Banner, interstitial and app-open ads are hidden temporarily.",
        "Ads removed for 24 hours. Enjoy!",
        "Rewarded ad is not ready yet. Please try again in a moment.",
        "Watch Ad to Retry Free",
    }
    if not rewarded_strings.issubset(required_set | base_keys):
        fail("Rewarded-ad localization keys are incomplete", errors)

    # App name must be obtained through appTitle in all in-app locations.
    brand_files = [
        ROOT / "lib/main.dart",
        ROOT / "lib/presentation/screens/home/home_screen.dart",
        ROOT / "lib/presentation/screens/settings/settings_screen.dart",
        ROOT / "lib/presentation/screens/splash_screen.dart",
    ]
    for path in brand_files:
        source = path.read_text(encoding="utf-8")
        if "'VoltMaster Pro'" in source or '"VoltMaster Pro"' in source:
            fail(f"Hard-coded app title remains in {path.relative_to(ROOT)}", errors)

    # Guard the previously raw content paths that caused English subcards.
    localized_content = (L10N / "localized_content.dart").read_text(encoding="utf-8")
    required_code_fragments = [
        "DataTranslations.translate(langCode, text)",
        "_translate(context, article.summary)",
        "_translate(context, article.content)",
        "textList(context, diagram.steps)",
        "textList(context, diagram.components)",
        "textList(context, question.options)",
        "_translate(context, question.explanation)",
        "textList(context, standard.keyPoints)",
    ]
    for fragment in required_code_fragments:
        if fragment not in localized_content:
            fail(f"Exact localized-content path missing: {fragment}", errors)

    # Simple hard-coded literal UI guard. Formatted numeric/currency strings and
    # bullets are intentionally excluded because they contain no source prose.
    hardcoded = []
    direct_text = re.compile(r"(?:const\s+)?Text\s*\(\s*(['\"])(.*?)\1", re.DOTALL)
    for path in (ROOT / "lib/presentation").rglob("*.dart"):
        source = path.read_text(encoding="utf-8")
        for match in direct_text.finditer(source):
            value = match.group(2)
            if not value or "$" in value or value.strip() in {"•", "•  "}:
                continue
            if re.fullmatch(r"[A-Za-z][A-Za-z0-9 .,:;!?()&/+-]{2,}", value):
                hardcoded.append(f"{path.relative_to(ROOT)}: {value[:80]}")
    if hardcoded:
        fail("Hard-coded literal Text widgets remain: " + "; ".join(hardcoded[:8]), errors)

    base_count = len(base_keys) - len(required_set) if base_keys else 0
    print("VoltMaster Pro localization audit")
    print(f"  Supported languages: {len(supported)} (English + {len(non_english)} translated)")
    print(f"  Base exact keys per translated language: {base_count}")
    print(f"  Audit-generated exact keys per translated language: {len(required_set)}")
    print(f"  Total exact lookup coverage per translated language: {len(base_keys | required_set)}")
    print(f"  Rewarded-ad strings checked: {len(rewarded_strings)}")
    print(f"  App-title language entries checked: {len(supported)}")
    if errors:
        print(f"  RESULT: FAIL ({len(errors)} issue(s))")
        for error in errors:
            print("   - " + error)
        return 1
    print("  RESULT: PASS - 100% structural key coverage for all audited user-visible strings")
    print("  Note: linguistic quality still benefits from native-speaker review.")
    return 0


if __name__ == "__main__":
    sys.exit(main())