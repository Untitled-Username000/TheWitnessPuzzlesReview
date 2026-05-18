using System;
using System.Windows.Forms;
using TWP_Shared;

namespace TWP_Desktop
{
#if WINDOWS || LINUX
    /// <summary>
    /// The main class.
    /// </summary>
    public static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            try
            {
                using (var game = new TWPGame())
                    game.Run();
            }
            catch (Exception ex)
            {
#if WINDOWS
                MessageBox.Show(ex.ToString(), "The Witness Puzzles failed to start", MessageBoxButtons.OK, MessageBoxIcon.Error);
#endif
            }
        }
    }
#endif
}
