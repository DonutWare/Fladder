import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    var appMenuApi: ApplicationMenu?
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
        raiseOpenFileLimit()

        let controller = mainFlutterWindow?.contentViewController as! FlutterViewController
        
        DirectoryBookmarkSetup.setUp(
            binaryMessenger: controller.engine.binaryMessenger,
            api: DirectoryBookmarkImplementation()
        )
        
        self.appMenuApi = ApplicationMenu(binaryMessenger: controller.engine.binaryMessenger)
        
        super.applicationDidFinishLaunching(notification)
    }
    
    override func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let dockMenu = NSMenu(title: "App Menu")

        let newWindowItem = NSMenuItem(
            title: "New Window",
            action: #selector(handleNewWindowAction(_:)),
            keyEquivalent: "n"
        )
        dockMenu.addItem(newWindowItem)

        let newInstanceItem = NSMenuItem(
            title: "New Instance",
            action: #selector(handleNewInstanceAction(_:)),
            keyEquivalent: "n"
        )
        dockMenu.addItem(newInstanceItem)
        
        return dockMenu
    }
    
    // 4. Implement the action function
    @objc func handleNewWindowAction(_ sender: NSMenuItem) {
        self.appMenuApi?.openNewWindow(completion: {_ in print("New window opened")})
    }

    @objc func handleNewInstanceAction(_ sender: NSMenuItem) {
        self.appMenuApi?.newInstance(completion: {_ in print("New instance opened")})
    }
    
    // All windows (desktop_multi_window) share this process, open files is quickly exhausted by image cache reads, sockets and databases across engines.
    private func raiseOpenFileLimit() {
        var limit = rlimit()
        guard getrlimit(RLIMIT_NOFILE, &limit) == 0 else { return }
        let target = min(limit.rlim_max, rlim_t(OPEN_MAX))
        guard limit.rlim_cur < target else { return }
        limit.rlim_cur = target
        if setrlimit(RLIMIT_NOFILE, &limit) != 0 {
            print("Failed to raise open file limit: \(String(cString: strerror(errno)))")
        } 
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
