import re

with open('test/calculation_engine_test.dart', 'r') as f:
    content = f.read()

content = content.replace("package:voltmaster_pro/data/calculators/calculation_engine.dart", "package:electrician_simulator_app/data/calculators/calculation_engine.dart")
content = content.replace("package:voltmaster_pro/data/repositories/app_repository.dart", "package:electrician_simulator_app/data/repositories/app_repository.dart")

with open('test/calculation_engine_test.dart', 'w') as f:
    f.write(content)

print("Fixed calculation engine test imports")
