using System;
using System.IO;
using System.Collections.Concurrent;

namespace TWP_Shared
{
    // Simple FileSystemWatcher wrapper. Enqueue file events, expose ProcessPending() to be called on game thread.
    public class HotReloadService : IDisposable
    {
        readonly FileSystemWatcher watcher;
        readonly ConcurrentQueue<string> queue = new ConcurrentQueue<string>();
        DateTime lastEvent = DateTime.MinValue;

        // Called on game thread from ProcessPending when an event passes debounce.
        public Action<string> OnFileChanged;

        public HotReloadService(string path)
        {
            if (string.IsNullOrEmpty(path) || !Directory.Exists(path))
                return;

            watcher = new FileSystemWatcher(path) { IncludeSubdirectories = true, EnableRaisingEvents = true };
            watcher.Changed += (s, e) => Enqueue(e.FullPath);
            watcher.Created += (s, e) => Enqueue(e.FullPath);
            watcher.Deleted += (s, e) => Enqueue(e.FullPath);
            watcher.Renamed += (s, e) => Enqueue(e.FullPath);
        }

        void Enqueue(string path) => queue.Enqueue(path);

        // Call from game's Update() on main thread.
        public void ProcessPending()
        {
            if (queue.IsEmpty) return;

            while (queue.TryDequeue(out var file))
            {
                // debounce burst of file events
                var now = DateTime.UtcNow;
                if ((now - lastEvent).TotalMilliseconds < 400)
                    continue;
                lastEvent = now;

                try { OnFileChanged?.Invoke(file); } catch { }
            }
        }

        public void Dispose()
        {
            try { watcher?.Dispose(); } catch { }
        }
    }
}
