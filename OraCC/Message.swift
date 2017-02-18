import Foundation

struct Message {
    let title: String
    let body: String?
    
    static func networkError() -> Message {
        return Message(title: "Network Error", body: "Please try later.")
    }
    
    static func registerError() -> Message {
        return Message(title: "Register Error", body: "Please check your submitted info and try again.")
    }
    
    static func loginError() -> Message {
        return  Message(title: "Login Error", body: "Please check your submitted info and try again.")
    }
    
    static func saveFormError() -> Message {
        return  Message(title: "Save Error", body: "Please check your submitted info and try again.")
    }
    
}
