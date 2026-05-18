Short dev workflow for live-edit / hot-reload

- Fast run (auto rebuild on code + content change):

```powershell
cd "TWP Desktop"
dotnet watch run
```

- Notes:
  - `dotnet watch` triggers MSBuild. MonoGame content (.mgcb) will build to `TWP Shared/Content/bin/DesktopGL/Content` and be copied to `TWP Desktop/bin/.../Content`.
  - Ensure local `dotnet-mgcb` tool installed (`build.bat` already handles this).

- In-editor / one-button:
  - Add VS Code task to run `dotnet watch` or run from Terminal panel.

- Runtime hot-reload (in-game):
  - `HotReloadService` watches built Content folder and enqueues change events.
  - On change, `ScreenManager.ReloadContent()` called, and `SoundManager.LoadContent(Content)` retriggered.
  - Reload runs on game thread (safe for GraphicsDevice). May cause short frame hitch.

- Asset editing tips:
  - For quick texture swaps, prefer `Texture2D.FromStream(GraphicsDevice, File.OpenRead(path))` and swap dictionary entry to avoid `Content.Unload()`.
  - For content pipeline edits (.spritefont/.fx/.png), save, let `dotnet watch` rebuild mgcb, then game will reload.

- Caveats:
  - Reload replaces providers; any existing references to old Texture2D/SpriteFont become invalid.
  - Sound reloading recreates `SoundEffect` instances; loops will restart.

- Troubleshooting:
  - If assets not rebuilding, run `dotnet tool restore` in `TWP Desktop` to ensure `dotnet-mgcb` present.
  - If `dotnet watch` doesn't pick up content edits, confirm `TWP_Desktop.csproj` contains `<Watch Include="..\TWP Shared\Content\**\*.*" />`.
  - If Android build fails with `XA5300`, set `ANDROID_SDK_ROOT` to SDK folder. For this repo, `build.bat` falls back to `D:\AndroidStudioSDK`.
  - `build.bat` passes `-p:AndroidSdkDirectory=...` from `ANDROID_SDK_ROOT`, `ANDROID_HOME`, `D:\AndroidStudioSDK`, or `%LOCALAPPDATA%\Android\Sdk`.

That's it. Edit assets, watch rebuild, game reloads.
