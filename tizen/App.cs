using Tizen.Flutter.Embedding;

namespace Runner
{
    public class App : FlutterApplication
    {
        protected override void OnCreate()
        {
            base.OnCreate();

            GeneratedPluginRegistrant.RegisterPlugins(this);
        }

        static void Main(string[] args)
        {
            var app = new App();
            app.Run(args);
        }
    }
}
