import UIKit
import Moya

class ChatsViewController: UITableViewController {

    var provider: RxMoyaProvider<OraAPI>!
    lazy var viewModel: ChatsViewModel = {
        return ChatsViewModel(provider: self.provider)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadCurrentPage()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfChatsSection(section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.headerCell.identifier)
        cell?.textLabel?.text = viewModel.titleForSection(section)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatCell.identifier, for: indexPath) as! ChatCell
        
        cell.viewModel = viewModel.chatViewModelForIndex(indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
