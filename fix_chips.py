import re

with open('lib/presentation/screens/standards/pakistan_standards_screen.dart', 'r') as f:
    content = f.read()

old_chip = """                                        label: Text(
                                          LocalizedContent.text(context, tag),
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor: isDark
                                            ? const Color(0xFF334155)
                                            : const Color(0xFFF1F5F9),
                                        side: BorderSide.none,
                                      ),"""

new_chip = """                                        label: Text(
                                          LocalizedContent.text(context, tag),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: color,
                                          ),
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor: color.withOpacity(0.12),
                                        side: BorderSide.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                      ),"""

if old_chip in content:
    content = content.replace(old_chip, new_chip)
    with open('lib/presentation/screens/standards/pakistan_standards_screen.dart', 'w') as f:
        f.write(content)
    print("Success fixing chips")
else:
    print("Could not find the chip definition.")

