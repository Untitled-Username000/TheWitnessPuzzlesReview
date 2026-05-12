---
title: TheWitnessPuzzles Build Modernization
modified: Plan creation by the Planner.
---

# APM Plan

## Workers

- build-modernizer (single Worker responsible for all tasks)

## Stages

### Stage 1: Build Script Creation
**Objective:** Create scripts to check prerequisites and build both Android and Desktop apps.

**Tasks:**
- Implement `check_tools.bat` to verify all required tools and dependencies (MSBuild, dotnet CLI, MonoGame, Android SDK/NDK, etc.).
- Implement `build.bat` to automate the build for both platforms, auto-detecting tools and reporting missing dependencies.
- Ensure scripts allow for manual path configuration and work in Codespaces if possible.

**Validation Criteria:**
- `check_tools.bat` reports all missing or misconfigured dependencies clearly.
- `build.bat` produces APK and EXE files with no manual intervention (beyond initial config).

### Stage 2: Build Verification and Refinement
**Objective:** Test, refine, and document the build process.

**Tasks:**
- Run scripts in a clean Windows environment and in Codespaces (if possible).
- Verify that APK and EXE outputs are produced as expected.
- Refine error messages and path handling for clarity and robustness.
- Update README with clear build instructions and troubleshooting tips.

**Validation Criteria:**
- Build process works on a clean Windows environment and, if possible, in Codespaces.
- Documentation is clear and accurate.

## Dependency Graph


### Stage 3: Cross-Platform Modernization & Automation
**Objective:** Migrate projects to SDK-style for dotnet CLI support and automate environment setup for maximum portability.

**Tasks:**
- Convert all projects to SDK-style (.csproj) if not already.
- Use dotnet CLI for all build and restore operations.
- Add a devcontainer.json and/or Dockerfile to automate setup of .NET SDK, Android SDK/NDK, and MGCB tool.
- Use dotnet global tools for MonoGame MGCB.
- Script Roboto font download or include in repo.
- Document the process in README for Codespaces, Linux, macOS, and Windows.

**Validation Criteria:**
- Project builds successfully with `dotnet build` on Windows, Linux, macOS, and Codespaces.
- All dependencies are installed or downloaded automatically via devcontainer or scripts.
- No manual install steps required beyond Docker/Codespaces or a single script.

**Notes:**
- See recommendations in .apm/memory/index.md for tool choices and automation.

Stage 3 depends on completion of Stage 2. No parallelization required.

---

> **Notes:**
> - Focus on minimizing install requirements and failure points.
> - Address current pain points with tool detection (Visual Studio, NuGet).
> - Leverage VS Code extensions if they simplify the process.

