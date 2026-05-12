@echo off
REM check_tools.bat - Verifies required tools for TheWitnessPuzzles build (Android & Desktop)

REM --- Configurable paths (user may edit if auto-detect fails) ---
set "MONOGAME_PATH="
set "ANDROID_SDK_PATH="
set "ANDROID_NDK_PATH="

REM --- Helper: Check command existence ---
where %1 >nul 2>nul
if %errorlevel%==0 exit /b 0
exit /b 1

REM --- Check MSBuild ---
where msbuild >nul 2>nul
if %errorlevel% neq 0 (
  echo MSBuild missing
  set "MISSING=1"
)

REM --- Check dotnet CLI ---
where dotnet >nul 2>nul
if %errorlevel% neq 0 (
  echo dotnet CLI missing
  set "MISSING=1"
)

REM --- Check MonoGame ---
where mgcb >nul 2>nul
if %errorlevel% neq 0 (
  echo MonoGame MGCB missing
  set "MISSING=1"
)

REM --- Check Android SDK ---
if not defined ANDROID_SDK_PATH set "ANDROID_SDK_PATH=%LOCALAPPDATA%\Android\Sdk"
if not exist "%ANDROID_SDK_PATH%" (
  echo Android SDK missing
  set "MISSING=1"
)

REM --- Check Android NDK ---
if not defined ANDROID_NDK_PATH set "ANDROID_NDK_PATH=%ANDROID_SDK_PATH%\ndk-bundle"
if not exist "%ANDROID_NDK_PATH%" (
  echo Android NDK missing
  set "MISSING=1"
)

REM --- Check NuGet ---
where nuget >nul 2>nul
if %errorlevel% neq 0 (
  echo NuGet missing
  set "MISSING=1"
)

REM --- Check Roboto font (Windows Fonts folder) ---
if not exist "%SystemRoot%\Fonts\Roboto-Regular.ttf" (
  echo Roboto font missing
  set "MISSING=1"
)

REM --- Codespaces detection ---
if defined CODESPACES (
  echo Codespaces detected. Attempting build checks...
) else (
  echo Not running in Codespaces. If using Codespaces, set CODESPACES=1.
)

REM --- Final result ---
if defined MISSING (
  echo One or more required tools are missing or misconfigured.
  exit /b 1
) else (
  echo All required tools found.
  exit /b 0
)
