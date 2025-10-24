import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  private var touchBarController: TouchBarController?
  
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    
    // Setup TouchBar after plugins are registered
    setupTouchBar(with: flutterViewController)

    super.awakeFromNib()
  }
  
  private func setupTouchBar(with controller: FlutterViewController) {
    // Create method channel for TouchBar communication
    let touchBarChannel = FlutterMethodChannel(
      name: "fladder.touchbar",
      binaryMessenger: controller.engine.binaryMessenger
    )
    
    // Setup TouchBar controller if available
    if #available(macOS 10.12.2, *) {
      touchBarController = TouchBarController(channel: touchBarChannel)
      
      // Handle method calls from Flutter
      touchBarChannel.setMethodCallHandler { [weak self] (call, result) in
        guard let strongSelf = self else {
          result(FlutterMethodNotImplemented)
          return
        }
        
        strongSelf.handleTouchBarMethodCall(call: call, result: result)
      }
    } else {
      // TouchBar not available on this macOS version
      touchBarChannel.setMethodCallHandler { (call, result) in
        result(FlutterError(code: "UNAVAILABLE", message: "TouchBar not supported on this macOS version", details: nil))
      }
    }
  }
  
  @available(macOS 10.12.2, *)
  private func handleTouchBarMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let touchBar = touchBarController else {
      result(FlutterError(code: "NOT_INITIALIZED", message: "TouchBar controller not initialized", details: nil))
      return
    }
    
    switch call.method {
    case "initialize":
      result(nil)
      
    case "updatePlaybackState":
      guard let args = call.arguments as? [String: Any],
            let isPlaying = args["isPlaying"] as? Bool,
            let position = args["position"] as? Double,
            let duration = args["duration"] as? Double,
            let title = args["title"] as? String,
            let hasQueue = args["hasQueue"] as? Bool else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for updatePlaybackState", details: nil))
        return
      }
      
      let logoUrl = args["logoUrl"] as? String ?? ""
      
      touchBar.updatePlaybackState(
        isPlaying: isPlaying,
        position: position,
        duration: duration,
        title: title,
        hasQueue: hasQueue,
        logoUrl: logoUrl
      )
      result(nil)
      
    case "updateProgress":
      guard let args = call.arguments as? [String: Any],
            let position = args["position"] as? Double,
            let duration = args["duration"] as? Double else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for updateProgress", details: nil))
        return
      }
      
      touchBar.updateProgress(position: position, duration: duration)
      result(nil)
      
    case "setVisible":
      guard let args = call.arguments as? [String: Any],
            let visible = args["visible"] as? Bool else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for setVisible", details: nil))
        return
      }
      
      touchBar.setVisible(visible)
      result(nil)
      
    case "clear":
      touchBar.clear()
      result(nil)
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
