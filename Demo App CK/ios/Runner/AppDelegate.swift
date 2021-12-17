import UIKit
import Flutter
import VNPTSmartCAiOSSDK

@available(iOS 13.0, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  private var methodChannel: FlutterMethodChannel?
  private var methodChannelResult: FlutterMethodChannel?
  private var channelDeeplink = "com.vnpt.demo.PartnerSmartCA/VNPTSmartCAApp";
  private var channelResult = "com.vnpt.demo.PartnerSmartCA/Result";
  private var rawValueSmartCA = "<VNPTSmartCA>NotificationCenterReceived";
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: rawValueSmartCA), object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationCenterTokenReceived), name:NSNotification.Name(rawValue: rawValueSmartCA), object: nil)
      
      let controller = window.rootViewController as! FlutterViewController;
      
      methodChannelResult = FlutterMethodChannel(name: channelResult, binaryMessenger: controller as! FlutterBinaryMessenger);
      
      methodChannel = FlutterMethodChannel(name: channelDeeplink, binaryMessenger: controller as! FlutterBinaryMessenger);
      
      methodChannel!.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
          if (call.method == "OpenVNPTSmartCA") {
              var tranInfo: NSMutableDictionary = NSMutableDictionary();
              tranInfo = call.arguments as! NSMutableDictionary;
              
              VNPTSmartCATransaction.setEnvironment(_environment: VNPTSmartCATransaction.ENVIRONMENT.DEMO)
              VNPTSmartCATransaction.createTransactionInformation(info: tranInfo)
              VNPTSmartCATransaction.handleOpen();
          } else {
              result(FlutterMethodNotImplemented);
          }
      }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VNPTSmartCATransaction.receiveBackLink(url: url, sourceApp: sourceApplication!)
        return true
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        VNPTSmartCATransaction.receiveBackLink(url: url, sourceApp: "")
        return true
    }
    
    // You can listen return event from VNPTSmartCA app in here
    @objc func NotificationCenterTokenReceived(notify: NSNotification) {
        let response: NSMutableDictionary = notify.object! as! NSMutableDictionary
            
        let _statusStr = "\(response["status"] as! String)"
        let _message = response["message"]
        
        let param: NSMutableDictionary = NSMutableDictionary();
        param.setValue(_statusStr, forKey: "status");
        param.setValue(_message, forKey: "message");
        let jsonData = try! JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.withoutEscapingSlashes)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
    
        methodChannelResult!.invokeMethod("SendResultFromVNPTSmartCA", arguments: jsonString);
    }
}
