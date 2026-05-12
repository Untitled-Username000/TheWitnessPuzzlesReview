# Task Prompt: Cross-Platform Modernization & Automation

## Objective
Migrate all projects to SDK-style for dotnet CLI support and automate environment setup for maximum portability and ease of use.

## Requirements
- Convert all projects to SDK-style (.csproj) if not already.
- Use dotnet CLI for all build and restore operations.
- Add a devcontainer.json and/or Dockerfile to automate setup of .NET SDK, Android SDK/NDK, and MGCB tool.
- Use dotnet global tools for MonoGame MGCB (`dotnet tool install --global dotnet-mgcb`).
- Script Roboto font download or include it in the repo.
- Document the process in README for Codespaces, Linux, macOS, and Windows.

## Validation Criteria
- Project builds successfully with `dotnet build` on Windows, Linux, macOS, and Codespaces.
- All dependencies are installed or downloaded automatically via devcontainer or scripts.
- No manual install steps required beyond Docker/Codespaces or a single script.

## References
- See .apm/plan.md and .apm/spec.md for context and recommendations.
- See MonoGame, .NET, and Android SDK/NDK docs for migration and automation guidance.

## Output
- Updated project files (.csproj, solution, scripts, etc.)
- devcontainer.json and/or Dockerfile for Codespaces/CI
- Updated README with clear instructions
- Any scripts or automation for Roboto font/content

## Notes
- Prioritize simplicity, portability, and automation.
- If a step is not feasible, document the limitation and suggest alternatives.
