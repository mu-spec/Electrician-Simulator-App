import os
import gzip
import json

l10n_dir = 'assets/l10n'

if os.path.exists(l10n_dir):
    for filename in os.listdir(l10n_dir):
        if filename.endswith('.json.gz'):
            filepath = os.path.join(l10n_dir, filename)
            
            # Read and decompress
            with gzip.open(filepath, 'rt', encoding='utf-8') as f:
                data = json.load(f)
                
            changed = False
            # If termsOfUse or privacyPolicy keys exist, delete them
            keys_to_delete = ['termsOfUse', 'privacyPolicy', 'contactSupport']
            for k in keys_to_delete:
                if k in data:
                    del data[k]
                    changed = True
                    
            if changed:
                # Write and compress
                with gzip.open(filepath, 'wt', encoding='utf-8') as f:
                    json.dump(data, f, ensure_ascii=False)
                print(f"Removed dead keys from {filename}")
