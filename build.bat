@echo off
REM build.bat - Cross-platform build script for TheWitnessPuzzlesReview
REM Prerequisites: .NET 6 SDK or later, Android SDK (for Android build)

REM Build Desktop
cd /d "%~dp0TWP Desktop"
dotnet build TWP_Desktop.csproj -c Release || goto :error

REM Build Android
cd /d "%~dp0TWP Android"
dotnet build TWP_Android.csproj -c Release || goto :error

echo Build succeeded.
goto :eof

:error
echo Build failed.
exit /b 1

