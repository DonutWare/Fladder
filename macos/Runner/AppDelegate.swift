import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    override func applicationDidFinishLaunching(_ notification: Notification) {
        let controller = mainFlutterWindow?.contentViewController as! FlutterViewController
        
        DirectoryBookmarkSetup.setUp(
            binaryMessenger: controller.engine.binaryMessenger,
            api: DirectoryBookmarkImplementation()
        )
        
        super.applicationDidFinishLaunching(notification)
    }
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
