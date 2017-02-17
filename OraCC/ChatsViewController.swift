import UIKit
import Moya
import UIScrollView_InfiniteScroll

class ChatsViewController: UITableViewController {

    var provider: RxMoyaProvider<OraAPI>!
    lazy var viewModel: ChatsViewModel = {
        return ChatsViewModel(provider: self.provider)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reload(_:)), for: .valueChanged)
        
        tableView.infiniteScrollIndicatorMargin = 40
        tableView.infiniteScrollTriggerOffset = 500
        
        viewModel.showMessage.subscribe(onNext:{ [weak self] message in
            let alert = UIAlertController(title: message.title, message: message.body, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self?.present(alert, animated: true){}
            
        }).addDisposableTo(rx_disposeBag)
        
        tableView.addInfiniteScroll { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.viewModel.loadNextPage()
        }
        
        viewModel.endOfChats.asObservable().bindNext{[weak self] isEnd in
            guard let strongSelf = self else { return }
            
            strongSelf.tableView.setShouldShowInfiniteScrollHandler{ _ in return !isEnd}
            }.addDisposableTo(rx_disposeBag)
        
        
        viewModel.shouldReload.asObservable().bindNext{ [weak self] indexes in
            guard let strongSelf = self else { return }
            
            strongSelf.tableView.reloadData()
            strongSelf.tableView.finishInfiniteScroll()
            strongSelf.refreshControl?.endRefreshing()
            
            }.addDisposableTo(rx_disposeBag)
        
        tableView.beginInfiniteScroll(true)
    }
    
    func reload(_ sender: Any) {
        viewModel.reload()
        viewModel.loadNextPage()
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
