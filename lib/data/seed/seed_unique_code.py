import json
import random

def generate_unique_codes(existing_codes, num_codes):
    new_codes = set()
    while len(new_codes) < num_codes:
        code = str(random.randint(10000, 99999))
        if code not in existing_codes and code not in new_codes:
            new_codes.add(code)
    return list(new_codes)

# Load the JSON data
with open('brgy.json', 'r') as file:
    data = json.load(file)

# Initialize the existing_codes list outside of the barangay loop
existing_codes = []

# Iterate through the data and assign unique codes to barangays
for province, province_data in data.items():
    for municipality, municipality_data in province_data['municipality_list'].items():
        for barangay in municipality_data['barangay_list']:
            code = generate_unique_codes(existing_codes, 1)[0]
            barangay['code'] = code
            existing_codes.append(code)

# Save the modified data back to the JSON file
with open('modified_file.json', 'w') as file:
    json.dump(data, file, indent=4)

print("Unique codes assigned and saved to 'modified_file.json'")
