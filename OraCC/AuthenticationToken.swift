import Foundation

struct AuthenticationToken {
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "authenticationToken")
        }
        
        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "authenticationToken")
        }
    }
}
