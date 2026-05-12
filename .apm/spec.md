---
title: TheWitnessPuzzles Build Modernization
modified: Spec creation by the Planner.
---

# APM Spec

## Overview

This project aims to modernize and simplify the build process for TheWitnessPuzzles, enabling fast, reliable, and easy builds for both Android and Desktop platforms. The new system will use a single `build.bat` script for building both targets and a `check_tools.bat` script to verify prerequisites. The process will auto-detect required tools and dependencies, reporting missing items clearly without attempting installation. Output artifacts will be an APK for Android and an EXE for Desktop, using current default locations. The process will be Windows-focused but should ideally work in GitHub Codespaces or allow manual path configuration. Simplicity, speed, and self-containment are top priorities.

## Workspace

- Repository: TheWitnessPuzzles
- Platforms: Android, Desktop (Windows)
- Main solution: Multiple C# projects (Android, Desktop, Shared, Core Library)
- Authoritative requirements: README.md
- No AGENTS.md or additional agent configuration

---

> **Notes:**
> - Prioritize clear error reporting for missing tools or misconfigurations.
> - Address current pain points with tool detection (Visual Studio, NuGet).
> - Leverage VS Code extensions (e.g., MonoGame integration) if beneficial.
> - No legacy build steps need to be preserved; rewrite for clarity and ease of use.

