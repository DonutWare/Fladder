import Cocoa
import FlutterMacOS
import desktop_multi_window
import macos_window_utils

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    _ = BackBufferCacheSizeGuard.install
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

// Impeller crashes when the engine's back buffer cache returns a surface of the wrong size.
// Remove once flutter/flutter#192522 is in stable (https://github.com/flutter/flutter/issues/185394).
private enum BackBufferCacheSizeGuard {
  static let install: Void = {
    guard let cls = NSClassFromString("FlutterBackBufferCache"),
          let original = class_getInstanceMethod(cls, NSSelectorFromString("removeSurfaceForSize:")),
          let replacement = class_getInstanceMethod(NSObject.self, #selector(NSObject.fladder_removeSurface(forSize:))),
          class_addMethod(cls, method_getName(replacement), method_getImplementation(replacement), method_getTypeEncoding(replacement)),
          let added = class_getInstanceMethod(cls, method_getName(replacement))
    else { return }
    method_exchangeImplementations(original, added)
  }()
}

extension NSObject {
  @objc(fladder_removeSurfaceForSize:)
  fileprivate dynamic func fladder_removeSurface(forSize size: CGSize) -> NSObject? {
    guard let surface = fladder_removeSurface(forSize: size) else { return nil }
    return (surface.value(forKey: "size") as? NSValue)?.sizeValue == size ? surface : nil
  }
}
