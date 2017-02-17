import Foundation
import SwiftyJSON

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

extension User: JSONAbleType {
    static func fromJSON(_ json: [String : Any]) -> User {
        let json = JSON(json)
        
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        
        return User(id: id, name: name, email: email)
    }
}
