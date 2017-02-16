import Foundation

struct PasswordValidator: ValidatorRepresentable {
    
    var isValid: Bool = false
    internal var validator: (String?) -> (Bool) = {
        guard let s = $0 else { return false }
        if s.characters.count <= 4 { return false }
        
        return s.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil ? false : true
    }
    var value: String? {
        didSet {
            isValid = validator(value)
        }
    }
    
    var errorMessage: String {
        return "Invalid password."
    }
}
