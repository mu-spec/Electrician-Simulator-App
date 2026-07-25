import os

test_dir = 'test'
for filename in os.listdir(test_dir):
    if filename.endswith('.dart'):
        filepath = os.path.join(test_dir, filename)
        with open(filepath, 'r') as f:
            content = f.read()
        if 'voltmaster_pro' in content:
            print(f"Found voltmaster_pro in {filename}")
            new_content = content.replace('voltmaster_pro', 'electrician_simulator_app')
            with open(filepath, 'w') as f:
                f.write(new_content)
print("Done checking all tests")
