import UIKit
import Flutter
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self

    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
      granted, error in
      if granted {
        print("Notification permission granted for debug handler")
      } else if let error = error {
        print("Error requesting notification permission: \(error)")
      }
    }

    WorkmanagerDebug.setCurrent(NotificationDebugHandler())

    WorkmanagerPlugin.registerBGProcessingTask(
      withIdentifier: "nl.jknaapen.fladder.update_notifications_check_debug")
    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: "nl.jknaapen.fladder.update_notifications_check",
      frequency: NSNumber(value: 20 * 60))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Shows a notification for background tasks when the app is in the foreground
  // override func userNotificationCenter(
  //   _ center: UNUserNotificationCenter,
  //   willPresent notification: UNNotification,
  //   withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  // ) {
  //   completionHandler(.alert) 
  // }
}
