import re

with open('lib/data/content/wiring_content.dart', 'r') as f:
    content = f.read()

# Instead of commenting them out, we will simply remove all lines starting with "//" 
# that are inside the wiringDiagrams list. Wait, there might be other legitimate comments.
# A better way is to restore the original file and then just delete the blocks entirely.

import subprocess
subprocess.run(['git', 'checkout', '--', 'lib/data/content/wiring_content.dart'])

content = open('lib/data/content/wiring_content.dart', 'r').read()

high_risk_keywords = [
    'distribution board', 'db', 'rcd', 'rcbo', 'spd', 'surge',
    'generator', 'changeover', 'ats', 'transfer', 'star-delta',
    'reverse forward', 'overload', 'solar', 'grid-tie', 'hybrid',
    'battery', 'ev', 'smart breaker', 'contactor', 'vfd', 'soft starter',
    'ct wiring'
]

parts = content.split('static const List<WiringDiagram> wiringDiagrams = [')
header = parts[0]
diagrams_part = parts[1]

blocks = re.split(r'(?=\s*WiringDiagram\()', diagrams_part)

new_diagrams_part = ""

for block in blocks:
    if not block.strip():
        new_diagrams_part += block
        continue
        
    title_match = re.search(r"title:\s*'([^']+)'", block)
    if title_match:
        title = title_match.group(1).lower()
        is_high_risk = any(kw in title for keyword in high_risk_keywords for kw in [keyword])
        
        if is_high_risk:
            # Drop it completely
            pass
        else:
            new_diagrams_part += block
    else:
        new_diagrams_part += block

with open('lib/data/content/wiring_content.dart', 'w') as f:
    f.write(header + 'static const List<WiringDiagram> wiringDiagrams = [' + new_diagrams_part)

print("Removed high risk diagrams completely")
