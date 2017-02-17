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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: R.segue.chatsViewController.from_Chats_to_Chat, sender: viewModel.chatIdForIndex(indexPath))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.chatsViewController.from_Chats_to_Chat.identifier {
            if let cVC = segue.destination as? ChatViewController {
                cVC.chatId = sender as? Int
                cVC.provider = provider
            }
        }
    }
}
