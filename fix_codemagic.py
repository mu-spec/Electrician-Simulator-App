with open('codemagic.yaml', 'r') as f:
    content = f.read()

content = content.replace('if [ -f assets/images/app_icon.png ]; then echo "ERROR: app_icon.png still exists (1.4MB waste)"; exit 1; fi\n', '')
content = content.replace('echo "Should be only app_icon.webp (48KB) for optimal size"\n', 'echo "Should contain app_icon.png and tutorial_*.png"\n')

with open('codemagic.yaml', 'w') as f:
    f.write(content)
print("Updated codemagic.yaml")
