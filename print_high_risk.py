import re

content = open('lib/data/content/wiring_content.dart', 'r').read()
titles = re.findall(r"title:\s*'([^']+)'", content)

high_risk = []

high_risk_keywords = [
    'distribution board', 'db', 'rcd', 'rcbo', 'spd', 'surge',
    'generator', 'changeover', 'ats', 'transfer', 'star-delta',
    'reverse forward', 'overload', 'solar', 'grid-tie', 'hybrid',
    'battery', 'ev', 'smart breaker', 'contactor', 'vfd', 'soft starter',
    'ct wiring'
]

for title in titles:
    title_lower = title.lower()
    for keyword in high_risk_keywords:
        if keyword in title_lower:
            high_risk.append(title)
            break

for idx, t in enumerate(high_risk, 1):
    print(f"{idx}. {t}")
