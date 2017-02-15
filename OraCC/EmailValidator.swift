import Foundation

class EmailValidator: Validator {
    
    var isValid: Bool = false
    internal var validator: (String?) -> (Bool) = {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: $0)
    }
    var value: String? {
        didSet {
            isValid = validator(value)
        }
    }
}
