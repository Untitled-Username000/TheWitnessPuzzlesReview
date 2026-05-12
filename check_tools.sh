#!/usr/bin/env bash
# check_tools.sh - Verifies required tools for TheWitnessPuzzles build (Android & Desktop)

set -e
MISSING=0

# --- Configurable paths (user may edit if auto-detect fails) ---
MONOGAME_PATH=""
ANDROID_SDK_PATH="${ANDROID_SDK_PATH:-$HOME/Android/Sdk}"
ANDROID_NDK_PATH="${ANDROID_NDK_PATH:-$ANDROID_SDK_PATH/ndk-bundle}"

# --- Helper: Check command existence ---
check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# --- Check MSBuild ---
if ! check_cmd msbuild; then
  echo "MSBuild missing"
  MISSING=1
fi

# --- Check dotnet CLI ---
if ! check_cmd dotnet; then
  echo "dotnet CLI missing"
  MISSING=1
fi

# --- Check MonoGame MGCB ---
if ! check_cmd mgcb; then
  echo "MonoGame MGCB missing"
  MISSING=1
fi

# --- Check Android SDK ---
if [ ! -d "$ANDROID_SDK_PATH" ]; then
  echo "Android SDK missing"
  MISSING=1
fi

# --- Check Android NDK ---
if [ ! -d "$ANDROID_NDK_PATH" ]; then
  echo "Android NDK missing"
  MISSING=1
fi

# --- Check NuGet ---
if ! check_cmd nuget; then
  echo "NuGet missing"
  MISSING=1
fi

# --- Check Roboto font (common Linux font paths) ---
if [ ! -f "/usr/share/fonts/truetype/roboto/Roboto-Regular.ttf" ] && [ ! -f "$HOME/.fonts/Roboto-Regular.ttf" ]; then
  echo "Roboto font missing"
  MISSING=1
fi

# --- Codespaces detection ---
if [ -n "$CODESPACES" ]; then
  echo "Codespaces detected. Attempting build checks..."
else
  echo "Not running in Codespaces. If using Codespaces, set CODESPACES=1."
fi

# --- Final result ---
if [ "$MISSING" -ne 0 ]; then
  echo "One or more required tools are missing or misconfigured."
  exit 1
else
  echo "All required tools found."
  exit 0
fi
