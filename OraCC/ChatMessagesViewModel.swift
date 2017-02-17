import Foundation
import Moya
import NSObject_Rx
import RxSwift
import RxCocoa

class ChatMessagesViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    internal var chatId: Int
    
    internal var messages: [ChatMessage] = []
    var endOfUsers = Variable<Bool>(true)
        
    internal var pageSize: Int = 1
    internal var page: Int = 20
    
    var numberOfMessages: Int {
        return messages.count
    }
    
    func messageBodyForIndex(_ indexPath: IndexPath) -> String {
        return messages[indexPath.row].message
    }
    
    func messageUserIdForIndex(_ indexPath: IndexPath) -> Int {
        return messages[indexPath.row].userId
    }
    
    func userForIndex(_ indexPath: IndexPath) -> User {
        return messages[indexPath.row].user
    }
    
    
    init(chatId: Int, provider: RxMoyaProvider<OraAPI>){
        self.provider = provider
        self.chatId = chatId
        
        super.init()
    }
    
    func loadCurrentPage() {
        reqestPart()
    }
    
    func reqestPart() {
        provider.request(.chatMessages(id: chatId, page: page, pageSize: pageSize))
            .subscribe(onNext:{[weak self] response in
                
                guard let strongSelf = self else { return }
            
                do {
                    let json = try response.mapJSON() as? [String: Any]
                    let data = json?["data"] as? [[String: Any]]
                    let messages = data?.map{ChatMessage.fromJSON($0)}
                    
                    if messages != nil {
                        strongSelf.messages = messages!
                    }
                    
                } catch {
                    
                }
            
            })
            .addDisposableTo(rx_disposeBag)
    }
}
