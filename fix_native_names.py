import re

# Fix Android
with open('android/app/src/main/AndroidManifest.xml', 'r') as f:
    android_content = f.read()
android_content = android_content.replace('android:label="VoltMaster Pro"', 'android:label="Electrician Simulator App"')
with open('android/app/src/main/AndroidManifest.xml', 'w') as f:
    f.write(android_content)

# Fix iOS
with open('ios/Runner/Info.plist', 'r') as f:
    ios_content = f.read()
ios_content = ios_content.replace('<string>Voltmaster Pro</string>', '<string>Electrician Simulator App</string>')
ios_content = ios_content.replace('<string>voltmaster_pro</string>', '<string>electrician_simulator_app</string>')
with open('ios/Runner/Info.plist', 'w') as f:
    f.write(ios_content)

print("Updated native app labels")
