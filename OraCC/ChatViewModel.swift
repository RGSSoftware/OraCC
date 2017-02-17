import Foundation

class ChatViewModel: NSObject {
    
    internal var chat: Chat

    var subTitle: String? {
        guard let lastMessage = chat.lastMessage else { return nil }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.maximumUnitCount = 2
        formatter.allowedUnits = [.day, .hour, .minute]
        
        let date = formatter.string(from: lastMessage.createdAt, to: Date())
        print(lastMessage.user.name)
        return lastMessage.user.name + " - " + date! + " ago"
        
    }
    
    var message: String? {
        guard let lastMessage = chat.lastMessage else { return nil }
        return lastMessage.message
    }
    
    init(chat: Chat){
        self.chat = chat
        super.init()
    }

}
