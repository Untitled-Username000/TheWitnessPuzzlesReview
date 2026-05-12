# APM Task Breakdown: Build Modernization

## Stage 1: SDK-Style Migration
- Task 1.1: Convert TWPBaseLib to SDK-style .csproj targeting netstandard2.1 or net6.0
- Task 1.2: Convert TWP Shared to SDK-style .csproj (multi-targeted if needed)
- Task 1.3: Remove .shproj/.projitems and migrate all shared code to the new shared library
- Task 1.4: Update all project references to use the new shared library
- Task 1.5: Remove packages.config and use PackageReference for dependencies

## Stage 2: Desktop Modernization
- Task 2.1: Convert TWP Desktop to SDK-style .csproj targeting net6.0-windows
- Task 2.2: Upgrade MonoGame to latest NuGet version compatible with .NET 6+
- Task 2.3: Update references to shared/core libraries
- Task 2.4: Ensure build works with `dotnet build` and validate features

## Stage 3: Android Modernization
- Task 3.1: Attempt migration to .NET MAUI (if feasible) or latest Xamarin.Android SDK-style project
- Task 3.2: Update Android assets, manifests, and dependencies
- Task 3.3: Update references to shared/core libraries
- Task 3.4: Ensure build works with `dotnet build` or `maui build` and validate on emulator/device

## Stage 4: CI/CD Pipeline
- Task 4.1: Set up GitHub Actions for automated build/test/package on push/PR
- Task 4.2: Configure jobs for Desktop and Android targets
- Task 4.3: Publish build artifacts (EXE, APK) as workflow outputs

## Stage 5: Cross-Platform Scripting
- Task 5.1: Add PowerShell Core or bash scripts for local build/test/package
- Task 5.2: Document usage in README

## Stage 6: Documentation & Verification
- Task 6.1: Update README and add BUILDING.md with new build instructions
- Task 6.2: Test builds on clean Windows, macOS, Linux (Desktop)
- Task 6.3: Test Android build on emulator/device
- Task 6.4: Confirm all features work as before

---

Each task should be tracked and executed in order, with verification at each stage. Blockers or issues should be documented and addressed before proceeding to dependent tasks.

