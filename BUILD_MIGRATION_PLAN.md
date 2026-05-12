# Build Modernization Migration Plan: TheWitnessPuzzlesReview

## 1. Migrate to SDK-Style Projects
- Convert all .csproj files (Desktop, Android, TWPBaseLib, TWP Shared) to SDK-style format.
- Replace .shproj/.projitems shared project system with a shared library or multi-targeted SDK project.
- Remove packages.config; use PackageReference for NuGet dependencies.
- Upgrade MonoGame to latest version compatible with .NET 6+ (Desktop) and .NET 6+/MAUI (Android).

## 2. Desktop Target Modernization
- Change target framework to net6.0-windows or later.
- Update MonoGame references to use NuGet packages.
- Ensure build works with `dotnet build` on Windows (and optionally macOS/Linux).
- Test and validate all features.

## 3. Android Target Modernization
- Migrate from Xamarin.Android to .NET MAUI (if feasible) or latest Xamarin.Android SDK-style project.
- Update all Android assets, manifests, and dependencies.
- Ensure build works with `dotnet build` or `maui build`.
- Test on emulator/device.

## 4. Shared Code Modernization
- Move all shared code to a .NET Standard or multi-targeted SDK-style library.
- Reference shared library from both Desktop and Android projects.

## 5. CI/CD Pipeline Setup
- Set up GitHub Actions (default) for automated build/test/package on push/PR.
- Configure jobs for Desktop and Android targets.
- Publish build artifacts (EXE, APK) as workflow outputs.

## 6. Cross-Platform Scripting
- Add PowerShell Core or bash scripts for local build/test/package.
- Document usage in README.

## 7. Documentation
- Update README and add BUILDING.md with new build instructions, dependencies, and troubleshooting.

## 8. Verification
- Test builds on clean Windows, macOS, and Linux (for Desktop if supported).
- Test Android build on emulator/device.
- Confirm all features work as before.

---

## Notes
- If MAUI migration is not feasible for Android, fallback to latest Xamarin.Android SDK-style project.
- If MonoGame upgrade causes issues, document and address them as separate tasks.
- If any binary/platform-specific dependencies block migration, document and plan mitigation.

