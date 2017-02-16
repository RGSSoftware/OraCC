import Foundation

struct TextValidator: ValidatorRepresentable {
    
    var isValid: Bool = false
    internal var validator: (String?) -> (Bool) = {
        guard let s = $0 else { return false }
        return s.characters.count <= 4 ? false : true
    }
    var value: String? {
        didSet {
            isValid = validator(value)
        }
    }
    
    var errorMessage: String {
        return "Invalid value."
    }
}
