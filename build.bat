@echo off
setlocal enabledelayedexpansion

echo ============================================================
echo  The Witness Puzzles - Build Script
echo ============================================================
echo.

:: ── 1. Locate MSBuild via vswhere ──────────────────────────────────────────
:: Capture %ProgramFiles(x86)% early - parentheses in the name break if/for parsing
set "PF86=%ProgramFiles(x86)%"

:: Check known locations in order of preference
set "VSWHERE=D:\Programs\vsbuildtools\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%PF86%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe"

if not exist "%VSWHERE%" (
    echo [ERROR] vswhere.exe not found. Checked:
    echo   D:\Programs\vsbuildtools\vswhere.exe
    echo   C:\Program Files ^(x86^)\Microsoft Visual Studio\Installer\vswhere.exe
    echo   %PF86%\Microsoft Visual Studio\Installer\vswhere.exe
    echo   %ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe
    echo Please install Visual Studio Build Tools 2017 or later.
    goto :fail
)

for /f "usebackq tokens=*" %%i in (
    `"%VSWHERE%" -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`
) do set "MSBUILD=%%i"

if not defined MSBUILD (
    echo [ERROR] MSBuild not found. Make sure Visual Studio is installed with the ".NET desktop build tools" workload.
    goto :fail
)
echo [OK] MSBuild: %MSBUILD%

:: ── 2. Locate or download nuget.exe ────────────────────────────────────────
set "NUGET="

:: Check if nuget is already on PATH
where nuget >nul 2>&1
if %errorlevel%==0 (
    set "NUGET=nuget"
    echo [OK] nuget found on PATH.
    goto :restore
)

:: Check for nuget.exe next to this script
if exist "%~dp0nuget.exe" (
    set "NUGET=%~dp0nuget.exe"
    echo [OK] nuget.exe found next to build.bat.
    goto :restore
)

:: Download nuget.exe
echo [INFO] nuget.exe not found - downloading from nuget.org...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile '%~dp0nuget.exe'"
if %errorlevel% neq 0 (
    echo [ERROR] Failed to download nuget.exe. Check your internet connection.
    goto :fail
)
set "NUGET=%~dp0nuget.exe"
echo [OK] nuget.exe downloaded.

:: ── 3. Restore NuGet packages ───────────────────────────────────────────────
:restore
echo.
echo [INFO] Restoring NuGet packages...
"%NUGET%" restore "%~dp0TheWitnessPuzzles.sln"
if %errorlevel% neq 0 (
    echo [ERROR] NuGet restore failed.
    goto :fail
)
echo [OK] NuGet restore complete.

:: ── 4. Build TWP Desktop (Release, x86) ─────────────────────────────────────
echo.
echo [INFO] Building TWP Desktop (Release^|x86)...
"%MSBUILD%" "%~dp0TWP Desktop\TWP Desktop.csproj" ^
    /p:Configuration=Release ^
    /p:Platform=x86 ^
    /verbosity:minimal ^
    /nologo
if %errorlevel% neq 0 (
    echo [ERROR] TWP Desktop build failed.
    goto :fail
)
echo [OK] TWP Desktop build succeeded.

:: ── 5. Build TWPVisualizer (Release, AnyCPU) ─────────────────────────────────
echo.
echo [INFO] Building TWPVisualizer (Release^|AnyCPU)...
"%MSBUILD%" "%~dp0TWPVisualizer\TWPVisualizer.csproj" ^
    /p:Configuration=Release ^
    /p:Platform=AnyCPU ^
    /verbosity:minimal ^
    /nologo
if %errorlevel% neq 0 (
    echo [ERROR] TWPVisualizer build failed.
    goto :fail
)
echo [OK] TWPVisualizer build succeeded.

:: ── Done ─────────────────────────────────────────────────────────────────────
echo.
echo ============================================================
echo  Build complete!
echo   TWP Desktop  -> TWP Desktop\bin\Windows\x86\Release\
echo   TWPVisualizer -> TWPVisualizer\bin\Release\
echo ============================================================
goto :eof

:fail
echo.
echo ============================================================
echo  Build FAILED. See errors above.
echo ============================================================
exit /b 1
