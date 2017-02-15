import UIKit
import Moya

class SplashViewController: UIViewController {
    
    var provider: RxMoyaProvider<OraAPI>!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = AuthenticationToken.token {
            performSegue(withIdentifier: R.segue.splashViewController.from_Splash_to_Chats, sender: nil)
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
    }
}
