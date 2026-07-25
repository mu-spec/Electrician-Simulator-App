import re

with open('lib/data/content/wiring_content.dart', 'r') as f:
    content = f.read()

# Add 'Conceptual Illustration' to the start of tags list if tags are present
new_content = re.sub(r'tags:\s*\[', "tags: ['Educational Concept', ", content)

with open('lib/data/content/wiring_content.dart', 'w') as f:
    f.write(new_content)

print("Added tags")
