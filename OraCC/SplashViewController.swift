import UIKit
import Moya

class SplashViewController: UIViewController {
    
    var provider: RxMoyaProvider<OraAPI>!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = AuthenticationToken.token {
            performSegue(withIdentifier: R.segue.splashViewController.from_Splash_to_Main, sender: nil)
        } else {
            performSegue(withIdentifier: R.segue.splashViewController.from_Splash_to_Login, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.splashViewController.from_Splash_to_Login.identifier {
            
            if segue.destination is UINavigationController {
                let nVC = segue.destination as! UINavigationController
                let lVC = nVC.topViewController as! LoginViewController
                lVC.provider = provider
            }
        }
        
        if segue.identifier == R.segue.splashViewController.from_Splash_to_Main.identifier {
            
            if let tVC = segue.destination as? UITabBarController {
                
                if let nVC = tVC.viewControllers?[0] as? UINavigationController {
                    if let cVC = nVC.topViewController as? ChatsViewController {
                        cVC.provider = provider
                    }
                }
                
                if let nVC = tVC.viewControllers?[1] as? UINavigationController {
                    if let aVC = nVC.topViewController as? AccountViewController {
                        aVC.provider = provider
                    }
                }
            }
        }
    }
}
