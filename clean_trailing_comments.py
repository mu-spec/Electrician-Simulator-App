with open('lib/data/content/wiring_content.dart', 'r') as f:
    lines = f.readlines()

with open('lib/data/content/wiring_content.dart', 'w') as f:
    for line in lines:
        if line.strip() != '//' and not line.strip().startswith('// '):
            f.write(line)

print("Cleaned comments")
