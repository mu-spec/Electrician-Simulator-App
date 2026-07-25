#!/usr/bin/env python3
"""
Generic enhancement of all 50 diagrams steps to match ultra-realistic PNG visuals
Adds color references (Red Live, Blue Neutral, Green-Yellow Earth) and device labels
"""
import re

path = "lib/data/content/wiring_content.dart"
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

def enhance_step(s, diag_id, title):
    # s is raw step text without quotes
    original = s.strip()
    low = original.lower()
    # Avoid double-enhancing if already mentions color or PNG
    has_color = "red live" in low or "blue neutral" in low or "green-yellow" in low or "png" in low
    if has_color:
        # Already enhanced, keep but ensure title reference
        return original

    enhanced = original

    # Add color references based on keywords
    if any(k in low for k in ["phase", "live", " l terminal", "switched live", "mcb output"]):
        if "red" not in low:
            enhanced += " — Red Live wire (thick red arrow marked Live / L as in PNG)"
    if "neutral" in low:
        if "blue" not in low:
            enhanced += " — Blue Neutral wire (blue arrow to Neutral Bar blue top right with + screws as in PNG)"
    if "earth" in low:
        if "green-yellow" not in low:
            enhanced += " — Green-Yellow striped Earth wire to Earth Bar MET green-yellow striped top left (see green-yellow arrow)"
    if "traveller" in low or "traveler" in low:
        enhanced += " — Brown/Black traveller wires L1-L1 and L2-L2 between switches as shown in PNG"
    if "com" in low and "common" in low:
        enhanced += " (COM terminal as labeled in PNG switch)"
    if "busbar" in low:
        enhanced += " — Red busbar horizontal feeding MCBs as in PNG DB"
    if "mcb" in low and "lighting" in low or "6a" in low:
        enhanced += " (6A MCB labeled Lighting with black toggle as in PNG)"
    if "rcd" in low:
        enhanced += " — RCD 63A 30mA with yellow T test button as in PNG middle"
    if "main switch" in low:
        enhanced += " — Main Switch 100A Double DP leftmost with ON/OFF as in PNG"
    if "contactor" in low or "k1" in low:
        enhanced += " — Contactor K1 with 1-2 3-4 5-6 terminals and 13-14 auxiliary NO holding contact as in PNG power circuit"
    if "overload" in low or "tor" in low:
        enhanced += " — Thermal Overload Relay TOR with dial FLC and 95 NC 97 NO terminals as in PNG"
    if "motor" in low and "m " in low or "motor" in low:
        # avoid over
        if "motor m" in low or "motor" in low and "motor" not in enhanced.lower().split("—")[-1]:
            enhanced += " — Motor M 3~ with U V W terminals and PE earth as in PNG bottom"
    if "float" in low:
        enhanced += " — Float switch in water tank high/low levels as in PNG"
    if "pv" in low or "solar" in low:
        enhanced += " — PV Strings with DC combiner fuses and DC isolator WARNING label as in PNG"
    if "inverter" in low:
        enhanced += " — Inverter white box with MPPT display and Anti-islanding protection label as in PNG"
    if "ats" in low or "changeover" in low:
        enhanced += " — ATS / Changeover I-O-II 63A with Normal/Utility and Emergency/Generator labels, No Backfeed warning as in PNG"
    if "smart" in low and "switch" in low:
        enhanced += " — Smart switch with L, N, L1 terminals and WiFi/Zigbee icon as in PNG"
    if "ct" in low and "clamp" in low:
        enhanced += " — CT clamp split-core black around phase with white arrow → Load as in PNG"

    # Add PNG reference at end if not already
    if "png" not in enhanced.lower():
        enhanced += " [Refer to ultra-realistic PNG diagram for visual]."

    return enhanced

# Find all WiringDiagram blocks
# Pattern: WiringDiagram( id: 'xxx', ... steps: [ ... ], components: ...

# We'll iterate over file using regex for id and steps
# Use re.finditer for id

id_pattern = re.compile(r"id:\s*'(.*?)'")
steps_pattern = re.compile(r"steps:\s*\[(.*?)\],\s*components:", re.DOTALL)

# Build new content via scanning
# We'll replace steps blocks one by one using a function

def replace_steps(match):
    full_block = match.group(0)
    # Extract id from preceding context - we need to find id before this steps
    # We will have outer function to know id, so we need to handle differently
    return full_block

# Instead, process per diagram id location
# Find all ids and their positions
ids = [(m.group(1), m.start()) for m in re.finditer(r"id:\s*'(.*?)'", content)]
# Sort by position
ids_sorted = sorted(ids, key=lambda x: x[1])

new_content = content
# Process in reverse order to avoid messing offsets
for diag_id, pos in reversed(ids_sorted):
    # Find steps array after pos
    steps_start = new_content.find("steps:", pos)
    if steps_start == -1:
        continue
    # Find components start after steps
    comp_start = new_content.find("components:", steps_start)
    if comp_start == -1:
        continue
    # Find opening [ after steps:
    ob = new_content.find("[", steps_start)
    eb = new_content.rfind("]", ob, comp_start)
    if ob == -1 or eb == -1:
        continue
    steps_block_content = new_content[ob+1:eb]
    # Extract individual strings (single-quoted)
    # Each step is '...'
    # Use regex for single-quoted strings (handle escaped)
    step_strings = []
    # Split by pattern ', but careful
    # Find all '...' occurrences
    for sm in re.finditer(r"'((?:[^'\\]|\\.)*)'", steps_block_content):
        step_strings.append(sm.group(1))
    if not step_strings:
        continue
    # Enhance each
    # Get title for context (find title after id)
    title_match = re.search(r"title:\s*'(.*?)'", new_content[pos:pos+500])
    title = title_match.group(1) if title_match else diag_id

    enhanced_steps = [enhance_step(s, diag_id, title) for s in step_strings]

    # Rebuild block
    # Use single quotes, escape any single quote inside by replacing with \'
    rebuilt = "[\n      " + ",\n      ".join(["'" + s.replace("'", "\\'") + "'" for s in enhanced_steps]) + "\n    ]"
    # Replace in new_content
    new_content = new_content[:ob] + rebuilt + new_content[eb+1:]

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print(f"Enhanced all {len(ids_sorted)} diagrams steps to match PNG visuals")
