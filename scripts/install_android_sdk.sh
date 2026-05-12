#!/usr/bin/env bash
set -e

echo "Downloading Android Command Line Tools..."
mkdir -p $HOME/android-sdk/cmdline-tools
wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip

echo "Extracting tools..."
unzip -q cmdline-tools.zip -d $HOME/android-sdk/cmdline-tools
rm cmdline-tools.zip

# The cmdline tools need to be inside a folder named 'latest'
mv $HOME/android-sdk/cmdline-tools/cmdline-tools $HOME/android-sdk/cmdline-tools/latest

export ANDROID_HOME=$HOME/android-sdk
export ANDROID_SDK_ROOT=$HOME/android-sdk

echo "Accepting licenses and installing required SDK components..."
yes | $HOME/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses >/dev/null
$HOME/android-sdk/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

echo "Done! The Android SDK is now installed at: $ANDROID_HOME"
echo "To build your project, use:"
echo "export ANDROID_HOME=\$HOME/android-sdk"
echo "dotnet build"
