import UIKit
import Flutter

var sharedText:String = "";
var host:String = "mess.iitr.ac.in";
var path:String = "/oauth/";

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "app.channel.shared.data",
                                              binaryMessenger: controller)
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
        if (call.method == "getCode"){
            result(sharedText);
            sharedText = "";
        }
        else {
        result(FlutterMethodNotImplemented)
        return
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    @available(iOS 9.0, *)
    override func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        // Determine who sent the URL.
        //let sendingAppID = options[.sourceApplication]
        //print("source application = \(sendingAppID ?? "Unknown")")
        
        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let _ = components.path,
            let _ = components.queryItems else {
                print("Invalid URL or album path missing")
                return false
        }
        if(components.host == host && components.path == path) {
            sharedText = getQueryStringParameter(url:url.absoluteString,param:"code") ?? ""
        }
        return true;
    }
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
