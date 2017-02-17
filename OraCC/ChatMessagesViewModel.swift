import Foundation
import Moya
import NSObject_Rx
import RxSwift
import RxCocoa

class ChatMessagesViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    internal var chatId: Int
    
    internal var messages: [ChatMessage] = []
    
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
    
    var shouldReload = PublishSubject<Void>()
    var showSpinner = Variable<Bool>(true)
    
    internal var isReload = false
    
    var endOfMessages = false
    
    var showMessage = PublishSubject<Message>()
    
    init(chatId: Int, provider: RxMoyaProvider<OraAPI>){
        self.provider = provider
        self.chatId = chatId
        
        super.init()
    }
    
    func reload() {
        page = 1
        isReload = true
        endOfMessages = false
    }
    
    func loadNextPage() {
        if !endOfMessages {
            page += 1
            loadCurrentPage()
        }
    }
    
    func loadCurrentPage() {
        reqestPart()
    }
    
    func reqestPart() {
        
        showSpinner.value = true
        
        provider.request(.chatMessages(id: chatId, page: page, pageSize: pageSize))
            .subscribe(onNext:{[weak self] response in
                
                guard let strongSelf = self else { return }
                
                strongSelf.showSpinner.value = false
                
                do {
                    let json = try response.mapJSON() as? [String: Any]
                    let data = json?["data"] as? [[String: Any]]
                    let messages = data?.map{ChatMessage.fromJSON($0)}
                    
                    if strongSelf.isReload {
                        strongSelf.messages.removeAll()
                    }
                    
                    if let messages = messages {
                        strongSelf.messages.append(contentsOf: messages)
                        if messages.count < strongSelf.pageSize{
                            strongSelf.endOfMessages = true
                        }
                    } else {
                        strongSelf.endOfMessages = true
                    }
                    
                } catch {
                    strongSelf.endOfMessages = true
                }
                strongSelf.shouldReload.onNext()
                }, onError:{ [weak self] error in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.showSpinner.value = false
                    strongSelf.endOfMessages = true
                    strongSelf.shouldReload.onNext()
                    
                    strongSelf.showMessage.onNext(Message(title: "Network Error", body: "Please try later."))
                    
            })
            .addDisposableTo(rx_disposeBag)
    }
}
