import Foundation
import SwiftyJSON

struct ChatMessage {
    let id: Int
    let chatId: Int
    let userId: Int
    let message: String
    let createdAt: Date
    let user: User
}

extension ChatMessage: JSONAbleType {
    static func fromJSON(_ json: [String : Any]) -> ChatMessage {
        let json = JSON(json)
        
        let id = json["id"].intValue
        let chatId = json["chat_id"].intValue
        let userId = json["users_id"].intValue
        let message = json["message"].stringValue
        
        let date = ISO8601DateFormatter().date(from: json["created_at"].stringValue)!
        
        let user = User.fromJSON(json["user"].dictionaryObject!)
        
        return ChatMessage(id: id, chatId: chatId, userId: userId, message: message, createdAt: date, user: user)
    }
}
