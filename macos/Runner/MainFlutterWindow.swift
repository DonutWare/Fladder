import Cocoa
import FlutterMacOS
import desktop_multi_window
import macos_window_utils

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    MainFlutterWindowManipulator.start(mainFlutterWindow: self)

    RegisterGeneratedPlugins(registry: flutterViewController)
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      MainFlutterWindowManipulator.start(mainFlutterWindow: controller.view.window)
        // Register the plugin which you want access from other isolate.
        RegisterGeneratedPlugins(registry: controller)
    }
      

    super.awakeFromNib()
  }

  override func sendEvent(_ event: NSEvent) {
    if event.type == .leftMouseDown, event.clickCount == 2, !styleMask.contains(.fullScreen) {
      let titleBarHeight: CGFloat = 35
      if event.locationInWindow.y >= frame.height - titleBarHeight {
        switch UserDefaults.standard.string(forKey: "AppleActionOnDoubleClick") {
        case "Minimize":
          performMiniaturize(nil)
          return
        case "None":
          break
        default:
          performZoom(nil)
          return
        }
      }
    }
    super.sendEvent(event)
  }
}
