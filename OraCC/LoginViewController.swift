import UIKit
import Moya

class LoginViewController: UITableViewController {
    
    var provider: RxMoyaProvider<OraAPI>!
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel(provider: self.provider)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFields
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fieldCell, for: indexPath)
        cell?.viewModel = viewModel.fieldViewModelForIndexPath(indexPath)!
        
        return cell!
    }
}
