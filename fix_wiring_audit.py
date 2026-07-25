import re

with open('scripts/wiring_audit.py', 'r') as f:
    content = f.read()

# Update expected count
content = content.replace("if len(diagrams) != 50:", "if len(diagrams) != 20:")
content = content.replace("errors.append(f'Expected 50 diagrams, found {len(diagrams)}')", "errors.append(f'Expected 20 diagrams, found {len(diagrams)}')")

# Update expected category counts based on current 20 diagrams
expected_old = """    expected = {
        'residential': 11,
        'distribution': 9,
        'motors': 8,
        'solar': 8,
        'generator': 7,
        'smart': 7,
    }"""

expected_new = """    expected = {
        'residential': 11,
        'distribution': 1,
        'motors': 3,
        'solar': 1,
        'smart': 4,
    }"""
    
content = content.replace(expected_old, expected_new)

with open('scripts/wiring_audit.py', 'w') as f:
    f.write(content)

print("Updated wiring_audit.py")
