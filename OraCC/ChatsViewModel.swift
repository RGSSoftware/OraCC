import Foundation
import Moya
import NSObject_Rx
import RxSwift
import RxCocoa

class ChatsViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    
    internal var chats: [[Chat]] = []
    internal var daysDates: [Date: [Chat]] = [:]
    
    func numberOfSection() -> Int {
        return chats.count
    }
    
    func numberOfChatsSection(_ section: Int) -> Int {
        return chats[section].count
    }
    
    func chatForIndex(_ indexPath: IndexPath) -> Chat {
        return chats[indexPath.section][indexPath.row]
    }
    
    func titleForSection(_ section: Int) -> String {
        let chat = chats[section].first
        if NSCalendar.current.isDate(Date(), inSameDayAs: (chat?.lastMessage?.createdAt)!) {
            return "Today"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d"
            return dateFormatter.string(from: (chat?.lastMessage?.createdAt)!)
        }
    }
    
    func chatIdForIndex(_ indexPath: IndexPath) -> Int {
        return chatForIndex(indexPath).id
    }
    
    func chatViewModelForIndex(_ indexPath: IndexPath) -> ChatViewModel {
        return ChatViewModel(chat: chatForIndex(indexPath))
    }
    
    var endOfChats = VariablePublish<Bool>(true)
    var shouldReload = PublishSubject<Void>()
    
    var showMessage = PublishSubject<Message>()
    
    internal var isReload = false
    
    internal var page: Int = 0
    internal var pageSize: Int = 20
    
    init(provider: RxMoyaProvider<OraAPI>){
    self.provider = provider
        
    
    super.init()
    }
    
    func reload() {
        page = 0
        isReload = true
    }
    
    func loadNextPage() {
        page += 1
        loadCurrentPage()
    }
    
    func loadCurrentPage() {
        reqestPart()
    }
    
    func reqestPart() {
        
        provider.request(.chats(page: page, pageSize: pageSize))
            .subscribe(onNext:{ [weak self] response in
                                
                guard let strongSelf = self else { return }
                
                do {
                    let json = try response.mapJSON() as? [String: Any]
                    let data = json?["data"] as? [[String: Any]]
                    let chats = data?.map{Chat.fromJSON($0)}
                    
                    if strongSelf.isReload {
                        strongSelf.daysDates.removeAll()
                        strongSelf.endOfChats.value = false
                    }
                    
                    chats?.forEach{
                        if let message = $0.lastMessage {
                            let startDate = NSCalendar.current.startOfDay(for: message.createdAt)
                            if var cs = strongSelf.daysDates[startDate] {
                                cs.append($0)
                                cs.sort(by: {
                                    
                                    guard let i = $0.lastMessage else { return false }
                                    guard let j = $1.lastMessage else { return false }
                                    
                                    return i.createdAt > j.createdAt
                                    
                                })
                                strongSelf.daysDates[startDate] = cs
                            } else {
                                strongSelf.daysDates[startDate] = [$0]
                            }
                            
                        }
                    }
                    
                    strongSelf.chats = Array(strongSelf.daysDates.values.map{$0})
                    strongSelf.chats.sort(by: {
                        
                        guard let i = ($0.first)?.lastMessage else { return false }
                        guard let j = ($1.first)?.lastMessage else { return false }
                        
                        return i.createdAt > j.createdAt
            
                    })
                    
                    if (chats?.count)! < strongSelf.pageSize{
                        strongSelf.endOfChats.value = true
                    }

                } catch {
                    strongSelf.endOfChats.value = true
                    
                }
                
                strongSelf.shouldReload.onNext()
                strongSelf.isReload = false
                
                }, onError:{ [weak self] error in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.endOfChats.value = true
                    strongSelf.shouldReload.onNext()
                    strongSelf.showMessage.onNext(Message(title: "Network Error", body: "Please try later."))
                    
            }).addDisposableTo(rx_disposeBag)
        
    }
}
