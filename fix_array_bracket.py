with open('lib/data/content/wiring_content.dart', 'r') as f:
    content = f.read()

if not content.strip().endswith('];\n}'):
    content += "\n  ];\n}\n"

with open('lib/data/content/wiring_content.dart', 'w') as f:
    f.write(content)
