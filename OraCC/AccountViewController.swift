import UIKit
import Moya
import SVProgressHUD

class AccountViewController: UITableViewController {

    var provider: RxMoyaProvider<OraAPI>!
    lazy var viewModel: AccountViewModel = {
        return AccountViewModel(provider: self.provider, user: User.currentUser()!)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        viewModel.showMessage.subscribe(onNext:{ [weak self] message in
            
            self?.showAlertWithTitle(message.title, message: message.body)
            
        }).addDisposableTo(rx_disposeBag)
        
        viewModel.showSpinner.subscribe(onNext:{
            if $0 {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
            
        }).addDisposableTo(rx_disposeBag)
        
        viewModel.didSaveSuccessful.subscribe(onNext:{ [weak self] in
            self?.showAlertWithTitle("Save Successful", message: nil)
            self?.tableView.reloadData()
        }).addDisposableTo(rx_disposeBag)
    }
    
    func showAlertWithTitle(_ title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true){}
    }
    
    @IBAction func save(_ sender: Any) {
        tableView.resignFirstResponderVisibleRows()
        
        viewModel.save()
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
