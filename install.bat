@echo off
REM install.bat - Prerequisite installer for TheWitnessPuzzlesReview
REM This script checks for .NET 6 SDK and basic Android SDK presence.

where dotnet >nul 2>nul
if errorlevel 1 (
    echo .NET SDK is not installed. Please install .NET 6 SDK or later from https://dotnet.microsoft.com/download
    exit /b 1
)

dotnet --list-sdks | findstr "6." >nul
if errorlevel 1 (
    echo .NET 6 SDK is not installed. Please install .NET 6 SDK or later from https://dotnet.microsoft.com/download
    exit /b 1
)

echo .NET 6 SDK found.

REM Check for Android SDK (basic check)
where adb >nul 2>nul
if errorlevel 1 (
    echo Android SDK not found in PATH. If you want to build Android, install Android Studio or add Android SDK tools to PATH.
    echo You can still build Desktop only.
) else (
    echo Android SDK found.
)

echo Prerequisites check complete.

