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
    
    func chatViewModelForIndex(_ indexPath: IndexPath) -> ChatViewModel {
        return ChatViewModel(chat: chatForIndex(indexPath))
    }
    
    var endOfUsers = Variable<Bool>(true)
    
    internal var insertedElementIndexes = VariablePublish<Array<IndexPath>>([])
    
    internal var pageSize: Int = 1
    internal var page: Int = 20
    
    init(provider: RxMoyaProvider<OraAPI>){
    self.provider = provider
        
    
    super.init()
    }
    
    func loadCurrentPage() {
//        reqestPart().addDisposableTo(rx_disposeBag)
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
                    

                    
                    print(strongSelf.daysDates)
                    print("////////")
                    print(strongSelf.chats)
                    
//                    print( chats )
                } catch {
                    
                }
            
        }).addDisposableTo(rx_disposeBag)
        
    }
}
