import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = AuthenticationToken.token {
            performSegue(withIdentifier: "from_Splash_to_Chats", sender: nil)
        } else {
            performSegue(withIdentifier: "from_Splash_to_Login", sender: nil)
        }
    }
}
