@echo off
REM build.bat - Cross-platform build script for TheWitnessPuzzlesReview
REM Prerequisites: .NET 6 SDK or later, Android SDK (for Android build)

REM Build Desktop
REM Ensure MonoGame content tool installed for project build (local tool in project folder)
if not exist "%~dp0TWP Desktop\.config\dotnet-tools.json" (
	pushd "%~dp0TWP Desktop"
	dotnet new tool-manifest --force
	dotnet tool install dotnet-mgcb --version 3.8.1.303
	popd
) else (
	pushd "%~dp0TWP Desktop"
	dotnet tool restore
	popd
)

cd /d "%~dp0TWP Desktop"
dotnet build TWP_Desktop.csproj -c Release || goto :error

REM Build Android
cd /d "%~dp0TWP Android"
set "ANDROID_SDK_DIRECTORY=%ANDROID_SDK_ROOT%"
if not defined ANDROID_SDK_DIRECTORY set "ANDROID_SDK_DIRECTORY=%ANDROID_HOME%"
if not defined ANDROID_SDK_DIRECTORY if exist "D:\AndroidStudioSDK" set "ANDROID_SDK_DIRECTORY=D:\AndroidStudioSDK"
if not defined ANDROID_SDK_DIRECTORY if exist "%LOCALAPPDATA%\Android\Sdk" set "ANDROID_SDK_DIRECTORY=%LOCALAPPDATA%\Android\Sdk"
if not defined ANDROID_SDK_DIRECTORY (
	echo Android SDK not found. Set ANDROID_SDK_ROOT to your SDK folder.
	goto :error
)
dotnet build TWP_Android.csproj -c Release -p:AndroidSdkDirectory="%ANDROID_SDK_DIRECTORY%" || goto :error

echo Build succeeded.
goto :eof

:error
echo Build failed.
exit /b 1

