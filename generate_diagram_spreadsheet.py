import re
import csv

content = open('lib/data/content/wiring_content.dart', 'r').read()

# Pattern to extract id and title
pattern = r"WiringDiagram\([^)]*id:\s*'([^']+)'[^)]*title:\s*'([^']+)'"

matches = re.findall(pattern, content)

with open('DIAGRAM_REVIEW_RECORD.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow([
        'Diagram ID', 'Diagram title', 'Intended country or standard', 'Supply type',
        'Voltage and phase', 'Earthing arrangement', 'Source reference', 'Reviewer name',
        'Reviewer qualification', 'Review date', 'Revision number', 
        'Status: Draft, Reviewed, Approved or Rejected', 'Required corrections'
    ])
    
    for match in matches:
        d_id = match[0]
        d_title = match[1].replace("\\'", "'")
        writer.writerow([
            d_id, d_title, 'Generic/Global', 'AC', '230V/400V', '', '', '', '', '', '1.0', 'Draft', ''
        ])

print(f"Generated DIAGRAM_REVIEW_RECORD.csv with {len(matches)} rows.")
