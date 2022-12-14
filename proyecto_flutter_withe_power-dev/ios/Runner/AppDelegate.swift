import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  // Add this line before GeneratedPluginRegistrant
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController

    GeneratedPluginRegistrant.register(with: self)

    self.navigationController = UINavigationController(rootViewController: flutterViewController);
       self.navigationController?.setNavigationBarHidden(true, animated: false);

       self.window = UIWindow(frame: UIScreen.main.bounds);
       self.window.rootViewController = self.navigationController;
       self.window.makeKeyAndVisible();
       // End of edit

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
