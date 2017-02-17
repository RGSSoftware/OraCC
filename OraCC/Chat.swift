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

struct User {
    let id: Int
    let name: String
    let email: String
    
    static func setCurrentUser(_ user: User?){
        if let user = user {
            let dic = ["id": user.id,
                       "name": user.name,
                       "email": user.email] as [String : Any]
            UserDefaults.standard.set(dic, forKey: "currentUser")
        } else {
            UserDefaults.standard.removeObject(forKey: "currentUser")
        }
        
    }
    
    static func currentUser() -> User? {
        let dic = UserDefaults.standard.object(forKey: "currentUser") as! [String: Any]
        return User.fromJSON(dic)
    }
}

struct Chat {
    let id: Int
    let name: String
    let users: [User]?
    
    let lastMessage: ChatMessage?
}

protocol JSONAbleType {
    static func fromJSON(_: [String: Any]) -> Self
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

extension User: JSONAbleType {
    static func fromJSON(_ json: [String : Any]) -> User {
        let json = JSON(json)
        
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        
        return User(id: id, name: name, email: email)
    }
}

extension Chat: JSONAbleType {
    static func fromJSON(_ json: [String : Any]) -> Chat {
        let json = JSON(json)
        
        let id = json["id"].intValue
        let name = json["name"].stringValue
        
        var users: [User]?
        if let dataUsers = json["users"].array {
            users = dataUsers.map{User.fromJSON($0.dictionaryObject!)}
        }
        
        var lastMessage: ChatMessage?
        if let dataMessage = json["last_chat_message"].dictionaryObject {
            lastMessage = ChatMessage.fromJSON(dataMessage)
        }
        
        return Chat(id: id, name: name, users: users, lastMessage: lastMessage)
    }
}
