import Foundation

class Field {
    let label: String
    let placeholder: String
    var value: String? {
        didSet {
            validator.value = value
        }
    }
    var validator: Validator
    
    init(label: String, placeholder: String, value: String? = nil, validator: Validator) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.validator = validator
    }
}
