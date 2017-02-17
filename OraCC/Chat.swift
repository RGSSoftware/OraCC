import Foundation
import SwiftyJSON

struct Chat {
    let id: Int
    let name: String
    let users: [User]?
    
    let lastMessage: ChatMessage?
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
