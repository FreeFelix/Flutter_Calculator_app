#!/bin/bash

# Clone the Flutter Calculator App repository
git clone https://github.com/Pelino-Courses/flutter-simple-calculator-g-d-o-p-l.git

# Navigate to the project directory
cd calculator_app

# Install dependencies using Flutter
flutter pub get

# Build the Flutter app
flutter build apk

# Install the app on a connected device or emulator
flutter install

# Print a message indicating successful installation
echo "Flutter Calculator App has been successfully installed."

# Open the app on the connected device or emulator
flutter run
