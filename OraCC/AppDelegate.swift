import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let provider = StubOraProvider
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let sVC = window?.rootViewController as? SplashViewController {
            sVC.provider = provider
        }
        
        return true
    }
}

