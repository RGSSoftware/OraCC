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
        
        viewModel.showMessage.subscribe(onNext:{ [weak self] message in
            let alert = UIAlertController(title: message.title, message: message.body, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self?.present(alert, animated: true){}
        
        }).addDisposableTo(rx_disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RegisterViewController{
            let rVC = segue.destination as! RegisterViewController
            
            rVC.provider = provider
        }
    }
    
    @IBAction func login(_ sender: Any) {
        tableView.resignFirstResponderVisibleRows()
        
        viewModel.login()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFields
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fieldCell, for: indexPath)
        cell?.viewModel = viewModel.fieldViewModelForIndexPath(indexPath)!
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let cell = tableView.cellForRow(at: indexPath) as! FieldCell
        cell.viewModel = viewModel.fieldViewModelForIndexPath(indexPath)!
        cell.textField.becomeFirstResponder()
        
    }
}
