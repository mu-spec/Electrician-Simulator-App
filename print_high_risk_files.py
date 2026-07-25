import re

content = open('lib/data/content/wiring_content.dart', 'r').read()

# Pattern to extract id, svgPath, and title
pattern = r"WiringDiagram\(\s*id:\s*'([^']+)',\s*svgPath:\s*'([^']+)',\s*title:\s*'([^']+)'"
matches = re.findall(pattern, content)

high_risk_keywords = [
    'distribution board', 'db', 'rcd', 'rcbo', 'spd', 'surge',
    'generator', 'changeover', 'ats', 'transfer', 'star-delta',
    'reverse forward', 'overload', 'solar', 'grid-tie', 'hybrid',
    'battery', 'ev', 'smart breaker', 'contactor', 'vfd', 'soft starter',
    'ct wiring'
]

print("--- High-Risk Diagrams and their Image Files ---\n")
count = 1
for d_id, svgPath, title in matches:
    title_lower = title.lower()
    for keyword in high_risk_keywords:
        if keyword in title_lower:
            # Extract just the filename from 'assets/diagrams/dist_01.webp'
            filename = svgPath.split('/')[-1]
            print(f"{count}. {title}")
            print(f"   Image File: {filename}\n")
            count += 1
            break

