# Build Modernization Audit: TheWitnessPuzzlesReview

## Current Build Process (2026-05-06)

### Desktop (TWP Desktop)
- Project type: Legacy .csproj (ToolsVersion 12.0), targets .NET Framework 4.8
- Dependencies: MonoGame 3.6 (manual DLL reference), TWPBaseLib (project reference), TWP Shared (shared project import)
- Build: Visual Studio required, no working build.bat or CLI build
- Output: WinExe
- Manual steps: Must have MonoGame installed, correct DLL paths, Roboto font for content pipeline

### Android (TWP Android)
- Project type: Legacy Xamarin .csproj (ToolsVersion 4.0), targets Android API 25, .NET Framework 4.8
- Dependencies: MonoGame 3.6, Xamarin.Legacy.OpenTK (via packages.config), TWPBaseLib (project reference), TWP Shared (shared project import)
- Build: Visual Studio with Xamarin and Android NDK required, no CLI build
- Output: Android APK
- Manual steps: Must have correct NDK, Xamarin, MonoGame, Roboto font

### Shared Code (TWP Shared)
- Managed via .shproj/.projitems (legacy Visual Studio shared project system)
- Not compatible with SDK-style projects or .NET CLI

### Core Library (TWPBaseLib)
- Legacy .csproj, targets .NET Framework 4.8, MonoGame DLL reference via packages.config

### General Pain Points
- No cross-platform build (Windows-only, Visual Studio-only)
- No CI/CD, no automated build/test pipeline
- Manual dependency management (packages.config, explicit DLLs)
- No scripting for build, test, or packaging
- Documentation does not cover modern build workflows
- Platform-specific hacks (MonoGame install directory, Android NDK, font requirements)

## Blockers to Modernization
- Legacy project formats block .NET CLI and cross-platform builds
- Shared project system (.shproj/.projitems) not supported in SDK-style projects
- MonoGame 3.6 is old; may need upgrade for .NET 6+/MAUI compatibility
- Android project may require significant changes to migrate to MAUI or modern Xamarin

## Next Steps
- Propose migration to SDK-style projects for all targets
- Plan for .NET 6+/MonoGame for Desktop, .NET 6+/MAUI for Android
- Replace shared project system with shared library or multi-targeted project
- Set up CI/CD (GitHub Actions/Azure Pipelines)
- Write cross-platform build/test/package scripts
- Update documentation for new workflows

