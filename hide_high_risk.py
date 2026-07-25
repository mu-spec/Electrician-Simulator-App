import re

content = open('lib/data/content/wiring_content.dart', 'r').read()

high_risk_keywords = [
    'distribution board', 'db', 'rcd', 'rcbo', 'spd', 'surge',
    'generator', 'changeover', 'ats', 'transfer', 'star-delta',
    'reverse forward', 'overload', 'solar', 'grid-tie', 'hybrid',
    'battery', 'ev', 'smart breaker', 'contactor', 'vfd', 'soft starter',
    'ct wiring'
]

# We need to find each WiringDiagram() block. 
# We'll split the content into the categories array and the diagrams array.
parts = content.split('static const List<WiringDiagram> wiringDiagrams = [')
header = parts[0]
diagrams_part = parts[1]

# Find individual WiringDiagram blocks
# A block starts with "    WiringDiagram(" and ends with "    ),"
blocks = re.split(r'(?=\s*WiringDiagram\()', diagrams_part)

new_diagrams_part = ""

for block in blocks:
    if not block.strip():
        new_diagrams_part += block
        continue
        
    # Extract the title
    title_match = re.search(r"title:\s*'([^']+)'", block)
    if title_match:
        title = title_match.group(1).lower()
        is_high_risk = any(kw in title for keyword in high_risk_keywords for kw in [keyword])
        
        if is_high_risk:
            # Comment out the entire block
            commented_block = ""
            for line in block.split('\n'):
                if line.strip() == '':
                    commented_block += "\n"
                else:
                    commented_block += f"// {line}\n"
            new_diagrams_part += commented_block
        else:
            new_diagrams_part += block
    else:
        new_diagrams_part += block

with open('lib/data/content/wiring_content.dart', 'w') as f:
    f.write(header + 'static const List<WiringDiagram> wiringDiagrams = [' + new_diagrams_part)

print("Hidden high risk diagrams")
