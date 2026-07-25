import re

with open('lib/presentation/screens/onboarding_screen.dart', 'r') as f:
    content = f.read()

# We need to change the Padding around the image to allow it to expand more (zoom in)
# Currently it is: padding: const EdgeInsets.all(24.0),
# We will reduce it to 0 so the image takes up as much space as possible.
# Also, we can change BoxFit.contain to BoxFit.fitWidth or adjust padding to zoom.
# A safe zoom without cutting off top/bottom is to just reduce the extreme padding 
# and let BoxFit.contain do its job with the new extra space.

old_image_block = """                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Image.asset(
                        _images[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );"""

new_image_block = """                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                    child: Center(
                      child: Image.asset(
                        _images[index],
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  );"""

if old_image_block in content:
    content = content.replace(old_image_block, new_image_block)
    with open('lib/presentation/screens/onboarding_screen.dart', 'w') as f:
        f.write(content)
    print("Success zooming image")
else:
    print("Could not find image block")

