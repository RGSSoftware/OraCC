import UIKit
import UIColor_Hex_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let provider = OraProvider
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let sVC = window?.rootViewController as? SplashViewController {
            sVC.provider = provider
        }
        
        OraBrand.mainColor = UIColor("#F6AF3F")
                
        UITabBar.appearance().tintColor = OraBrand.mainColor
        UINavigationBar.appearance().tintColor = OraBrand.mainColor
        
        return true
    }
}

