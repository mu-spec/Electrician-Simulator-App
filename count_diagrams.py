import re

content = open('lib/data/content/wiring_content.dart', 'r').read()
titles = re.findall(r"title:\s*'([^']+)'", content)

low_risk = []
high_risk = []

# List of high risk keywords based on ChatGPT's list
high_risk_keywords = [
    'distribution board', 'db', 'rcd', 'rcbo', 'spd', 'surge',
    'generator', 'changeover', 'ats', 'transfer', 'star-delta',
    'reverse forward', 'overload', 'solar', 'grid-tie', 'hybrid',
    'battery', 'ev', 'smart breaker', 'contactor', 'vfd', 'soft starter',
    'ct wiring'
]

for title in titles:
    title_lower = title.lower()
    is_high_risk = False
    for keyword in high_risk_keywords:
        if keyword in title_lower:
            is_high_risk = True
            break
            
    if is_high_risk:
        high_risk.append(title)
    else:
        low_risk.append(title)

print(f"Total Diagrams: {len(titles)}")
print(f"Low Risk (Keep): {len(low_risk)}")
print(f"High Risk (Hide): {len(high_risk)}")
print("\n--- Low Risk (Will remain in app) ---")
for t in low_risk: print(f"- {t}")
