import os
import re
import gzip
import json

# 1. Update UI files
files_to_update = [
    'lib/core/localization/app_localizations.dart',
    'lib/core/localization/ui_text.dart',
    'lib/presentation/screens/projects/invoice_generator_screen.dart',
    'lib/presentation/screens/projects/project_detail_screen.dart',
    'lib/presentation/screens/settings/feedback_screen.dart',
]

for file in files_to_update:
    if os.path.exists(file):
        with open(file, 'r') as f:
            content = f.read()
        new_content = content.replace('VoltMaster Pro', 'Electrician Simulator App')
        new_content = new_content.replace('VoltMaster', 'Electrician Simulator App')
        with open(file, 'w') as f:
            f.write(new_content)
        print(f"Updated {file}")

# 2. Update all translated values in l10n gzipped JSON catalogs
l10n_dir = 'assets/l10n'
if os.path.exists(l10n_dir):
    for filename in os.listdir(l10n_dir):
        if filename.endswith('.json.gz'):
            filepath = os.path.join(l10n_dir, filename)
            
            with gzip.open(filepath, 'rt', encoding='utf-8') as f:
                data = json.load(f)
                
            changed = False
            for key, value in data.items():
                if isinstance(value, str) and ('VoltMaster Pro' in value or 'VoltMaster' in value or 'فولت ماستر برو' in value or 'вольтмастер' in value.lower() or 'वोलटमास्टर' in value or 'ਵੋਲਟਮਾਸਟਰ' in value):
                    
                    # Force overwrite the 'appTitle' key directly to ensure no lingering translations of the old name
                    if key == 'appTitle':
                        data[key] = 'Electrician Simulator App'
                        changed = True
                    else:
                        # For body texts (like feedback, sharing links, etc)
                        new_val = value.replace('VoltMaster Pro', 'Electrician Simulator App').replace('VoltMaster', 'Electrician Simulator App')
                        if new_val != value:
                            data[key] = new_val
                            changed = True
                            
            if changed:
                with gzip.open(filepath, 'wt', encoding='utf-8') as f:
                    json.dump(data, f, ensure_ascii=False)
                print(f"Updated {filename}")

